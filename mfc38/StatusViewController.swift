//
//  StatusViewController.swift
//  mfc38
//
//  Created by Алексей Усанов on 30.06.16.
//  Copyright © 2016 Алексей Усанов. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SCLAlertView
import YandexMobileMetrica

class StatusViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var statusView: UIView!
    
    var MBHUD = MBProgressHUD()
    let urlConst = urlConstraints()
    
    @IBOutlet weak var statusButtonOutlet: UIButton!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var shView: UIView!
    
    override func viewDidLoad() {
        
        statusTextField.delegate = self
        
        super.viewDidLoad()
        
        YMMYandexMetrica.reportEvent("Проверка статуса") { (error) in
        }
    
        navigationController?.navigationBar.isHidden = false
        statusTextField.keyboardType = .numberPad
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(RegViewController.swiped))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        shView.layer.shadowColor = UIColor.gray.cgColor
        shView.layer.shadowOpacity = 0.8
        shView.layer.shadowOffset = CGSize.zero
        shView.layer.shadowRadius = 3
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // .if !(statusTextField.text?.isEmpty)! {
        statusButtonOutlet.alpha = 1
        //}
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        statusButtonOutlet.alpha = 0
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        if !Reachability.isConnectedToNetwork() {
            self.statusButtonOutlet.isEnabled = false
            self.statusButtonOutlet.alpha = 0.5
            self.statusTextField.isEnabled = false
            self.statusTextField.alpha = 0.5
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        statusTextField.resignFirstResponder()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        statusButtonOutlet.alpha = 0
        
        return true
    }
    
   // func textFieldDidEndEditing(_ textField: UITextField) {
       // if (statusTextField.text?.isEmpty)! {
      //      statusButtonOutlet.alpha = 0
    //    } else {
        //    statusButtonOutlet.alpha = 1
     //   }
   // }
    
    @IBAction func statusButton(_ sender: AnyObject) {
        if Reachability.isConnectedToNetwork() {
            statusTextField.resignFirstResponder()
            let statusNumber = statusTextField.text
            let url = urlConst.checkStatus + statusNumber!
            
            if statusTextField.text == "" {
                SCLAlertView().showTitle(
                    "Статус заявки",
                    subTitle: "Номер заявления не может быть пустым",
                    duration: 4.0,
                    completeText: "Хорошо",
                    style: .success,
                    colorStyle: 0xDD5237,
                    colorTextButton: 0xFFFFFF
                )
            } else {
                statusCheckStart()
                DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async(execute: {
                    
                    Alamofire.request(url).responseArray(completionHandler: { (response: DataResponse<[Status]>) in
                        let JSON = response.result.value
                        if JSON?.count != nil {
                            let name = JSON?[(JSON?.count)!-1].name

                            switch name! {
                            case "Исполнено":
                                SCLAlertView().showTitle(
                                    "Статус заявки", // Title of view
                                    subTitle: "Заявка №\(statusNumber!) исполнена", // String of view
                                    duration: 4.0, // Duration to show before closing automatically, default: 0.0
                                    completeText: "Хорошо", // Optional button value, default: ""
                                    style: .success, // Styles - see below.
                                    colorStyle: 0xDD5237,
                                    colorTextButton: 0xFFFFFF
                                )

//self.statusLabel.text = "Заявка №\(statusNumber!) исполнена"
                                MBProgressHUD.hide(for: self.view, animated: true)
                            case "В работе":
                                //self.statusLabel.text = "Заявка №\(statusNumber!) находится в работе"
                                MBProgressHUD.hide(for: self.view, animated: true)
                                SCLAlertView().showTitle(
                                    "Статус заявки", // Title of view
                                    subTitle: "Заявка №\(statusNumber!) находится в работе", // String of view
                                    duration: 4.0, // Duration to show before closing automatically, default: 0.0
                                    completeText: "Хорошо", // Optional button value, default: ""
                                    style: .info, // Styles - see below.
                                    colorStyle: 0xDD5237,
                                    colorTextButton: 0xFFFFFF
                                )
                            default:
                                MBProgressHUD.hide(for: self.view, animated: true)
                              //  self.statusLabel.text = "К сожалению, мы не нашли заявление с указанным номером"
                                SCLAlertView().showTitle(
                                    "Статус заявки", // Title of view
                                    subTitle: "К сожалению, мы не нашли заявление с указанным номером", // String of view
                                    duration: 4.0, // Duration to show before closing automatically, default: 0.0
                                    completeText: "Хорошо", // Optional button value, default: ""
                                    style: .warning, // Styles - see below.
                                    colorStyle: 0xDD5237,
                                    colorTextButton: 0xFFFFFF
                                )
                            }
                        } else {
                            MBProgressHUD.hide(for: self.view, animated: true)
//                            self.statusLabel.text = "К сожалению, мы не нашли заявление с указанным номером"
                            SCLAlertView().showTitle(
                                "Статус заявки", // Title of view
                                subTitle: "К сожалению, мы не нашли заявление с указанным номером", // String of view
                                duration: 4.0, // Duration to show before closing automatically, default: 0.0
                                completeText: "Хорошо", // Optional button value, default: ""
                                style: .warning, // Styles - see below.
                                colorStyle: 0xDD5237,
                                colorTextButton: 0xFFFFFF
                            )
                        }
                    })
                })
            }
            
        } else {
            statusTextField.resignFirstResponder()
            SCLAlertView().showTitle(
                "Статус заявки", // Title of view
                subTitle: "К сожалению, в оффлайн режиме проверка статуса невозможна", // String of view
                duration: 0.0, // Duration to show before closing automatically, default: 0.0
                completeText: "Хорошо", // Optional button value, default: ""
                style: .warning, // Styles - see below.
                colorStyle: 0xDD5237,
                colorTextButton: 0xFFFFFF
            )
            //self.statusLabel.text = "К сожалению, в оффлайн режиме проверка статуса невозможна"
        }
    }
    
    func statusCheckStart() {
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        //loadingNotification.label.text = "Пров"
    }
    
    func statusCheckStop() {
        //SVProgressHUD.dismiss()
        MBHUD.hide(animated: true)
    }
    
    func swiped() {
        self.dismiss(animated: true) {
            
        }
    }


    
    @IBAction func closeBtn(_ sender: UIButton) {
        swiped()
    }
}
