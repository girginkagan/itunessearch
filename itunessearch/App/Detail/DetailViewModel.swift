//
//  DetailViewModel.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/12/22.
//

import RxSwift
import RxCocoa

final class DetailViewModel: BaseViewModel {
    private let services: RestClient
    var coordinator: DetailCoordinator?
    let disposeBag = DisposeBag()
    
    init(services: RestClient) {
        self.services = services
    }
    
    func setBindings() {
        
    }
}
