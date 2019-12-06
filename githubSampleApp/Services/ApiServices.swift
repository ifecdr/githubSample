//
//  ApiServices.swift
//  githubSampleApp
//
//  Created by Adesida, Ifeoluwa - Ifeoluwa on 12/5/19.
//  Copyright © 2019 Lowes. All rights reserved.
//

import Foundation

final class ApiServices {
    static let shared = ApiServices()
    
    //private var enqueued = Set<String>()
    //private let cache = NSCache<NSString, NSData>()
    
    // create session allowing caching
    private let session: URLSession
    private init() {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.requestCachePolicy = .returnCacheDataElseLoad
        session = URLSession.init(configuration: config)
    }
    
    func getUsers(_ userStr: String, completion: @escaping (Result<[User], Error>) -> ()) {
        if let urlStr = URL(string: ConstantUtils.getUsersUrl(userStr: userStr)) {
            var itemArray = [User]()
            session.dataTask(with: urlStr) { (d, _, error) in
                if let err = error {
                    completion(.failure(err))
                }
                
                if let data = d {
                    do {
                        let responseData = try JSONDecoder().decode(UsersList.self, from: data)
                        
                        for item in responseData.items {
                            itemArray.append(item)
                        }
                        completion(.success(itemArray))
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
    }
    
    func fetchUserDetails(urlStr: String, completion: @escaping (Result<User, Error>) -> ()) {
        if let url = URL(string: urlStr) {
            session.dataTask(with: url) { (d, _, e) in
                if let err = e {
                    completion(.failure(err))
                }
                
                if let data = d {
                    do {
                        let responseData = try JSONDecoder().decode(User.self, from: data)
                        completion(.success(responseData))
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
    }
    
    func getAvatarImage(_ imgStr: String, completion: @escaping (Data?) -> ()) {
        guard let url = URL(string: imgStr) else {
            completion(nil)
            return
        }
        
        session.dataTask(with: url) { (d, _, error) in
            if let data = d {
                DispatchQueue.main.async {
                    completion(data)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func getRepos(_ strLink: String, completion: @escaping (Result<[Repos], Error>) -> ()) {
        guard let url = URL(string: strLink) else {
            return
        }
        var repoArray = [Repos]()
        session.dataTask(with: url) { (d, _, error) in
            if let err = error {
                completion(.failure(err))
            }
            
            if let data = d {
                do {
                    let responseData = try JSONDecoder().decode([Repos].self, from: data)
                    for item in responseData {
                        repoArray.append(item)
                    }
                    completion(.success(repoArray))
                } catch (let exn) {
                    completion(.failure(exn))
                }
            }
        }.resume()
    }
}
