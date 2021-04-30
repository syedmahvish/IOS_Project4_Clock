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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentControllerChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            systemClockContainerView.isHidden = true
            worldClockContainerView.isHidden = false
//            UIView.animate(withDuration: 0.5, animations: {
//                self.systemClockContainerView.alpha = 1
//                self.worldClockContainerView.alpha = 0
//            })
        }else{
            systemClockContainerView.isHidden = false
            worldClockContainerView.isHidden = true
//            UIView.animate(withDuration: 0.5, animations: {
//                self.worldClockContainerView.alpha = 1
//                self.systemClockContainerView.alpha = 0
//            })
        }
    }
   
    
}

