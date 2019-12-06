//
//  Storyboarded.swift
//  githubSampleApp
//
//  Created by Adesida, Ifeoluwa - Ifeoluwa on 12/5/19.
//  Copyright © 2019 Lowes. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        
        let className = fullName.components(separatedBy: ".")[1]
        let bundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: className, bundle: bundle)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: className) as? Self else {
            fatalError("Unable to get the viewcontroller from storyboard")
        }
        
        return viewController
    }
    
    static func instantiate(for storyboard: String) -> Self {
        let fullName = NSStringFromClass(self)
        
        let className = fullName.components(separatedBy: ".")[1]
        let bundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: className, bundle: bundle)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: className) as? Self else {
            fatalError("Unable to get the viewcontroller from storyboard")
        }
        
        return viewController
    }
}
