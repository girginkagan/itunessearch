//
//  DetailCoordinator.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/12/22.
//

import UIKit

class DetailCoordinator: BaseCoordinator {
    private let viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    override func start() {
        let viewController = DetailViewController.instantiate()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        parentCoordinator?.navigationController.pushViewController(viewController, animated: true)
    }
}
