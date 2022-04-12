//
//  RestClient.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/10/22.
//

import Alamofire

public class RestClient: IServiceHandler {
    static let sharedInstance = RestClient()
    
    private func sendRequest<T: Codable>(_ request: BaseRequest, _ type: T.Type, successCompletion: @escaping(T) -> (), errorCompletion:  @escaping(BaseErrorModel) -> ()) {
        AF.request(request.request()).responseString { response in
            switch response.result {
                case .success(let json):
                if let data = json.replacingOccurrences(of: "\n", with: "").data(using: .utf8, allowLossyConversion: true), response.response!.statusCode == APIStatusCodes.Success.rawValue {
                    do {
                        let json = try JSONDecoder().decode(T.self, from: data)
                        successCompletion(json)
                    } catch {
                        print(error.localizedDescription)
                        errorCompletion(BaseErrorModel(errorCode: response.response!.statusCode, message: error.localizedDescription, errors: nil))
                    }
                }
                else {
                    print(response.result)
                    errorCompletion(BaseErrorModel(errorCode: response.response!.statusCode, message: "An unknown error occured.", errors: nil))
                }
                case .failure(let error):
                    errorCompletion(BaseErrorModel(errorCode: nil, message: nil, errors: [ErrorData(field: APIErrors.Alamofire.rawValue, message: error.localizedDescription)]))
                    print(error.localizedDescription)
            }
        }
    }
    
    func getData(offset: Int, q: String, wrapperType: WrapperType, successCompletion: @escaping (DataResponseModel) -> (), errorCompletion: @escaping (BaseErrorModel) -> ()) {
        let request = GetDataApiRequest(offset: offset, q: q, wrapperType: wrapperType)
        sendRequest(request, DataResponseModel.self, successCompletion: successCompletion, errorCompletion: errorCompletion)
    }
}
