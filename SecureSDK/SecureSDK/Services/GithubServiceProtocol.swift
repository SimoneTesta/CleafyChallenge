//
//  GithubServiceProtocol.swift
//  SecureSDK
//
//  Created by Simone Testa on 16/02/22.
//

import Foundation

protocol GithubServiceProtocol {
    func checkDeviceAndGetStargazers(for owner: String, in repo: String, _ completion: @escaping (Result<[StarGazersResponse], Error>) -> Void)
}
