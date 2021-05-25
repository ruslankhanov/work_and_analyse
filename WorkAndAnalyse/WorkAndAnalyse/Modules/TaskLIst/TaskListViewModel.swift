//
//  TaskListViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 28.04.2021.
//

import Foundation

class TaskListViewModel: TaskListViewModelProtocol {
    
    // MARK: - Vars & Lets
    var dataToPresent: [SectionViewModel] = []
    weak var delegate: TaskListViewModelDelegate?
    
    private let taskService: TaskService
    private let taskTypes: [TasksType]
    
    private var tasks: [Task] = []
    
    // MARK: - Init
    init(taskService: TaskService, taskTypes: [TasksType]) {
        self.taskService = taskService
        self.taskTypes = taskTypes
    }
    
    // MARK: - Public methods
    
    func loadDataToPresent() {
        dataToPresent = []
        for type in taskTypes {
            taskService.loadTasks(type: type) { [weak self] response in
                guard let self = self else { return }
                self.loadTasks(response: response, title: type.rawValue)
            }
        }
    }
    
    func updateTask(with model: CellViewModel, at indexPath: IndexPath) {
        if let model = model as? SubtaskViewModel {
            updateTask(with: model, at: indexPath)
        } else if let model = model as? TaskViewModel {
            updateTask(with: model, at: indexPath)
        }
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
        if taskViewModel.isCompleted {
            taskViewModel.task.subtasks.forEach { $0.completed = false }
        } else {
            taskViewModel.task.subtasks.forEach { $0.completed = true }
        }
        
        var range = indexPath.row...indexPath.row
        if !taskViewModel.isCollapsed {
            range = indexPath.row...(indexPath.row + taskViewModel.children.count)
        }
        
        updateTaskInDB(task: taskViewModel.task)
        delegate?.didUpdateData(at: range.getIndexPaths(in: indexPath.section))
    }
    
    private func updateTask(with subtaskViewModel: SubtaskViewModel, at indexPath: IndexPath) {
        guard let parent = subtaskViewModel.parent else { return }
        
        subtaskViewModel.subtask.completed.toggle()
        
        var indexPathToUpdate = [indexPath]
        let index = dataToPresent[indexPath.section].cells.firstIndex { $0 === parent }
        
        guard index != nil else { return }
        indexPathToUpdate = [IndexPath(row: index!, section: indexPath.section), indexPath]
        
        updateTaskInDB(task: parent.task)
        delegate?.didUpdateData(at: indexPathToUpdate)
    }
    
    private func updateTaskInDB(task: Task) {
        taskService.updateTask(task: task) { [weak self] error in
            if let error = error {
                self?.delegate?.didFailToLoadData(errorMessage: error.localizedDescription)
            }
        }
    }
}
