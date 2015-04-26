//
//  MeViewController.swift
//  WWDC15
//
//  Created by Michal Smialko on 22/04/15.
//  Copyright (c) 2015 Michal Smialko. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {

    @IBOutlet weak var polandMapView: PolandMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem?.target = self
        self.navigationItem.leftBarButtonItem?.action = Selector("dismiss")
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.polandMapView.startAnimation()
    }


}
