//
//  GithubRequest.swift
//  SecureSDK
//
//  Created by Simone Testa on 15/02/22.
//

import Foundation

class GithubRequest {
    static func listStarGazers(owner: String, repository: String) throws -> URLRequest {
        guard let url = GithubEndpoint.ListStarGazers(owner, repository).url else {
            throw RequestError.BuildError("Cannot get url for ListStarGazers")
        }
        
        return try RequestBuilder.buildGet(url: url)
    }
}
