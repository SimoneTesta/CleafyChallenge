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
    private let logger: LoggerProtocol
    
    init(session: URLSession,
         logger: LoggerProtocol = DebugLogger(className: "NetworkManager")) {
        self.session = session
        self.logger = logger
    }
    
    func performRequest(request: URLRequest, _ completition: @escaping (Result<Data, Error>) -> ()) {
        logger.log("Start request to \(request.debugDescription)")
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            
            if let networkError = self?.checkResponse(request: request, error: error as NSError?, response: response as? HTTPURLResponse) {
                self?.logger.log("Request to \(request.url?.absoluteString ?? "") failed for \(networkError.localizedDescription)")
                completition(.failure(networkError))
                return
            }
            
            guard let _data = data else {
                self?.logger.log("Request to \(request.url?.absoluteString ?? "") failed for Cannot retrieve Data")
                completition(.failure(NetworkError.MissingData))
                return
            }
            
            completition(.success(_data))
        }
        task.resume()
    }
    
    private func checkResponse(request: URLRequest,
                               error: NSError?,
                               response: HTTPURLResponse?) -> NetworkError? {
        if let _error = error {
            return NetworkError.from(code: response?.statusCode, error: _error)
        }
        
        if response?.statusCode != 200 {
           return NetworkError.from(code: response?.statusCode, error: nil)
        }
        
        return nil
    }
}
