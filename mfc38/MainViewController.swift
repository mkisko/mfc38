//
//  MainViewController.swift
//  mfc38
//
//  Created by Sunrizz on 24.05.17.
//  Copyright © 2017 Алексей Усанов. All rights reserved.
//

import UIKit
import CoreLocation
import MBProgressHUD
import SCLAlertView
import StoreKit

class MainViewController: UIViewController, CLLocationManagerDelegate, UISplitViewControllerDelegate {
    
    @IBOutlet weak var shView: UIView!
    
    let color = UIColor(colorLiteralRed: 218/255, green: 94/255, blue: 60/255, alpha: 1)
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.splitViewController?.delegate = self
        self.splitViewController?.preferredDisplayMode = .allVisible
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "news")
            showDetailViewController(vc!, sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if !Reachability.isConnectedToNetwork() {
            self.view.isUserInteractionEnabled = false
            Notify().textNotify(text: "Проверьте доступ к сети", view: self.view)
        } else {
            self.view.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func openESIA(_ sender: UIButton) {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false,
            showCircularIcon: false
        )
        
        let alert = SCLAlertView(appearance: appearance)
        
        alert.addButton("Записаться на приём", backgroundColor: color) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "reg")
            self.showDetailViewController(vc!, sender: self)
        }
        
        alert.addButton("Перейти на портал", backgroundColor: color) {
            let www = "https://gosuslugi.ru";
            let url:URL = URL(string:www)!;
            UIApplication.shared.openURL(url);
        }
        
        alert.addButton("Отмена", backgroundColor: color) {}
        
        alert.showInfo("", subTitle: "Вы можете перейти на портал Госуслуг или записаться в МФЦ для подтверждения своей учётной записи ")
    }
}
