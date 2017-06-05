//
//  ServiceListTableViewController.swift
//  mfc38
//
//  Created by Алексей Усанов on 21.12.16.
//  Copyright © 2016 Алексей Усанов. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class ServiceListTableViewController: UITableViewController {
    
    let request = Alamofire.request(urlConstraints().getServiceList)

    var service: [ListService] = [ListService]()
    var serIdList: [ListService] = [ListService]()
    var serId: Types?
    var inx: Int = Int()
    var type: [Lists] = [Lists]()
    var typeIndex: Int = Int()
    var name: String?
    
    deinit {
        type.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationItem.title = name
    }
    
    func load() {
                request.responseArray(completionHandler: { (response: DataResponse<[ListService]>) in
                    if response.result.isSuccess {
                    self.service = response.result.value!
                    self.hideHud()
                    self.setService()
                    } else {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
                        loadingNotification.mode = .text
                        loadingNotification.label.text = "Сервис недоступен"
                    }
                    
                })
    }

    func setService() {
        self.serIdList.removeAll()
        
        let typeCount = (type[typeIndex].types?[inx].services)?.count
        
        for index in 0..<typeCount! {
            
            let serId:String = (type[typeIndex].types?[inx].services?[index])!
            
            for x in 0..<service.count {
                if service[x].part == false {
                    
                if service[x].ser_id == serId {
                    self.serIdList.append(service[x])
                    self.tableView.reloadData()
                }
                } else {

                    for rx in 0..<service[x].items!.count {
                        
                        if service[x].items![rx].ser_id == serId {
                            self.serIdList.append(self.service[x].items![rx])
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    func setHud() {
        self.view.alpha = 0.5
        self.view.isUserInteractionEnabled = false
        
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        //loadingNotification.label.text = "Загрузка"
    }
    
    func hideHud() {
        self.view.alpha = 1
        self.view.isUserInteractionEnabled = true
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.service.isEmpty {
        setHud()
        load()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serIdList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCell", for: indexPath) as! ServiceListTableViewCell
        
        cell.serviceName.text = serIdList[indexPath.row].name?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueList" {
            let controller = segue.destination as! ServiceTextTableViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let attr: Attr = serIdList[indexPath.row].attr!
                
                if attr.documentsText != nil {
                    controller.documentsText = attr.documentsText!
                } else {
                    controller.documentsText = "-"
                }
                
                if serIdList[indexPath.row].name != nil {
                    controller.nameText = serIdList[indexPath.row].name!
                } else {
                    controller.nameText = "-"
                }
                
                if attr.paymentInfoText != nil {
                    controller.paymentInfoText = attr.paymentInfoText!
                } else {
                    controller.paymentInfoText = "-"
                }
                
                if attr.timeTermText != nil {
                    controller.timeTermText = attr.timeTermText!
                } else {
                    controller.timeTermText = "-"
                }
            }
        }
    }
}
