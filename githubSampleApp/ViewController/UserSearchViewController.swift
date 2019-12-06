//
//  UserSearchViewController.swift
//  githubSampleApp
//
//  Created by Adesida, Ifeoluwa - Ifeoluwa on 12/5/19.
//  Copyright © 2019 Lowes. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController, Storyboarded {

    @IBOutlet var tableView: UITableView!
    let searchBar = UISearchBar()
    let viewModel = UserSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }

    func setupSearchBar() {
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "  Search users..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
    }

}

extension UserSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUsers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else {
            fatalError("Unable to create tableview Cell")
        }
        cell.config(for: viewModel.searchedUsers[indexPath.row])
        return cell
    }
}

extension UserSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchKeyword = searchText.replacingOccurrences(of: " ", with: "+")
        if !searchKeyword.isEmpty {
            viewModel.fetchUsers(keyword: searchKeyword)
        }
    }
}
