//
//  Item.swift
//  githubSampleApp
//
//  Created by Adesida, Ifeoluwa - Ifeoluwa on 12/5/19.
//  Copyright © 2019 Lowes. All rights reserved.
//

import Foundation

struct Items: Codable {
    let login: String
    let id: Int
    let avatarURL: String
    let url: String
    let htmlURL: String
    let followersURL: String
    let followingURL: String
    let reposURL: String
    let name: String?
    let location: String?
    let email: String?
    let bio: String?
    let publicRepos: Int?
    let followers: Int?
    let following: Int?
    let forks: Int?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarURL = "avatar_url"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case reposURL = "repos_url"
        case name
        case location
        case email
        case bio
        case publicRepos = "public_repos"
        case followers
        case following
        case forks
        case createdAt = "created_at"
    }
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        login = try value.decode(String.self, forKey: .login)
        id = try value.decode(Int.self, forKey: .id)
        avatarURL = try value.decode(String.self, forKey: .avatarURL)
        url = try value.decode(String.self, forKey: .url)
        htmlURL = try value.decode(String.self, forKey: .htmlURL)
        followersURL = try value.decode(String.self, forKey: .followersURL)
        followingURL = try value.decode(String.self, forKey: .followingURL)
        reposURL = try value.decode(String.self, forKey: .reposURL)
        name = try value.decodeIfPresent(String.self, forKey: .name)
        location = try value.decodeIfPresent(String.self, forKey: .location)
        email = try value.decodeIfPresent(String.self, forKey: .email)
        bio = try value.decodeIfPresent(String.self, forKey: .bio)
        publicRepos = try value.decodeIfPresent(Int.self, forKey: .publicRepos)
        followers = try value.decodeIfPresent(Int.self, forKey: .followers)
        following = try value.decodeIfPresent(Int.self, forKey: .following)
        forks = try value.decodeIfPresent(Int.self, forKey: .forks)
        createdAt = try value.decodeIfPresent(String.self, forKey: .createdAt)
    }
}
