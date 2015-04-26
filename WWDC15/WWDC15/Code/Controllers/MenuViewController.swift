//
//  MenuViewController.swift
//  WWDC15
//
//  Created by Michal Smialko on 27/04/15.
//  Copyright (c) 2015 Michal Smialko. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.profileImageView.clipsToBounds = true
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.size.width/2
    }

}
