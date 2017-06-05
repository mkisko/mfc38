//
//  MyRegTableViewController.swift
//  mfc38
//
//  Created by Sunrizz on 18.04.17.
//  Copyright © 2017 Алексей Усанов. All rights reserved.
//

import UIKit
import CoreData
import YandexMobileMetrica

class MyRegTableViewController: UITableViewController {
    
    @IBOutlet weak var addedBtn: UIBarButtonItem!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    var myReg: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        YMMYandexMetrica.reportEvent("Список предварительных записей") { (error) in
        }
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        loadCD(entity: "Prereg")
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCD(entity: "Prereg")
        self.tableView.reloadData()
        
        if !Reachability.isConnectedToNetwork() {
            addedBtn.isEnabled = false
        } else {
            addedBtn.isEnabled = true
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if !myReg.isEmpty {
            return 1
        } else {
            TableViewHelper.EmptyMessage(text: "Тут будут ваши талоны предварительной записи", vc: self)
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myReg.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> MyRegTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myReg", for: indexPath) as! MyRegTableViewCell
        
        cell.Title.text = myReg[indexPath.row].value(forKey: "address") as? String
        cell.detail.text = myReg[indexPath.row].value(forKey: "time") as? String
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "myReg" {
            if let destinationVC = segue.destination as? RegViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    destinationVC.codeText = myReg[indexPath.row].value(forKey: "code") as! String
                    destinationVC.addressText = myReg[indexPath.row].value(forKey: "address") as! String
                    destinationVC.firstNameText = myReg[indexPath.row].value(forKey: "firstName") as! String
                    destinationVC.secondNameText = myReg[indexPath.row].value(forKey: "secondName") as! String
                    destinationVC.timeText = myReg[indexPath.row].value(forKey: "time") as! String
                }
            }
        }
    }
    
    func loadCD (entity: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Prereg")
        do {
            let result = try managedContext.fetch(fetchRequest)
            self.myReg = result as! [NSManagedObject]
        } catch {
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            managedContext.delete(self.myReg[indexPath.row])
            self.myReg.remove(at: indexPath.row)
            self.tableView.reloadData()
            do {
                try self.managedObjectContext.save()
            } catch {
            }
        }
    }
    
    func okSet(alert: UIAlertAction!) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "main")
        self.navigationController?.pushViewController(VC!, animated: true)
    }
    
}
