//
//  NetworkManager.swift
//  SecureSDK
//
//  Created by Simone Testa on 16/02/22.
//

import Foundation

class NetworkManager: NetworkManagerProtocol {
    
    static let shared: NetworkManagerProtocol = NetworkManager(session: URLSession(configuration: .default))
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func performRequest(request: URLRequest, _ completition: @escaping (Result<Data, Error>) -> ()) {
        session.dataTask(with: request) { data, response, error in
            guard let _response = response as? HTTPURLResponse else {
                completition(.failure(NetworkError.Unknown("Cannot retrieve URLResponse")))
                return
            }
            
            if let _error = error {
                completition(.failure(NetworkError.from(statusCode: _response.statusCode, error: _error)))
                return
            }
            
            guard let _data = data else {
                completition(.failure(NetworkError.Unknown("Cannot retrieve Data")))
                return
            }
            
            completition(.success(_data))
        }
    }
    
}
