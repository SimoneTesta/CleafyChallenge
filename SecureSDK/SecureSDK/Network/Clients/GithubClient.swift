//
//  GithubClient.swift
//  SecureSDK
//
//  Created by Simone Testa on 16/02/22.
//

import Foundation

class GithubClient {
    static func getListStarGazers(owner: String,
                                  repository: String,
                                  _ completition: @escaping (Result<ListStarGazersResponse, Error>) -> Void) throws {
        let request = try GithubRequest.listStarGazers(owner: owner, repository: repository)
        NetworkManager.shared.performRequest(request: request) { result in
            do {
                switch result {
                case .success(let data):
                    let listStargazers = try ResponseDecoder.deserializeJSON(data: data) as ListStarGazersResponse
                    completition(.success(listStargazers))
                case .failure(let error):
                    completition(.failure(error))
                }
            } catch {
                completition(.failure(error))
            }
        }
    }
}
