//
//  TypeTableViewController.swift
//  mfc38
//
//  Created by Алексей Усанов on 21.12.16.
//  Copyright © 2016 Алексей Усанов. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import MBProgressHUD

class TypeTableViewController: UITableViewController {
    
    var name: [String] = [String]()
    
    var ndx: Int = 0 //default value

    var serIdList: [ListService] = [ListService]()
    var newList:[attrService] = [attrService]()
    let request = Alamofire.request(urlConstraints().getServiceType)
    var type: [Lists] = [Lists]()
    var filteredType: [Lists] = [Lists]()
    let qu = DispatchQueue.global()
    var titleStr: String?
    
    @IBAction func selectType(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController()
        
        let by_department = UIAlertAction(title: type[0].name, style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.navigationItem.title = self.type[0].name
            self.ndx = 0
            self.tableView.reloadData()
        }
        
        let by_recipient = UIAlertAction(title: type[1].name, style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.navigationItem.title = self.type[1].name
            self.ndx = 1
            self.tableView.reloadData()
        }
        
        let by_life = UIAlertAction(title: type[2].name, style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.navigationItem.title = self.type[2].name
            self.ndx = 2
            self.tableView.reloadData()
        }
        
        let by_chash = UIAlertAction(title: type[3].name, style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.navigationItem.title = self.type[3].name
            self.ndx = 3
            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            self.tableView.reloadData()
        }
        
        alertController.view.tintColor = UIColor(colorLiteralRed: 218/255, green: 94/255, blue: 60/255, alpha: 1)
        alertController.addAction(by_department)
        alertController.addAction(by_recipient)
        alertController.addAction(by_life)
        alertController.addAction(by_chash)
        alertController.addAction(cancel)
        alertController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Reachability.isConnectedToNetwork() {
            self.loadType()
        }

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        navigationController?.navigationBar.isHidden = false
//        if Reachability.isConnectedToNetwork() {
//        self.navigationItem.title = type[ndx].name
//        }
    }
    
    deinit {
        type.removeAll()
    }
    
    func loadType() {
        self.view.isUserInteractionEnabled = false
        Notify().loadingNotify(text: "", view: self.view)
        qu.async {
            self.request.responseArray(completionHandler: { (response: DataResponse<[Lists]>) in
                if response.result.isSuccess {
                    self.type = response.result.value!
                    self.tableView.reloadData()
                    self.view.isUserInteractionEnabled = true
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.navigationItem.title = self.type[self.ndx].name
                } else {
                    self.qu.sync {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        Notify().textNotify(text: "Сервис временно недоступен", view: self.view)
                    }
                }
            })
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         var nx: Int? = Int()
        
        if !type.isEmpty {
       
        switch self.ndx {
        case 0:
            nx = (type[0].types?.count)
        case 1:
            nx = (type[1].types?.count)
        case 2:
            nx = (type[2].types?.count)
        case 3:
            nx = (type[3].types?.count)
        default:
            print()
        }
        } else {
            nx = 0
        }
        
        return nx!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TypeServiceTableViewCell
        
        switch self.ndx {
        case 0:
            cell.serviceText.text = type[0].types?[indexPath.row].name
        case 1:
            cell.serviceText.text = type[1].types?[indexPath.row].name
        case 2:
            cell.serviceText.text = type[2].types?[indexPath.row].name
        case 3:
            cell.serviceText.text = type[3].types?[indexPath.row].name
        default:
            print()
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "serviceList" {
            let controller = segue.destination as! ServiceListTableViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                
                controller.type = self.type
                controller.inx = indexPath.row
                
                switch ndx {
                case 0:
                    controller.typeIndex = 0
                    controller.name = self.type[0].types?[indexPath.row].name
                case 1:
                    controller.typeIndex = 1
                    controller.name = self.type[1].types?[indexPath.row].name
                case 2:
                    controller.typeIndex = 2
                    controller.name = self.type[2].types?[indexPath.row].name
                case 3:
                    controller.typeIndex = 3
                    controller.name = self.type[3].types?[indexPath.row].name

                default:
                    print()
                }
            }
        }
    }
}
