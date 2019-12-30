//
//  RequestManager.swift
//  EngieerAiTest_Vidhi
//
//  Created by MAC105 on 30/12/19.
//  Copyright © 2019 MAC105. All rights reserved.
//

import Foundation
import Alamofire

struct RequestHttp {
    var url : String!
    var method : HTTPMethod!
    var parameter : [String : Any]!
    var header : HTTPHeaders!
}

class RequestManager{
    static let share : RequestManager = RequestManager()

    func requestWithGet(_ url : String,completion: @escaping(_ success: Bool,_ response : Data,_ message : String ) -> Void) {
        let request = self.createBody(url, method: .get, header: self.basicHeader, parameters: [:])
        self.sendRequest(request: request) { (status, result, message) in
            completion(status, result, message)
        }
    }
    func sendRequest(request : RequestHttp,completion: @escaping(_ success: Bool,_ response : Data,_ message : String ) -> Void){
        Alamofire.request(request.url, method: request.method, parameters: request.parameter, encoding: URLEncoding.default, headers: request.header).responseData { (response) in
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    completion(true,response.result.value ?? Data(),"")
                    break
                case .failure:
                    completion(false,Data(),response.error?.localizedDescription ?? "")
                    break
                }
            }
        }
    }
    func createBody(_ url :String, method : HTTPMethod, header : HTTPHeaders,parameters : [String: Any]) -> RequestHttp{
        let request = RequestHttp(url: url, method: method, parameter: parameters, header: header)
        return request
    }
    private var basicHeader : HTTPHeaders {
        let basicHeader = ["Content-Type" : "Application/Json","Accept": "Application/Json"]
        return basicHeader
    }
}
