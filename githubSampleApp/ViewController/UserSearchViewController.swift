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
    var viewModel: UserSearchViewModel!
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        viewModel.delegate = self
    }

    func setupSearchBar() {
        searchBar.searchBarStyle = .minimal
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
        cell.delegate = self
        cell.config(for: viewModel.searchedUsers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.goToDetails(for: indexPath.row)
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

extension UserSearchViewController: UserSearchViewModelDelegate{
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension UserSearchViewController: UserTableViewCellDelegate {
    func getImage(imgStr: String, cell: UserTableViewCell) {
        viewModel.fetchImage(imgStr) { [unowned cell] data  in
            DispatchQueue.main.async {
                if let img = data {
                    cell.imgData = img
                }
            }
        }
    }
    
    func getUserDetails(str: String, cell: UserTableViewCell) {
        viewModel.fetchUserDetails(str: str) { [unowned self, unowned cell] user in
            DispatchQueue.main.async {
                
                if let userData = user {
                    //self.viewModel.updateUsers(with: userData, at: index.row)
                    cell.repoNumber = userData.publicRepos ?? 0
                }
            }
            
        }
    }
}
