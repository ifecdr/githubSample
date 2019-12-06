//
//  Repos.swift
//  githubSampleApp
//
//  Created by Adesida, Ifeoluwa - Ifeoluwa on 12/6/19.
//  Copyright © 2019 Lowes. All rights reserved.
//

import Foundation

//struct Repos: Codable {
//    let totalCount: Int
//    let incompleteResults: Bool
//    let items: [Item]
//
//    enum CodingKeys: String, CodingKey {
//        case totalCount = "total_count"
//        case incompleteResults = "incomplete_results"
//        case items
//    }
//}

struct Repos: Codable {
    let id: Int
    let name, fullName: String
    let welcomePrivate: Bool
    let owner: Owner
    let htmlURL: String
    let url: String
    let stargazersURL: String
    let createdAt, updatedAt, pushedAt: Date
    let stargazersCount: Int
    let forksCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case welcomePrivate = "private"
        case owner
        case htmlURL = "html_url"
        case url
        case stargazersURL = "stargazers_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: String
    let id: Int
    let avatarURL: String
    let url, htmlURL: String
    let reposURL: String

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case url
        case htmlURL = "html_url"
        case reposURL = "repos_url"
    }
}
