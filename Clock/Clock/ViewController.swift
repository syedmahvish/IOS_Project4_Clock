//
//  ViewController.swift
//  Clock
//
//  Created by Mahvish Syed on 30/04/21.
//  Copyright © 2021 Mahvish Syed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var systemClockContainerView: UIView!
    @IBOutlet weak var worldClockContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        systemClockContainerView.isHidden = true
    }
    
    @IBAction func segmentControllerChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            systemClockContainerView.isHidden = true
            worldClockContainerView.isHidden = false
        }else{
            systemClockContainerView.isHidden = false
            worldClockContainerView.isHidden = true
        }
    }
   
    
}

