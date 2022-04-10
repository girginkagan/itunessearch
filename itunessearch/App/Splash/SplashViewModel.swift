//
//  SplashViewModel.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/10/22.
//

import RxSwift

final class SplashViewModel: BaseViewModel {
    private let services: RestClient
    private let disposeBag = DisposeBag()
    var coordinator: SplashCoordinator?
    
    let isReady = BehaviorSubject<Bool>(value: false)
    let isError = BehaviorSubject<BaseErrorModel?>(value: nil)
    
    init(services: RestClient) {
        self.services = services
    }
    
    func setBindings() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isReady.onNext(true)
        }
        /*appDelegate.resultCharacters.asObservable()
            .map { $0 != nil }.bind(to: isReady)
            .disposed(by: disposeBag)*/
    }
}
