//
//  GithubClient.swift
//  SecureSDK
//
//  Created by Simone Testa on 16/02/22.
//

import Foundation

class GithubClient {
    private static let logger: LoggerProtocol = DebugLogger(className: "GithubClient")
    
    static func getListStarGazers(owner: String,
                                  repository: String,
                                  _ completition: @escaping (Result<[StarGazersResponse], Error>) -> Void) throws {
        logger.log("Create getListStarGazers request")
        let request = try GithubRequest.listStarGazers(owner: owner, repository: repository)
        logger.log("Created getListStarGazers request")
        logger.log("Perform getListStarGazers request")
        NetworkManager.shared.performRequest(request: request) { result in
            do {
                switch result {
                case .success(let data):
                    logger.log("GetListStarGazers request succeded")
                    let listStargazers = try ResponseDecoder.deserializeJSONArray(data: data) as [StarGazersResponse]
                    completition(.success(listStargazers))
                case .failure(let error):
                    logger.log("GetListStarGazers request failed \(error.localizedDescription)")
                    completition(.failure(error))
                }
            } catch {
                completition(.failure(error))
            }
        }
    }
}
