//
//  UserTableViewCell.swift
//  githubSampleApp
//
//  Created by Adesida, Ifeoluwa - Ifeoluwa on 12/5/19.
//  Copyright © 2019 Lowes. All rights reserved.
//

import UIKit

protocol UserTableViewCellDelegate: class {
    func getImage(imgStr: String, cell: UserTableViewCell)
    func getUserDetails(str: String, cell: UserTableViewCell)
}

class UserTableViewCell: UITableViewCell {

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var repoNoLabel: UILabel!
    
    static let identifier = "UserTableViewCell"
    weak var delegate: UserTableViewCellDelegate?
    
    var imgData: Data = Data() {
        didSet{
            avatarImageView.image = UIImage(data: imgData)
        }
    }
    
    var userDetail: Items? {
        didSet {
            repoNoLabel.text = String(userDetail?.publicRepos ?? 0)
        }
    }
    
    func config(for user: Items) {
        userNameLabel.text = user.login
        delegate?.getImage(imgStr: user.avatarURL, cell: self)
        delegate?.getUserDetails(str: user.url, cell: self)
    }
}
