//
//  UserSearchViewModel.swift
//  githubSampleApp
//
//  Created by Adesida, Ifeoluwa - Ifeoluwa on 12/5/19.
//  Copyright © 2019 Lowes. All rights reserved.
//

import Foundation

class UserSearchViewModel {
    var searchedUsers = [Item]() {
        didSet{
            
        }
    }
    
    func numberOfUsers() -> Int {
        return searchedUsers.count
    }
    
    func fetchUsers(keyword: String) {
        ApiServices.shared.getUsers(keyword) { [unowned self] result in
            switch result {
            case .success(let item):
                self.searchedUsers.removeAll()
                self.searchedUsers = item
            case .failure(let err):
                print("Error: \(err.localizedDescription)")
            }
        }
    }
}
