//
//  RegistrationTableViewController.swift
//  mfc38
//
//  Created by Sunrizz on 21.03.17.
//  Copyright © 2017 Алексей Усанов. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class RegistrationTableViewController: UITableViewController {
    
    let url = "\(urlConstraints().coreURL)getServerList"
    private let dataSource = RegistrationDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getServerList()
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        tableView.dataSource = dataSource
    }
    
    func getServerList() {
        if Reachability.isConnectedToNetwork() {
      Notify().loadingNotify(text: "", view:self.view)
            Alamofire.request(url).responseJSON() {
                response in
                if response.result.isSuccess {
                    self.dataSource.servList = response.result.value! as! [String:String]
                    self.tableView.reloadData()
                    MBProgressHUD.hide(for: self.view, animated: true)
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
        if segue.identifier == "serv" {
            if let destinationVC = segue.destination as? ServiceTreeTableViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    destinationVC.key = Array(self.dataSource.servList).sorted(by: {$0.value < $1.value})[indexPath.row].key
                    destinationVC.servName = Array(self.dataSource.servList).sorted(by: {$0.value < $1.value})[indexPath.row].value
                }
            }
        }
    }
}
