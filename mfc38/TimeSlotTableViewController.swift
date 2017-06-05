//
//  TimeSlotTableViewController.swift
//  mfc38
//
//  Created by Sunrizz on 12.04.17.
//  Copyright © 2017 Алексей Усанов. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class TimeSlotTableViewController: UITableViewController {
    
    let url = "\(urlConstraints().coreURL)getTimeSlotList/"
    private let dataSource = TimeSlotDataSource()
    var servKey = String()
    var servId = String()
    var servName = String()
    var typeName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        getTimeSlot()
    }
    
    func getTimeSlot() {
        if Reachability.isConnectedToNetwork() {
            Notify().loadingNotify(text: "", view: self.view)
            Alamofire.request(url + servKey + "/" + servId).responseJSON() {
                response in
                if response.result.isSuccess {
                    if (response.result.value as! [String]).count != 0 {
                        self.dataSource.time = response.result.value as! [String]
                        MBProgressHUD.hide(for: self.view, animated: true)
                        self.tableView.reloadData()
                    } else {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        Notify().textNotify(text: "Нет доступного времени", view: self.view)
                    }
                } else {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    Notify().textNotify(text: "Сервис недоступен", view: self.view)
                }
            }
        } else {
            Notify().textNotify(text: "Проверьте доступ к сети", view: self.view)
            
        }
    }
    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH-mm-ss"
        dateFormatter.locale = Locale(identifier: "US")
        let dates = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "d MMMM, yyyy EEEE в HH:mm"
        dateFormatter.locale = Locale(identifier: "RU")
        let timeStamp = dateFormatter.string(from: dates!)
        
        return timeStamp
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sum" {
            if let destinationVC = segue.destination as? SendViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    destinationVC.address = servName
                    destinationVC.type = typeName
                    destinationVC.time = convertDateFormater(self.dataSource.time[indexPath.row])
                    destinationVC.stime = self.dataSource.time[indexPath.row]
                    
                    destinationVC.serverId = servKey
                    destinationVC.serviceId = servId
                }
            }
        }
    }
}
