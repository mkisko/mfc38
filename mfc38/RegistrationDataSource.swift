//
//  RegistrationDataSource.swift
//  mfc38
//
//  Created by Sunrizz on 18.05.17.
//  Copyright © 2017 Алексей Усанов. All rights reserved.
//

import UIKit

class RegistrationDataSource: NSObject, UITableViewDataSource {
    
    var servList: [String:String] = [:]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "regCell", for: indexPath) as! ServerTableViewCell
        
        cell.Title.text = "\(Array(servList).sorted(by: {$0.value < $1.value})[indexPath.row].value)"
        return cell
    }
}
