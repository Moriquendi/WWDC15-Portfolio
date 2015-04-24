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

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.polandMapView.startAnimation()
    }


}
