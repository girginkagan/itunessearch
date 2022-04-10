//
//  BaseErrorModel.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/10/22.
//

import Foundation

public struct BaseErrorModel: Codable {
    public var errorCode: Int?
    public let message: String?
    public let errors: [ErrorData]?
    
    public init(errorCode: Int?, message: String?, errors: [ErrorData]?) {
        self.message = message
        self.errors = errors
        self.errorCode = errorCode
    }
}

public struct ErrorData: Codable {
    public let field, message: String?
    
    public init(field: String?, message: String?) {
        self.field = field
        self.message = message
    }
}
