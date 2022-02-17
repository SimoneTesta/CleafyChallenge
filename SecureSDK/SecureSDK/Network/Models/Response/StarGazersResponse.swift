//
//  ListStarGazersResponse.swift
//  SecureSDK
//
//  Created by Simone Testa on 16/02/22.
//

import Foundation

public struct StarGazersResponse: Decodable {
    public let login: String
    public let id: Int
    public let node_id: String
    public let avatar_url: String
    public let gravatar_id: String
    public let url: String
    public let html_url: String
    public let followers_url: String
    public let following_url: String
    public let gists_url: String
    public let starred_url: String
    public let subscriptions_url: String
    public let organizations_url: String
    public let repos_url: String
    public let events_url: String
    public let received_events_url: String
    public let type: String
    public let site_admin: Bool
}
