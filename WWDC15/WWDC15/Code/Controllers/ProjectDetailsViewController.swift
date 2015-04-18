//
//  ProjectDetailsViewController.swift
//  WWDC15
//
//  Created by Michal Smialko on 16/04/15.
//  Copyright (c) 2015 Michal Smialko. All rights reserved.
//

import UIKit

class ProjectDetailsViewController: UIViewController {

    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: ProjectDetailsViewController
    
    @IBAction func didTapClose(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
