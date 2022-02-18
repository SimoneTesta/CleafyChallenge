//
//  RequestBuilder.swift
//  SecureSDK
//
//  Created by Simone Testa on 15/02/22.
//

import Foundation

class RequestBuilder {
    static func buildGet(url: URL,
                         queryParameters: [String:String]? = nil,
                         authenticator: AuthenticationProtocol? = nil) throws -> URLRequest {
        return try build(url: url,
                         method: HTTPMethod.Get,
                         queryParameters: queryParameters,
                         requestModel: nil,
                         authenticator: authenticator)
    }
    
    static func buildPost(url: URL,
                          queryParameters: [String:String]? = nil,
                          requestModel: RequestModelProtocol?,
                          authenticator: AuthenticationProtocol? = nil) throws -> URLRequest {
        return try build(url: url,
                         method: HTTPMethod.Post,
                         queryParameters: queryParameters,
                         requestModel: requestModel,
                         authenticator: authenticator)
    }
    
    private static func build(url: URL,
                              method: HTTPMethod,
                              queryParameters: [String:String]?,
                              requestModel: RequestModelProtocol?,
                              authenticator: AuthenticationProtocol?) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: url.absoluteString) else {
            throw RequestError.BuildError("Cannot get URL Components")
        }
        
        if let _queryParameters = queryParameters {
            urlComponents.percentEncodedQueryItems = []
            for (key, value) in _queryParameters {
                urlComponents.percentEncodedQueryItems?.append(URLQueryItem(name: key, value: value))
            }
        }
          
        guard let _url = urlComponents.url else {
            throw RequestError.BuildError("Cannot get URL")
        }
        
        var urlRequest = URLRequest(url: _url)
        
        urlRequest.httpMethod = method.rawValue
        
        if let _requestModel = requestModel {
            try _requestModel.validate()
            urlRequest.httpBody = try _requestModel.serialize()
        }
        
        if let _authenticator = authenticator {
            urlRequest = _authenticator.authenticate(request: urlRequest)
        }
        
        return urlRequest
    }
}
