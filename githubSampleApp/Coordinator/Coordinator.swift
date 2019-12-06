//
//  Coordinator.swift
//  githubSampleApp
//
//  Created by Adesida, Ifeoluwa - Ifeoluwa on 12/5/19.
//  Copyright © 2019 Lowes. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinator: [Coordinator] { get set }
    var navController: UINavigationController { get set }
    
    func start()
}
