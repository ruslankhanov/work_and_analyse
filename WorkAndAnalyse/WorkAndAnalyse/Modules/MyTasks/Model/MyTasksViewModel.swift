//
//  MyTasksViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 28.04.2021.
//

import Foundation

protocol MyTasksViewModelProtocol {
    var dataToPresent: [SectionViewModel] { get set }
    func loadDataToPresent()
    func updateTask(with model: CellViewModel, at indexPath: IndexPath)
}

protocol MyTasksViewModelDelegate: class {
    func didFailToLoadData(errorMessage: String)
    func didLoadData()
    func didUpdateData(in section: Int)
    func didCompleteFullTask(alertTitle: String, alertMessage: String)
}

class MyTasksViewModel: MyTasksViewModelProtocol {
    
    // MARK: - Vars & Lets
    var dataToPresent: [SectionViewModel] = []
    weak var delegate: MyTasksViewModelDelegate?
    
    private let taskService: TaskService
    
    private var tasks: [Task] = []
    
    // MARK: - Init
    
    init(taskService: TaskService) {
        self.taskService = taskService
    }
    
    // MARK: - Public methods
    
    func loadDataToPresent() {
        dataToPresent = []
        taskService.loadTasks(type: .missing) { [weak self] response in
            guard let self = self else { return }
            self.loadTasks(response: response, title: "Missing")
        }
        taskService.loadTasks(type: .next) { [weak self] response in
            guard let self = self else { return }
            self.loadTasks(response: response, title: "Next tasks")
        }
    }
    
    func updateTask(with model: CellViewModel, at indexPath: IndexPath) {
        if let model = model as? SubtaskViewModel {
            updateTask(with: model, at: indexPath)
        } else if let model = model as? TaskViewModel {
            updateTask(with: model, at: indexPath)
        }
        delegate?.didUpdateData(in: indexPath.section)
    }
    
    // MARK: - Private methods
    
    private func loadTasks(response: Result<[Task], Error>, title: String) {
        switch response {
        case .failure(let error):
            self.delegate?.didFailToLoadData(errorMessage: error.localizedDescription)
        case .success(let result):
            let section = SectionViewModel(title: title)
            
            section.cells.append(contentsOf: result.map { task in
                let taskModel = TaskViewModel(task: task, children: [])
                
                let subtaskModels = task.subtasks.map { subtask in
                    SubtaskViewModel(subtask: subtask, parent: taskModel)
                }
                
                taskModel.children = subtaskModels
                
                return taskModel
            })
            self.dataToPresent.append(section)
            self.delegate?.didLoadData()
        }
    }
    
    private func updateTask(with taskViewModel: TaskViewModel, at indexPath: IndexPath) {
        taskViewModel.task.subtasks.forEach { $0.completed = true }
        removeFromVisibleData(model: taskViewModel, indexPath: indexPath)
        
        delegate?.didCompleteFullTask(alertTitle: "Congratulations!", alertMessage: "You've just completed your task!")
        
        updateTaskInDB(task: taskViewModel.task)
    }
    
    private func updateTask(with subtaskViewModel: SubtaskViewModel, at indexPath: IndexPath) {
        subtaskViewModel.subtask.completed.toggle()
            if let parent = subtaskViewModel.parent {
                if parent.isCompleted {
                    let index = dataToPresent[indexPath.section].cells.firstIndex { $0 === parent }
                    
                    guard index != nil else { return }
                    removeFromVisibleData(model: parent, indexPath: IndexPath(row: index!, section: indexPath.section))
                    delegate?.didCompleteFullTask(alertTitle: "Congratulations!", alertMessage: "You've just completed your task!")
                }
                updateTaskInDB(task: parent.task)
            }
    }
    
    private func updateTaskInDB(task: Task) {
        taskService.updateTask(task: task) { [weak self] error in
            if let error = error {
                self?.delegate?.didFailToLoadData(errorMessage: error.localizedDescription)
            }
        }
    }
    
    private func removeFromVisibleData(model: TaskViewModel, indexPath: IndexPath) {
        var range = indexPath.row...indexPath.row
        if !model.isCollapsed {
            range = indexPath.row...(indexPath.row + model.children.count)
        }
        
        self.dataToPresent[indexPath.section].cells.removeSubrange(range)
    }
}
