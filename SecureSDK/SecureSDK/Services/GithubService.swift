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
    
    init(security: SecurityProtocol = Security.shared) {
        self.security = security
    }
    
    func checkDeviceAndGetStargazers(for owner: String, in repo: String) {
        <#code#>
    }
}
