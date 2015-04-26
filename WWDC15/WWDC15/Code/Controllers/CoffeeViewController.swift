//
//  CoffeeViewController.swift
//  WWDC15
//
//  Created by Michal Smialko on 26/04/15.
//  Copyright (c) 2015 Michal Smialko. All rights reserved.
//

import UIKit

class CoffeeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.leftBarButtonItem?.target = self
        self.navigationItem.leftBarButtonItem?.action = Selector("dismiss")
    }


    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
