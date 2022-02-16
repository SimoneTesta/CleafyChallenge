//
//  NetworkError.swift
//  SecureSDK
//
//  Created by Simone Testa on 16/02/22.
//

import Foundation

enum NetworkError: LocalizedError {
    case BadRequest(String)
    case Authentication(String)
    case Forbidden(String)
    case ServerError(String)
    case Unknown(String)
    
    var errorDescription: String? {
        switch self {
        case .BadRequest(let description):
            return "Request is malformed: \(description)"
        case .Authentication(let description):
            return "Client is not authenticated: \(description)"
        case .Forbidden(let description):
            return "Access to resource is forbidden: \(description)"
        case .ServerError(let description):
            return "Server error: \(description)"
        case .Unknown(let description):
            return "Unknown error: \(description)"
        }
    }
    
    static func from(statusCode: Int, error: Error) -> Self {
        switch statusCode {
        case 400:
            return .BadRequest(error.localizedDescription)
        case 401:
            return .Authentication(error.localizedDescription)
        case 403:
            return .Forbidden(error.localizedDescription)
        case 500:
            return .ServerError(error.localizedDescription)
        default:
            return .Unknown(error.localizedDescription)
        }
    }
}
