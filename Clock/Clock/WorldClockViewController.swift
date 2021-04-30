//
//  WorldClockViewController.swift
//  Clock
//
//  Created by Mahvish Syed on 30/04/21.
//  Copyright © 2021 Mahvish Syed. All rights reserved.
//

import UIKit
import DropDown

struct CountryTimeZone {
    var countryCode : String?
    var countryName : String?
    var zoneName    : String?
    var gmtOffset   : Int?
    var timestamp   : Int?
    
    func getList(_ completionHandler : @escaping([CountryTimeZone]?) -> Void){
        var timeZoneList = [CountryTimeZone]()
        let url = URL(string: "https://api.timezonedb.com/v2.1/list-time-zone?key=HZBG2SWRTSOB&format=json")
        let task = URLSession.shared.dataTask(with: url!){(data, response, error) in
            if let err = error{
                print("Unsuccessful : \(err)")
                return
            }
            
            guard let res = response as? HTTPURLResponse,
                (200...299).contains(res.statusCode)
            else{
                print("Unsuccessful : \(response)")
                return
            }
            
            do{
                if let d = data,
                   let result = try JSONSerialization.jsonObject(with: d, options: []) as? [String : Any],
                   let jsonObj = result["zones"] as? [Any]{
                    
                    for obj in jsonObj{
                        
                        if let timeObj = obj as? [String : Any]{
                            var countryTimeZoneObj = CountryTimeZone()
                            
                            if let code = timeObj["countryCode"] as? String{
                                countryTimeZoneObj.countryCode = code
                            }
                            
                            if let name = timeObj["countryName"] as? String{
                                countryTimeZoneObj.countryName = name
                            }
                            
                            if let zone = timeObj["zoneName"] as? String{
                                countryTimeZoneObj.zoneName = zone
                            }
                            
                            if let gmtOffset = timeObj["gmtOffset"] as? Int{
                                countryTimeZoneObj.gmtOffset = gmtOffset
                            }
                            
                            if let timestamp = timeObj["timestamp"] as? Int{
                                countryTimeZoneObj.timestamp = timestamp
                            }
                            timeZoneList.append(countryTimeZoneObj)
                        }
                    }
                    
                }
            }catch{}

            completionHandler(timeZoneList ?? nil)
        }
        
        task.resume()
    }

}

class WorldClockViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var countryButton: UIButton!
    
    var timeZoneList = [CountryTimeZone]()
    var countryNameList = [String]()
    
    var dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getList()
    }
    
    func getList(){
        CountryTimeZone().getList {[unowned self] (data) in
            if let d = data as? [CountryTimeZone]{
                self.timeZoneList = d
                self.getCountryName()
            }
        }
    }
    
    func getCountryName(){
        for obj in timeZoneList{
            if let name = obj.countryName,
               let zonename = obj.zoneName {
                 countryNameList.append(name + "(" + zonename + ")")
            }
        }
    }
    
    func getSelectedZoneTime(_ timeZone : CountryTimeZone){
        let url = URL(string: "https://api.timezonedb.com/v2.1/get-time-zone?key=HZBG2SWRTSOB&format=json&by=zone&zone=\(timeZone.zoneName!)&time=\(timeZone.timestamp!)")
        let task = URLSession.shared.dataTask(with: url!){(data, response, error) in
            if let err = error{
                print("Unsuccessful : \(err)")
                return
            }
            
            guard let res = response as? HTTPURLResponse,
                (200...299).contains(res.statusCode)
                else{
                    print("Unsuccessful : \(response)")
                    return
            }
            
            do{
                if let d = data,
                    let result = try JSONSerialization.jsonObject(with: d, options: []) as? [String : Any],
                    let jsonObj = result["formatted"] as? String{
                    
                    let stringArray = jsonObj.split(separator: " ")
                    
                    let dateString : String = String(stringArray[0])
                    let timeString : String = String(stringArray[1])
                    print(dateString)
                    
                    var formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    let stringDate = formatter.date(from: dateString)
                    formatter.dateFormat = "EEE, MMM dd yyyy"
                 
                    DispatchQueue.main.async {
                         self.dateLabel.text = formatter.string(from: stringDate ?? Date())
                         self.timeLabel.text = timeString
                    }
                }
            }catch{}
        }
        task.resume()
    }
    
    @IBAction func selectCountryButtonTap(_ sender: UIButton) {
        dropDown.dataSource = countryNameList
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            sender.setTitle(item, for: .normal)
            if let selectedTimeZone = self?.timeZoneList[index] as? CountryTimeZone{
                self?.getSelectedZoneTime(selectedTimeZone)
            }
        }
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
