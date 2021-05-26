//
//  StatsViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 26.05.2021.
//

import Foundation


protocol StatsViewModelProtocol {
    var summaryData: [SectionViewModel] { get set }
    var segmentData: [SegmentViewModel] { get set }
    
    func loadData(at index: Int)
    func clearData()
}

protocol StatsViewModelDelegate: class {
    func didLoadSummaryData()
}

class StatsViewModel: StatsViewModelProtocol {
    var summaryData: [SectionViewModel] = []
    var segmentData: [SegmentViewModel] = []
    
    weak var delegate: StatsViewModelDelegate?
    
    private var tasks: [Task] = []
    private let taskService: TaskService
    
    init(taskService: TaskService) {
        self.taskService = taskService
        loadSegmentData()
    }
    
    func loadData(at index: Int) {
        switch index {
        case 0: break
        case 1:
            loadSummaryData()
        default:
            print("Cannot load")
        }
    }
    
    func clearData() {
        summaryData = []
        tasks = []
    }
    
    private func loadSegmentData() {
        segmentData = [
            SegmentViewModel(title: "Timeline", index: 0),
            SegmentViewModel(title: "Overview", index: 1)
        ]
    }
    
    private func loadSummaryData() {
        taskService.loadTasks(type: .all) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let tasks):
                self.tasks = tasks
                
                self.summaryData = [
                    SectionViewModel(title: "Records", cells: [
                        SummaryViewModel(title: "Max task duration", rightDetailText: self.getMaxTaskDuration().stringFromTimeInterval())
                    ]),
                    SectionViewModel(title: "Summary", cells: [
                        SummaryViewModel(title: "Total time", rightDetailText: self.getTotalTime().stringFromTimeInterval()),
                        SummaryViewModel(title: "Total tasks", rightDetailText: "\(self.getTotalTasks())")
                    ])
                ]
                
                self.delegate?.didLoadSummaryData()
            }
        }
    }
    
    private func getMaxTaskDuration() -> TimeInterval {
        if let max = tasks.map({ $0.duration }).max() {
            return max
        } else {
            return 0
        }
    }
    
    private func getTotalTime() -> TimeInterval {
        tasks.map({ $0.duration }).reduce(0, +)
    }
    
    private func getTotalTasks() -> Int {
        tasks.count
    }
}
