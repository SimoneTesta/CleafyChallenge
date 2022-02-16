//
//  NetworkManagerProtocol.swift
//  SecureSDK
//
//  Created by Simone Testa on 16/02/22.
//

import Foundation

protocol NetworkManagerProtocol {
    func performRequest(request: URLRequest,
                        _ completition: @escaping (Result<Data,Error>) -> ())
}
