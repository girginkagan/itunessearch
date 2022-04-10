//
//  HomeViewController.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/10/22.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController, Storyboarded {
    static var storyboard = AppStoryboard.Home
    var viewModel: HomeViewModel?
    let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setBindings()
    }
    
    private func setUI() {
        navigationItem.title = "Search"
    }
    
    private func setBindings() {
        guard let viewModel = viewModel else { return }
        
        viewModel.isError
            .bind { [weak self] data in
                if let errorData = data {
                    guard let self = self else { return }
                    AlertUtil.showStandardAlert(parentController: self, title: "Error", message: APIErrorGenerator().generateError(error: errorData))
                }
            }
            .disposed(by: disposeBag)
    }
}
