//
//  TableViewHelper.swift
//  mfc38
//
//  Created by Sunrizz on 19.05.17.
//  Copyright © 2017 Алексей Усанов. All rights reserved.
//

import Foundation

class TableViewHelper {
    class func EmptyMessage(text: String, vc: UITableViewController) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: vc.view.bounds.size.width, height: vc.view.bounds.size.height))
   
        messageLabel.text = text
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        messageLabel.font = UIFont(name: "Helvetica", size: 18)
        messageLabel.textColor = UIColor(colorLiteralRed: 219/255, green: 79/255, blue: 55/255, alpha: 1)
      
        vc.tableView.backgroundView = messageLabel
        vc.tableView.separatorStyle = .none
    }
}
