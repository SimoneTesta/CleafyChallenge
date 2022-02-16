//
//  GithubEndpoint.swift
//  SecureSDK
//
//  Created by Simone Testa on 15/02/22.
//

import Foundation

enum GithubEndpoint: EndpointProtocol {
    case ListStarGazers(String, String)
    
    private var BASE_URL: String { return "https://api.github.com" }
    
    var url: URL? {
        switch self {
        case .ListStarGazers(let owner, let repo):
            return URL(string: "\(BASE_URL)/repos/\(owner)/\(repo)/stargazers")
        }
    }
}
