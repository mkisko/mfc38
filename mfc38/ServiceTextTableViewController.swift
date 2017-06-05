//
//  ServiceTextTableViewController.swift
//  mfc38
//
//  Created by Алексей Усанов on 2/27/17.
//  Copyright © 2017 Алексей Усанов. All rights reserved.
//

import UIKit

class ServiceTextTableViewController: UITableViewController {
    
    var timeTermText: String?
    var paymentInfoText: String?
    var documentsText: String?
    var nameText: String?
    
    var regExp = "<[^>]+>"
    
    var cellTitle = [String]()
    var cellText = [String]()
   
    @IBAction func preReg(_ sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "reg")
        self.showDetailViewController(vc!, sender: self)
    }
        override func viewDidLoad() {
            
        super.viewDidLoad()
            
            tableView.estimatedRowHeight = 44
            tableView.rowHeight = UITableViewAutomaticDimension
            
    navigationItem.title = stringConstraints().Description
   
            cellTitle = ["Наименование", "Сроки", "Стоимость(пошлина)", "Документы"]
            cellText = [nameText!.replacingOccurrences(of: regExp, with: "", options: .regularExpression, range: nil), timeTermText!.replacingOccurrences(of: regExp, with: "", options: .regularExpression, range: nil), paymentInfoText!.replacingOccurrences(of: regExp, with: "", options: .regularExpression, range: nil), documentsText!.replacingOccurrences(of: regExp, with: "", options: .regularExpression, range: nil)]
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitle.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCell", for: indexPath) as! ServiceTextTableViewCell
    cell.TitleLabel.text = cellTitle[indexPath.row]
    cell.TextLabel.text = cellText[indexPath.row]

        return cell
    }
}
