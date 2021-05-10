//
//  CreateTaskCoordinator.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 17.03.2021.
//
import UIKit

class TaskCreationCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    
    // MARK: - CoordinatorFinishOutput
    
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    
    // MARK: - Coordinator
    
    override func start() {
        self.showCreateTaskViewController()
    }
    
    // MARK: - Init
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }
    
    // MARK: - Private methods
    
    private func showCreateTaskViewController() {
        let viewModel = CreateTaskViewModel(taskService: TaskServiceImplementation(repository: FirestoreTaskRepository()))
        viewModel.onGoToSubtaskCreation = { [unowned viewModel, unowned self] in
            showCreateSubtaskViewController(delegate: viewModel)
        }
        viewModel.onFinish = { [unowned self] in
            finishFlow?()
        }
        
        let viewController = viewControllerFactory.instantiateCreateTaskViewController()
        
        viewModel.delegate = viewController
        
        viewController.viewModel = viewModel

        router.setRootModule(viewController)
    }
    
    private func showCreateSubtaskViewController(delegate: AddSubtaskViewModelDelegate) {
        let viewModel = AddSubtaskViewModel()
        viewModel.delegate = delegate
        viewModel.onFinish = { [unowned self] in
            router.dismissModule()
        }
        let viewController = viewControllerFactory.instantiateAddSubtaskViewController()
        
        viewController.viewModel = viewModel
        router.presentWithBar(viewController, animated: true)
    }
}
