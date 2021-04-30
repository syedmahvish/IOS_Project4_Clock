//
//  SystemDateViewController.swift
//  Clock
//
//  Created by Mahvish Syed on 30/04/21.
//  Copyright © 2021 Mahvish Syed. All rights reserved.
//

import UIKit

class SystemDateViewController: UIViewController {

    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM dd yyyy"
        let dateString = formatter.string(from: Date())
        currentDateLabel.text = dateString
        
        Timer.scheduledTimer(timeInterval: 1, target: self , selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime(){
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .long
        timeFormatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? " ")
        let timeString = timeFormatter.string(from: Date())
        currentTimeLabel.text = timeString
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
