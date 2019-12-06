//
//  UserSearchViewModel.swift
//  githubSampleApp
//
//  Created by Adesida, Ifeoluwa - Ifeoluwa on 12/5/19.
//  Copyright © 2019 Lowes. All rights reserved.
//

import UIKit

protocol UserSearchViewModelDelegate: class {
    func reloadTable()
}

class UserSearchViewModel {
    weak var delegate: UserSearchViewModelDelegate?
    var searchedUsers = [Items]() {
        didSet{
            delegate?.reloadTable()
        }
    }
    
    func numberOfUsers() -> Int {
        return searchedUsers.count
    }
    
    func updateUsers(with detail: Items, at index: Int) {
        searchedUsers[index] = detail
    }
    
    func getUser(index: Int) -> Items {
        return searchedUsers[index]
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
    
    func fetchUserDetails(str: String, completion: @escaping (Items?) -> ()) {
        ApiServices.shared.fetchUserDetails(urlStr: str) { result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func fetchImage(_ imageUrl: String, completion: @escaping (Data?) -> ()) {
        ApiServices.shared.getAvatarImage(imageUrl) { result in
            completion(result)
        }
    }
}
