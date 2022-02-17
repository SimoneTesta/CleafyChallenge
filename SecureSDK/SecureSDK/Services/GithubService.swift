//
//  GithubService.swift
//  SecureSDK
//
//  Created by Simone Testa on 16/02/22.
//

import Foundation

public class GithubService: GithubServiceProtocol {
    public static let shared: GithubService = GithubService()
    
    private let security: SecurityProtocol
    private let logger: LoggerProtocol
    
    internal init(security: SecurityProtocol = Security.shared,
                  logger: LoggerProtocol = DebugLogger(className: "GithubService")) {
        self.security = security
        self.logger = logger
    }
    
    public func checkDeviceAndGetStargazers(for owner: String,
                                            in repo: String,
                                            _ completion: @escaping (Result<[StarGazersResponse], Error>) -> Void) {
        do {
            logger.log("Check device's security")
            try security.checkDevice()
            logger.log("Checked device's security")
            logger.log("Get StarGazers for owner: \(owner), repo: \(repo)")
            try GithubClient.getListStarGazers(owner: owner, repository: repo, completion)
        } catch {
            completion(.failure(error))
        }
    }
}
