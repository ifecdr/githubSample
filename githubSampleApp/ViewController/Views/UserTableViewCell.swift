//
//  UserTableViewCell.swift
//  githubSampleApp
//
//  Created by Adesida, Ifeoluwa - Ifeoluwa on 12/5/19.
//  Copyright © 2019 Lowes. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var repoNoLable: UILabel!
    
    static let identifier = "UserTableViewCell"
    
    func config(for user: Item) {
        userNameLabel.text = user.login
        //MARK: - get repo no and image
        
        
    }
}
