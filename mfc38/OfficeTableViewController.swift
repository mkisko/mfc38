//
//  OfficeTableViewController.swift
//  mfc38
//
//  Created by Алексей Усанов on 24.06.16.
//  Copyright © 2016 Алексей Усанов. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import YandexMobileMetrica

class OfficeTableViewController: UITableViewController {
    
    @IBOutlet weak var preReg: UIBarButtonItem!
    var office: OfficeModel = OfficeModel()
    var sectionName = [String]()
    var filteredOffices = [Office]()
    var indexOfOffice = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        YMMYandexMetrica.reportEvent("Список отделов") { (error) in
        }
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            sectionName = ["", "Другие отделы:"]
        } else {
            
            sectionName = ["Ближайший к вам:", "Другие отделы:"]
        }
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            if CLLocationManager.locationServicesEnabled() {
                switch (CLLocationManager.authorizationStatus()) {
                case .notDetermined, .restricted, .denied:
                    print("Do not access!")
                case .authorizedAlways, .authorizedWhenInUse:
                    office.setDistOffice()
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionName.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionName[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var cnt:Int
        
        if !office.dist.isEmpty {
            cnt = 1
        } else {
            cnt = 0
        }
        
        if section == 1 {
            cnt = self.office.list.count
        }
        return cnt
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OfficeTableViewCell
        
        let office: Office
        
        if indexPath.section == 1 {
            office = self.office.list[indexPath.row]
        } else {
            office = self.office.dist[0]
        }
        
        let queue = DispatchQueue.global(qos: .utility)
        
        queue.sync {
            
            if !office.eo {
                cell.img1.alpha = 0.3
            }
            if !office.ik {
                cell.img2.alpha = 0.3
            }
            
            if !office.atm {
                cell.img3.alpha = 0.3
            }
            
            if !office.idea2business {
                cell.img4.alpha = 0.3
            }
            
            if !office.photobootch {
                cell.img5.alpha = 0.3
            }
        }
        
        cell.addressLabel.text = office.address
        cell.areaLabel.text = office.area
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let office: Office
                if indexPath.section == 1 {
                    office = self.office.list[indexPath.row]
                } else {
                    office = self.office.dist[indexPath.row]
                }
                let controller = segue.destination as! DetailViewController
                controller.address = office.address!
                controller.area = office.area!
                controller.latitude = office.latitude
                controller.longitude = office.longitude
                controller.monday = office.monday!
                controller.tuesday = office.tuesday!
                controller.wednesday = office.wednesday!
                controller.thursday = office.thursday!
                controller.friday = office.friday!
                controller.saturday = office.saturday!
                controller.busySend = office.busy!
                controller.boss = office.boss!
            }
        }
    }
}
