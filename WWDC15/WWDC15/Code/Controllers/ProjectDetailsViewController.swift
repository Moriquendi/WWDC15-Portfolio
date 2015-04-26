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
    
    var project: Project?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = project!.images.first
        self.titleLabel.text = project!.title
        self.descriptionLabel.text = project!.appDescription
    }

    // MARK: ProjectDetailsViewController
    
    @IBAction func didTapClose(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
