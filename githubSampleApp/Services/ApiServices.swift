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
    
    // create session allowing caching
    private let session: URLSession
    private init() {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        //config.requestCachePolicy = .reloadIgnoringCacheData
        session = URLSession.init(configuration: config)
    }
    
    func getUsers(_ userStr: String, completion: @escaping (Result<[Items], Error>) -> ()) {
        if let urlStr = URL(string: ConstantUtils.getUsersUrl(userStr: userStr)) {
            var itemArray = [Items]()
            session.dataTask(with: urlStr) { (d, _, error) in
                if let err = error {
                    completion(.failure(err))
                }
                
                if let data = d {
                    do {
                        let responseData = try JSONDecoder().decode(ResultModel.self, from: data)
                        
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
    
    func fetchUserDetails(urlStr: String, completion: @escaping (Result<Items, Error>) -> ()) {
        if let url = URL(string: urlStr) {
            session.dataTask(with: url) { (d, _, e) in
                if let err = e {
                    completion(.failure(err))
                }
                
                if let data = d {
                    do {
                        let responseData = try JSONDecoder().decode(Items.self, from: data)
                        completion(.success(responseData))
                    } catch {
                        print("Error: \(error.localizedDescription)")
                        completion(.failure(error))
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
    
    func getRepos(_ searchKeyword: String, for userName : String,
                  completion: @escaping (Result<[Repos], Error>) -> ()) {
        let urlStr = ConstantUtils.getSearchUrl(searchKeyword: searchKeyword, userKeyword: userName)
        guard let url = URL(string: urlStr) else {
            return
        }
        session.dataTask(with: url) { (d, _, error) in
            if let err = error {
                completion(.failure(err))
            }
            
            if let data = d {
                do {
                    let responseData = try JSONDecoder().decode(ReposResponse.self, from: data)
                    completion(.success(responseData.items))
                } catch (let exn) {
                    completion(.failure(exn))
                }
            }
        }.resume()
    }
}
