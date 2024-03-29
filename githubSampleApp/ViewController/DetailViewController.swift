//
//  DetailViewController.swift
//  githubSampleApp
//
//  Created by Adesida, Ifeoluwa - Ifeoluwa on 12/6/19.
//  Copyright © 2019 Lowes. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: DetailViewModel!
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        viewModel.delegate = self
        viewModel.repos.removeAll()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        title = "GitHub Searcher"
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 360 : 70
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel.numberOfRepos()
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BiographyCell", for: indexPath) as? BiographyTableViewCell else {
                fatalError("Unable to create BiographyCell")
            }
            cell.delegate = self
            cell.config(for: viewModel.getUser())
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as? RepoTableViewCell else {
                fatalError("Unable to create RepoTableViewCell")
            }
            let repo = viewModel.repos[indexPath.row]
            cell.config(item: repo)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        if section == 1 {
            let repo = viewModel.repos[indexPath.row]
            let link = repo.htmlURL
            if let url = URL(string: link) {
                UIApplication.shared.open(url)
            }
        }
    }
}

extension DetailViewController: BiographyTableViewCellDelegate {
    func getRepos(for searchStr: String) {
        viewModel.fetchRepos(for: searchStr)
    }
    
    func getAvatar(img: String, completion: @escaping (Data?) -> ()) {
        viewModel.fetchImage(img, completion: completion)
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadSections([1], with: UITableView.RowAnimation.top)
        }
    }
}
