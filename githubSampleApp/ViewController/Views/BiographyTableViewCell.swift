//
//  BiographyTableViewCell.swift
//  githubSampleApp
//
//  Created by Adesida, Ifeoluwa - Ifeoluwa on 12/6/19.
//  Copyright © 2019 Lowes. All rights reserved.
//

import UIKit

protocol BiographyTableViewCellDelegate: class {
    func getRepos(for searchStr: String)
    func getAvatar(img: String, completion: @escaping (Data?) -> ())
}

class BiographyTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var joinDataLabel: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!    
    @IBOutlet weak var biography: UILabel!
    
    static let identifier = "BiographyCell"
    weak var delegate: BiographyTableViewCellDelegate?
    
    func config(for user: Items) {
        userNameLabel.text = user.login
        emailLabel.text = user.email ?? "No Email"
        locationLabel.text = user.location ?? "No Location"
        joinDataLabel.text = user.createdAt ?? ""
        followers.text = "\(user.followers ?? 0) Followers"
        following.text = "Following \(user.following ?? 0)"
        biography.text = user.bio ?? "No Bio Found for this user"
        getImage(imgStr: user.avatarURL)
        searchBar.delegate = self
    }
    
    func getImage(imgStr: String) {
        delegate?.getAvatar(img: imgStr, completion: { [unowned self] data in
            DispatchQueue.main.async {
                if let d = data {
                    self.avatarImage.image = UIImage(data: d)
                }
            }
        })
    }
}

extension BiographyTableViewCell: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchKeyword = searchText.replacingOccurrences(of: " ", with: "+")
        if !searchKeyword.isEmpty {
            delegate?.getRepos(for: searchKeyword)
        }
    }
}
