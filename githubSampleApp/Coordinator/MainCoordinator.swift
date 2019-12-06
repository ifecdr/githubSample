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
    
    init(navigationController: UINavigationController) {
        self.navController = navigationController
    }
    
    func start() {
        let vc = UserSearchViewController.instantiate()
        navController.pushViewController(vc, animated: false)
    }
}
