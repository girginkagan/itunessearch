//
//  SplashViewController.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/10/22.
//

import UIKit
import RxSwift

final class SplashViewController: UIViewController, Storyboarded {

    static var storyboard = AppStoryboard.Splash
    var viewModel: SplashViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBindings()
    }
    
    private func setBindings() {
        guard let viewModel = viewModel else { return }
        
        viewModel.setBindings()
        
        viewModel.isError
            .bind { [weak self] data in
                if let errorData = data {
                    guard let self = self else { return }
                    AlertUtil.showStandardAlert(parentController: self, title: "Error", message: APIErrorGenerator().generateError(error: errorData))
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.getData()
    }

}

