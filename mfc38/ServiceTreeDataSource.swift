//
//  ServiceTreeDataSource.swift
//  mfc38
//
//  Created by Sunrizz on 18.05.17.
//  Copyright © 2017 Алексей Усанов. All rights reserved.
//

import UIKit

class ServiceTreeDataSource: NSObject, UITableViewDataSource {
    
    var sr = [String]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "service", for: indexPath) as! TypeTableViewCell
        cell.Title.text = self.sr[indexPath.row]
        return cell
    }
}
