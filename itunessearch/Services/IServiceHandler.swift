//
//  IServiceHandler.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/10/22.
//

import Foundation

protocol IServiceHandler {
    func getData(offset: Int, q: String, wrapperType: WrapperType, successCompletion: @escaping(DataResponseModel) -> (), errorCompletion: @escaping(BaseErrorModel) -> ())
}
