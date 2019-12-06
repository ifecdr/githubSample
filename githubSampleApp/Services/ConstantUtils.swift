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
    static let sortByRepo = "+repos"
    static let greaterThan = ":%3E"
    
    static func getUsersUrl(userStr: String) -> String {
        return base + search + users + userStr
    }
}
