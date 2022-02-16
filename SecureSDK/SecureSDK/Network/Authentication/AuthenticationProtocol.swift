//
//  AuthenticationProtocol.swift
//  SecureSDK
//
//  Created by Simone Testa on 15/02/22.
//

import Foundation

protocol AuthenticationProtocol {
    func authenticate(request: URLRequest) -> URLRequest
}
