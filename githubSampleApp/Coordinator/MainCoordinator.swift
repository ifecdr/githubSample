//
//  MainCoordinator.swift
//  githubSampleApp
//
//  Created by Adesida, Ifeoluwa - Ifeoluwa on 12/5/19.
//  Copyright © 2019 Lowes. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinator = [Coordinator]()
    var navController: UINavigationController
    let searchViewModel = UserSearchViewModel()
    let detailViewModel = DetailViewModel()
    
    init(navigationController: UINavigationController) {
        self.navController = navigationController
    }
    
    func start() {
        let vc = UserSearchViewController.instantiate()
        vc.viewModel = searchViewModel
        vc.coordinator = self
        navController.pushViewController(vc, animated: false)
    }
    
    func goToDetails(for index: Int) {
        let vc = DetailViewController.instantiate()
        let user = searchViewModel.getUser(index: index)
        detailViewModel.user = user
        vc.viewModel = detailViewModel
        vc.coordinator = self
        navController.pushViewController(vc, animated: false)
    }
}
