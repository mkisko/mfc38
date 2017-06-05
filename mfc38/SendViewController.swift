//
//  SendViewController.swift
//  mfc38
//
//  Created by Sunrizz on 12.04.17.
//  Copyright © 2017 Алексей Усанов. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import CoreData
import SwiftValidator
import SCLAlertView
import YandexMobileMetrica

class SendViewController: UIViewController, UITextFieldDelegate, ValidationDelegate {
    
    var validator = Validator()
    var codeFull: [String: Any] = [:]
    var sessionManager = SessionManager.default
    
    let managedObjectContext  = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var requiredLabel: UILabel!
    @IBOutlet weak var sendReg: UIButton!
    @IBOutlet weak var captcha: UIImageView!
    @IBOutlet weak var nameFiel: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var captchaField: UITextField!
    
    let captchaUrl = "\(urlConstraints().coreURL)getCaptcha"
    let regUrl = "\(urlConstraints().coreURL)register/"
    
    var address = String()
    var type = String()
    var time = String()
    var stime = String()
    
    var serverId = String()
    var serviceId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        YMMYandexMetrica.reportEvent("Предварительная запись") { (error) in
        }
        
        validator.registerField(textField: nameFiel, rules: [RequiredRule()])
        validator.registerField(textField: lastNameField, rules: [RequiredRule()])
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(RegViewController.swiped))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        self.captchaField.delegate = self
        self.nameFiel.delegate = self
        self.lastNameField.delegate = self
        self.phoneField.delegate = self
        
        getCaptha()
    }
    
    func validationFailed(errors: [UITextField : ValidationError]) {
        for (_, error) in errors {
            error.errorLabel?.text = error.errorMessage
        }
    }
    
    func validationSuccessful() {
    }
    
    @IBAction func refresh(_ sender: Any) {
        getCaptha()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        captchaField.resignFirstResponder()
        nameFiel.resignFirstResponder()
        lastNameField.resignFirstResponder()
        phoneField.resignFirstResponder()
    }
    
    @IBAction func sendReg(_ sender: Any) {
        validator.validate(delegate: self)
        captchaField.resignFirstResponder()
        nameFiel.resignFirstResponder()
        lastNameField.resignFirstResponder()
        phoneField.resignFirstResponder()
        
        hud()
        let parameters: Parameters = [
            "name1": self.nameFiel.text!,
            "name2": self.lastNameField.text!,
            "captcha": self.captchaField.text!,
            "phone": self.phoneField.text!
        ]
        
        let encString = "\(regUrl)\(serverId)/\(serviceId)/\(stime)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        self.sessionManager.request(encString!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: [:]).responseJSON() {
            response in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.codeFull = response.result.value! as! [String:Any]
            self.saveToCD()
        }
    }
    
    func saveToCD() {
        if Array(self.codeFull.keys)[0] == "error" {
            SCLAlertView().showTitle(
                "Внимание",
                subTitle: "Проверьте, что бы все поля были заполнены",
                duration: 4.0,
                completeText: "Хорошо",
                style: .warning,
                colorStyle: 0xDD5237,
                colorTextButton: 0xFFFFFF
            )
        } else {
            let entityDescription = NSEntityDescription.entity(forEntityName: "Prereg", in: self.managedObjectContext)
            let preReg = Prereg(entity: entityDescription!, insertInto: self.managedObjectContext)
            var code:String = String()
            for (_, _) in self.codeFull {
                code = String(describing: self.codeFull["registrationId"]!)
            }
            preReg.code = code
            preReg.time = self.time
            preReg.firstName = self.nameFiel.text
            preReg.secondName = self.lastNameField.text
            preReg.address = self.address
            do {
                try self.managedObjectContext.save()
                self.alertSet()
                
                print("saved!")
            } catch {
                print("failed!")
            }
        }
    }
    
    func alertSet() {
        SCLAlertView().showTitle(
            "Поздравляем",
            subTitle: "Вы успешно прошли регистрацию!",
            duration: 0.0,
            completeText: "Хорошо",
            style: .success,
            colorStyle: 0xDD5237,
            colorTextButton: 0xFFFFFF
            ).setDismissBlock {
                YMMYandexMetrica.reportEvent("Успешная регистрация") { (error) in
                }
                self.dismiss(animated: true) {
                }
        }
    }
    
    func getCaptha() {
        if Reachability.isConnectedToNetwork() {
            hud()
            self.sessionManager.request(captchaUrl).responseData() {
                response in
                if response.result.isSuccess {
                    self.captcha.image = UIImage(data: response.result.value!)
                    MBProgressHUD.hide(for: self.view, animated: true)
                } else {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
                    loadingNotification.mode = .text
                    loadingNotification.label.text = "Сервис недоступен"
                }
            }
        } else {
            let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.text
            loadingNotification.label.text = "Проверьте доступ к сети"
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
        swiped()
    }
    
    func swiped() {
        self.dismiss(animated: true) {
        }
    }
    
    func hud() {
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
    }
}
