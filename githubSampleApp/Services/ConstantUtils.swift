//
//  ConstantUtils.swift
//  githubSampleApp
//
//  Created by Adesida, Ifeoluwa - Ifeoluwa on 12/5/19.
//  Copyright © 2019 Lowes. All rights reserved.
//

import Foundation

struct ConstantUtils {
    static let base = "https://api.github.com"
    static let search = "/search"
    static let users = "/users?q="
    static let repo = "/repos?q="
    static let topic = "?q=topic:"
    static let user = "+user:"
    static let repoSearch = "/repositories?q="
    
    static func getUsersUrl(userStr: String) -> String {
        return base + search + users + userStr
    }
    
    static func getSearchUrl(searchKeyword: String, userKeyword: String) -> String {
        return base + search + repoSearch + searchKeyword + user + userKeyword
    }
}
