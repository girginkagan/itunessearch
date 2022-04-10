//
//  APIErrorGenerator.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/10/22.
//

import Foundation

class APIErrorGenerator {
    func generateError(error: BaseErrorModel) -> String {
        var alertText = ""
        if let errors = error.errors {
            for errorModel in errors {
                alertText += (errorModel.message ?? "")
            }
        } else if let message = error.message {
            alertText = message
        }
        
        if alertText == "" {
            alertText = "An unknown error occured."
        }
        
        return alertText
    }
}
