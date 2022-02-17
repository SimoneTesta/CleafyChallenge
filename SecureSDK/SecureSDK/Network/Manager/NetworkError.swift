//
//  NetworkError.swift
//  SecureSDK
//
//  Created by Simone Testa on 16/02/22.
//

import Foundation

enum NetworkError: LocalizedError {
    case Connection
    case MissingData
    case BadRequest(String)
    case Authentication(String)
    case Forbidden(String)
    case ServerError(String)
    case Unknown(NSError?)
    
    var errorDescription: String? {
        switch self {
        case .Connection:
            return "Connection is not available"
        case .MissingData:
            return "Can't retrieve data"
        case .BadRequest(let description):
            return "Request is malformed: \(description)"
        case .Authentication(let description):
            return "Client is not authenticated: \(description)"
        case .Forbidden(let description):
            return "Access to resource is forbidden: \(description)"
        case .ServerError(let description):
            return "Server error: \(description)"
        case .Unknown(let error):
            return "Unknown error: \(error?.localizedDescription ?? "")"
        }
    }
    
    static func from(code: Int?, error: NSError?, message: String = "") -> Self {
        if let _code = code {
            switch _code {
            case 400:
                return .BadRequest(message)
            case 401:
                return .Authentication(message)
            case 403:
                return .Forbidden(message)
            case 500:
                return .ServerError(message)
            default:
                return .Unknown(error)
            }
        }
        if let _error = error {
            print(_error.code)
            switch _error.code {
            case -1020:
                return .Connection
            default:
                return .Unknown(error)
            }
        }
        return .Unknown(nil)
    }
}
