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
        DataProvider.shared.data.asObservable()
            .map { $0 != nil }.bind(to: isReady)
            .disposed(by: disposeBag)
    }
    
    func getData() {
        services.getData(offset: DataProvider.shared.data.value?.results?.count ?? 0, q: "test", wrapperType: .movie) { data in
            DataProvider.shared.data.accept(data)
        } errorCompletion: { [weak self] error in
            self?.isError.onNext(error)
        }
    }
}
