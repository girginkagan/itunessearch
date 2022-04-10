//
//  HomeViewModel.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/10/22.
//

import RxSwift
import RxCocoa

final class HomeViewModel: BaseViewModel {
    private let services: RestClient
    var coordinator: HomeCoordinator?
    let isError = BehaviorSubject<BaseErrorModel?>(value: nil)
    let disposeBag = DisposeBag()
    
    init(services: RestClient) {
        self.services = services
    }
    
    func setBindings() {
        
    }
}
