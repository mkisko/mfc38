//
//  NotifyController.swift
//  mfc38
//
//  Created by Sunrizz on 18.05.17.
//  Copyright © 2017 Алексей Усанов. All rights reserved.
//

import Foundation
import MBProgressHUD

class Notify{
    func textNotify(text: String, view: UIView) {
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = .text
        loadingNotification.label.text = text
    }
    
    func loadingNotify(text: String, view: UIView) {
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = text
    }
}
