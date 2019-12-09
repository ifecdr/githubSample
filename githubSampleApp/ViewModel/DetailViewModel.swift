//
//  DetailViewModel.swift
//  githubSampleApp
//
//  Created by Adesida, Ifeoluwa - Ifeoluwa on 12/6/19.
//  Copyright © 2019 Lowes. All rights reserved.
//

import Foundation

protocol DetailViewModelDelegate: class {
    func reloadTable()
}

class DetailViewModel {
    
    var curTask: DispatchWorkItem!
    var queue: DispatchQueue = .global(qos: .default)
    var delay: TimeInterval = 0.35
    
    var user: Items!
    var repos: [Repos] = [Repos]() {
        didSet {
            delegate?.reloadTable()
        }
    }
    weak var delegate: DetailViewModelDelegate?
    
    func numberOfRepos() -> Int {
        return repos.count
    }
    
    func getUser() -> Items {
        return user
    }
    
    func fetchImage(_ imageUrl: String, completion: @escaping (Data?) -> ()) {
        ApiServices.shared.getAvatarImage(imageUrl) { result in
            completion(result)
        }
    }
    
    func fetchRepos(for searchStr: String) {
        curTask?.cancel()
        curTask = DispatchWorkItem(block: { [unowned self] in
            let userName = self.user.login
            ApiServices.shared.getRepos(searchStr, for: userName) { result in
                switch result {
                case .failure(let err):
                    print(err.localizedDescription)
                    return
                case .success(let reposArray):
                    self.repos = reposArray
                }
            }
        })
        queue.asyncAfter(deadline: .now() + delay, execute: curTask)
    }
}
