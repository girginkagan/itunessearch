//
//  GetDataRequest.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/11/22.
//

import Foundation

class GetDataApiRequest: BaseRequest {
    public var requestBodyObject: BaseObject?
    public var requestMethod = RequestHttpMethod.Get
    public var requestPath: String = "search"
    
    init(offset: Int, q: String, wrapperType: WrapperType) {
        requestPath += "?term=\(q)&media=\(wrapperType)&offset=\(offset)&limit=20"
    }
}
