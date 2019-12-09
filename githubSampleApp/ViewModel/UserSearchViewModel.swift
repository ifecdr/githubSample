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
    
    var curTask: DispatchWorkItem!
    var detailTask: DispatchWorkItem!
    var queue: DispatchQueue = .global(qos: .default)
    var delay: TimeInterval = 0.35
    
    weak var delegate: UserSearchViewModelDelegate?
    var searchedUsers = [Items]() {
        didSet{
            delegate?.reloadTable()
        }
    }
    
    func numberOfUsers() -> Int {
        return searchedUsers.count
    }
//
//    func updateUsers(with detail: Items, at index: Int) {
//        searchedUsers[index] = detail
//    }
    
    func getUser(index: Int) -> Items {
        return searchedUsers[index]
    }
    
    func fetchUsers(keyword: String) {
        curTask?.cancel()
        curTask = DispatchWorkItem(block: { [unowned self] in
            ApiServices.shared.getUsers(keyword) { result in
                switch result {
                case .success(let item):
                    self.searchedUsers.removeAll()
                    self.searchedUsers = item
                case .failure(let err):
                    print("Error: \(err.localizedDescription)")
                }
            }
        })
        queue.asyncAfter(deadline: .now() + delay, execute: curTask)
        
    }
    
    func fetchUserDetails(str: String, completion: @escaping (Items?) -> ()) {
        detailTask?.cancel()
        detailTask = DispatchWorkItem(block: {
            ApiServices.shared.fetchUserDetails(urlStr: str) { result in
                switch result {
                case .success(let user):
                    completion(user)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        })
        queue.asyncAfter(deadline: .now() + delay , execute: detailTask)
    }
    
    func fetchImage(_ imageUrl: String, completion: @escaping (Data?) -> ()) {
        ApiServices.shared.getAvatarImage(imageUrl) { result in
            completion(result)
        }
    }
}
