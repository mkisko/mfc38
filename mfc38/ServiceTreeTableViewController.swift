//
//  ServiceTreeTableViewController.swift
//  mfc38
//
//  Created by Sunrizz on 11.04.17.
//  Copyright © 2017 Алексей Усанов. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class ServiceTreeTableViewController: UITableViewController {
    
    let url = "\(urlConstraints().coreURL)getServiceTree/"
    private let dataSource = ServiceTreeDataSource()
    var key = String()
    var servName = String()
    
    var id = [Any]()
    var ser = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        getServiceTree()
    }
    
    func parse(leaf: [String:Any]) {
        for(_, serviceInfo) in leaf {
            self.ser.append(serviceInfo as! [String:Any])
            let rs = serviceInfo as! [String:Any]
            parse(leaf: rs["serviceList"] as! [String : Any])
        }
    }
    
    func getServiceTree() {
        if Reachability.isConnectedToNetwork() {
            Notify().loadingNotify(text: "", view: self.view)
            Alamofire.request(url+key).responseJSON() {
                response in
                if response.result.isSuccess {
                    let result = response.result.value! as! [String:Any]
                    self.parse(leaf: result)
                    self.ser.sort {($0["name"] as! String) < ($1["name"] as! String)}
                    for index in 0..<self.ser.count {
                        if self.ser[index]["name"]! as! String != "Прием" && self.ser[index]["name"]! as! String != "Выдача" && self.ser[index]["name"]! as! String != "Дерево услуг" {
                            self.dataSource.sr.append(self.ser[index]["name"]! as! String)
                            self.id.append(self.ser[index]["id"]!)
                        }
                    }
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.tableView.reloadData()
                } else {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    Notify().textNotify(text: "Сервис недоступен", view: self.view)
                }
            }
        } else {
            Notify().textNotify(text: "Проверьте доступ к сети", view: self.view)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "time" {
            if let destinationVC = segue.destination as? TimeSlotTableViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    destinationVC.servKey = self.key
                    destinationVC.servId = String(describing: self.id[indexPath.row])
                    destinationVC.servName = self.servName
                    destinationVC.typeName = self.dataSource.sr[indexPath.row]
                }
            }
        }
    }
}
