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

    func config(item: Items) {
        repoTitleLabel.text = item.name ?? ""
        repoLabel.text = String(item.forks ?? 0)
        //starsLabel.text = String(repo.stargazersCount)
    }
}
