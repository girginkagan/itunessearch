//
//  HomeCoordinator.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/10/22.
//

import UIKit

class HomeCoordinator: BaseCoordinator {
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    override func start() {
        let viewController = HomeViewController.instantiate()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.tintColor = UIColor(named: "AccentColor")
        navigationController.viewControllers = [viewController]
    }
    
    func presentDetail(data: Result) {
        let coordinator = AppDelegate.container.resolve(DetailCoordinator.self)!
        start(coordinator: coordinator)
        (navigationController.viewControllers.last as? DetailViewController)?.data = data
    }
}
