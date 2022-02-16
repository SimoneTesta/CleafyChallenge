//
//  RequestError.swift
//  SecureSDK
//
//  Created by Simone Testa on 15/02/22.
//

import Foundation

enum RequestError: LocalizedError {
    case BuildError(String)
    
    var errorDescription: String? {
        switch self {
        case .BuildError(let description):
            return "Error in request build process: \(description)"
        }
    }
}
