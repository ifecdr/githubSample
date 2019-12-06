//
//  RepoTableViewCell.swift
//  githubSampleApp
//
//  Created by Adesida, Ifeoluwa - Ifeoluwa on 12/6/19.
//  Copyright © 2019 Lowes. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var repoTitleLabel: UILabel!
    @IBOutlet weak var repoLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    static let identifier = "RepoTableViewCell"

    func config(repo: Repos) {
        repoTitleLabel.text = repo.fullName
        repoLabel.text = String(repo.forksCount)
        starsLabel.text = String(repo.stargazersCount)
    }
}
