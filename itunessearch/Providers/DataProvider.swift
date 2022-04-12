//
//  DataProvider.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/11/22.
//

import RxCocoa
import RxSwift

final class DataProvider {
    let data = BehaviorRelay<DataResponseModel?>(value: nil)
    
    static let shared = DataProvider()
}
