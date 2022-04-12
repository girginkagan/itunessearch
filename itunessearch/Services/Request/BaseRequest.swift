//
//  BaseRequest.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/10/22.
//

import Alamofire

public protocol BaseRequest {
    var requestMethod: RequestHttpMethod { get }
    var requestBodyObject: BaseObject? { get }
    var requestPath: String {get}
    func request() -> URLRequest
}


extension BaseRequest {
    var enviroment: Environment {
#if DEV
        return Environment.Dev
#elseif PROD
        return Environment.Prod
#endif
    }

    public func request() -> URLRequest {
        let url: URL! = URL(string: baseUrl + requestPath)
        var request = URLRequest(url: url)
        switch requestMethod {
        case .Get:
            request.httpMethod = "GET"
            break
        case .Post:
            request.httpMethod = "POST"
            if(requestBodyObject != nil) {
                let jsonEncoder = JSONEncoder()
                do {
                    request.httpBody = try jsonEncoder.encode(requestBodyObject)
                } catch {
                    print(error)
                }
            }
            break
        default:
            request.httpMethod = "GET"
            break
        }
        return request
    }
    
    
    var baseUrl: String {
        switch enviroment {
        case .Prod:
            return "https://itunes.apple.com/"
        default:
            return "https://itunes.apple.com/"
        }
    }
}

public enum RequestHttpMethod {
    case Get
    case Post
    case Patch
}

public enum Environment {
    case Prod
    case Dev
}
