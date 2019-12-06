//
//  Item.swift
//  githubSampleApp
//
//  Created by Adesida, Ifeoluwa - Ifeoluwa on 12/5/19.
//  Copyright © 2019 Lowes. All rights reserved.
//

import Foundation

struct Item: Codable {
    let login: String
    let id: Int
    let avatarURL: String
    let url: String
    let htmlURL: String
    let followersURL: String
    let followingURL: String
    let reposURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarURL = "avatar_url"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case reposURL = "repos_url"
    }
}
