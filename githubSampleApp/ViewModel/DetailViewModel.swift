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
    var user: User!
    var repos: [Repos] = [Repos]() {
        didSet {
            delegate?.reloadTable()
        }
    }
    weak var delegate: DetailViewModelDelegate?
    
    func numberOfRepos() -> Int {
        return repos.count
    }
    
    func getUser() -> User {
        return user
    }
    
    func fetchImage(_ imageUrl: String, completion: @escaping (Data?) -> ()) {
        ApiServices.shared.getAvatarImage(imageUrl) { result in
            completion(result)
        }
    }
    
    func fetchRepos() {
        let repoStr = user.reposURL
        ApiServices.shared.getRepos(repoStr) { [unowned self] result in
            switch result {
            case .failure(let err):
                fatalError("\(err.localizedDescription)")
            case .success(let reposArray):
                self.repos = reposArray
            }
        }
    }
}
