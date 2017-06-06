//
//  AboutViewController.swift
//  mfc38
//
//  Created by Sunrizz on 06.06.17.
//  Copyright © 2017 Алексей Усанов. All rights reserved.
//

import UIKit
import StoreKit
import YandexMobileMetrica

class AboutViewController: UIViewController {

    @IBOutlet weak var version: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(AboutViewController.swiped))
        swipeDown.direction = .down
        version.text = "Версия: \(versionSet())"
        
    }

    @IBAction func close(_ sender: UIButton) {
        swiped()
    }
    
    func swiped() {
        self.dismiss(animated: true) {
            
        }
    }
    @IBAction func rateApp(_ sender: UIButton) {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
            UserDefaults.standard.set(true, forKey: "rate")
        }
    }
    
    @IBAction func emailDev(_ sender: UIButton) {
        let email = "mailto://a.usanov@mfc38.ru"
        let url:URL = URL(string:email)!
        UIApplication.shared.openURL(url)
    }
    
    func versionSet() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        return "\(version)"
    }
    
   }
