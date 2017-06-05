//
//  ContactsTableViewController.swift
//  mfc38
//
//  Created by Алексей Усанов on 19.12.16.
//  Copyright © 2016 Алексей Усанов. All rights reserved.
//

import UIKit
import StoreKit
import YandexMobileMetrica

class ContactsTableViewController: UITableViewController {
    
    @IBOutlet weak var version: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        YMMYandexMetrica.reportEvent("Контакты") { (error) in
        }
        
        version.text = versionSet()
        navigationController?.navigationBar.isHidden = false
    }
    
    
    func rateMe() {
        if !UserDefaults.standard.bool(forKey: "rate") {
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
                UserDefaults.standard.set(true, forKey: "rate")
            }
        }
    }
    
    func versionSet() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        return "\(version)"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 1:
            let alertController = UIAlertController(title: "Позвонить", message: "Вы хотите позвонить в центр \"Мои Документы\"?", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Да", style: UIAlertActionStyle.default) {
                UIAlertAction in
                let phone = "tel://88001000447";
                let url:URL = URL(string:phone)!;
                UIApplication.shared.openURL(url);
            }
            
            let cancelAction = UIAlertAction(title: "Нет", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            
            alertController.view.tintColor = UIColor(colorLiteralRed: 218/255, green: 94/255, blue: 60/255, alpha: 1)
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        case 2:
            let alertController = UIAlertController(title: "Позвонить", message: "Вы хотите позвонить в центр \"Мои Документы\"?", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Да", style: UIAlertActionStyle.default) {
                UIAlertAction in
                let phone = "tel://88002000665";
                let url:URL = URL(string:phone)!;
                UIApplication.shared.openURL(url);
            }
            
            let cancelAction = UIAlertAction(title: "Нет", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            
            alertController.view.tintColor = UIColor(colorLiteralRed: 218/255, green: 94/255, blue: 60/255, alpha: 1)
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        case 3:
            let email = "mailto://info@mfc38.ru";
            let url:URL = URL(string:email)!;
            UIApplication.shared.openURL(url);
        case 4:
            let www = "http://mfc38.ru";
            let url:URL = URL(string:www)!;
            UIApplication.shared.openURL(url);
        case 5:
            let vk = "https://vk.com/mfcirkutsk";
            let url:URL = URL(string:vk)!;
            UIApplication.shared.openURL(url);
        case 6:
            let tw = "https://twitter.com/mfcirkutsk";
            let url:URL = URL(string:tw)!;
            UIApplication.shared.openURL(url);
        case 7:
            let fb = "https://www.facebook.com/mfcirkutsk";
            let url:URL = URL(string:fb)!;
            UIApplication.shared.openURL(url);
        default:
            print()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rateMe()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
