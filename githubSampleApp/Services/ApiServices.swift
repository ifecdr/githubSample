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
        config.requestCachePolicy = .returnCacheDataElseLoad
        session = URLSession.init(configuration: config)
    }
    
    func getUsers(_ userStr: String, completion: @escaping (Result<[Item], Error>) -> ()) {
        if let urlStr = URL(string: ConstantUtils.getUsersUrl(userStr: userStr)) {
            var itemArray = [Item]()
            session.dataTask(with: urlStr) { (d, _, error) in
                if let err = error {
                    completion(.failure(err))
                }
                
                if let data = d {
                    do {
                        let responseData = try JSONDecoder().decode(Users.self, from: data)
                        
                        for item in responseData.items {
                            itemArray.append(item)
                        }
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
    }
}
