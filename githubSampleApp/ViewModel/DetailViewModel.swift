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
    var user: Items!
    var repos: [Items] = [Items]() {
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
        let userName = user.login
        ApiServices.shared.getRepos(searchStr, for: userName) { [unowned self] result in
            switch result {
            case .failure(let err):
                print(err.localizedDescription)
                return
            case .success(let reposArray):
                self.repos = reposArray
            }
        }
    }
}
