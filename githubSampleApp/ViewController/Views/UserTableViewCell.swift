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
    var repoNumber: Int = 0 {
        didSet{
            repoNoLabel.text = String(repoNumber)
        }
    }
    
    func config(for user: User) {
        userNameLabel.text = user.login
        //MARK: - get repo no and image
        delegate?.getImage(imgStr: user.avatarURL, cell: self)
        delegate?.getUserDetails(str: user.url, cell: self)
        
//        viewModel.getImage(user.avatarURL) { [unowned self] imgData in
//            if let data = imgData {
//                self.avatarImageView.image = UIImage(data: data)
//            }
//        }
//
//        viewModel.fetchUserDetails(str: user.url) { [unowned self] detail in
//            if let userDetail = detail {
//                DispatchQueue.main.async {
//                    self.repoNoLabel.text = String(userDetail.publicRepos ?? 0)
//                }
//            }
//        }
    }
}
