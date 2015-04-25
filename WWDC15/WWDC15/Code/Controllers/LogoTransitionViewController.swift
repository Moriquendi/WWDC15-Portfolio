//
//  LogoTransitionViewController.swift
//  WWDC15
//
//  Created by Michal Smialko on 25/04/15.
//  Copyright (c) 2015 Michal Smialko. All rights reserved.
//

import UIKit

class LogoTransitionViewController: UIViewController {

    @IBOutlet weak var animatedLogoView: DSAnimatedAppleView!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.animatedLogoView.animate { () -> Void in
            self.performSegueWithIdentifier("kShowMenuSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
