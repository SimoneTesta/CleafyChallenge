//
//  ModelError.swift
//  SecureSDK
//
//  Created by Simone Testa on 15/02/22.
//

import Foundation

enum ModelError: LocalizedError {
    case Serialization(String)
    case Deserialization(String)
    case Validation(String)
    
    var errorDescription: String? {
        switch self {
        case .Serialization(let description):
            return "Error during model serialization: \(description)"
        case .Deserialization(let description):
            return "Error during model deserialization: \(description)"
        case .Validation(let description):
            return "Model is not valid: \(description)"
        }
    }
}
