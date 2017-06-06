//
//  RegViewController.swift
//  mfc38
//
//  Created by Sunrizz on 20.04.17.
//  Copyright © 2017 Алексей Усанов. All rights reserved.
//

import UIKit
import EventKit
import MBProgressHUD
import SCLAlertView
import YandexMobileMetrica

class RegViewController: UIViewController {
    
    @IBOutlet weak var ViewCard: UIView!
    let eventStore = EKEventStore()
    
    var firstNameText = String()
    var secondNameText = String()
    var addressText = String()
    var timeText = String()
    var codeText = String()
    
    @IBOutlet weak var firstName: UILabel!
 //   @IBOutlet weak var secondName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var code: UILabel!
    
    func hud() {
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(RegViewController.swiped))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        ViewCard.layer.shadowColor = UIColor.gray.cgColor
        ViewCard.layer.shadowOpacity = 0.8
        ViewCard.layer.shadowOffset = CGSize.zero
        ViewCard.layer.shadowRadius = 3
        
        firstName.text = "\(firstNameText) \(secondNameText)"
        //secondName.text = secondNameText
        address.text = addressText
        time.text = timeText
        code.text = codeText
    }
    
    func swiped() {
        self.dismiss(animated: true) {
        }
    }
    
    @IBAction func calExport(_ sender: UIButton) {
        
        let eventStore : EKEventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event, completion: {
            granted, error in
            
            if (granted) && (error == nil) {
                let event:EKEvent = EKEvent(eventStore: eventStore)
                event.title = "в МФЦ"
                event.location =  self.addressText
                event.startDate = self.dateConvert(timeString: self.timeText)
                event.endDate = self.dateConvert(timeString: self.timeText)
                event.notes = "Код предварительной записи - \(self.codeText)"
                event.addAlarm(EKAlarm())
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                    YMMYandexMetrica.reportEvent("Экспорт в календарь") { (error) in
                    }
                } catch {
                }
            }
        })
        
        SCLAlertView().showTitle(
            "Календарь", // Title of view
            subTitle: "Событие добавлено в календарь.", // String of view
            duration: 2.0, // Duration to show before closing automatically, default: 0.0
            completeText: "Хорошо", // Optional button value, default: ""
            style: .success, // Styles - see below.
            colorStyle: 0xDD5237,
            colorTextButton: 0xFFFFFF
        )
    }
    
    func dateConvert(timeString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM, yyyy EEEE в HH:mm"
        return dateFormatter.date(from: timeString)!
    }
    
    func alertSet() {
        let al = UIAlertController(title: "", message: "Событие успешно добавлено в календарь", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Хорошо", style: .cancel, handler: HudStop)
        al.view.tintColor = UIColor(colorLiteralRed: 218/255, green: 94/255, blue: 60/255, alpha: 1)
        al.addAction(ok)
        self.present(al, animated: true)
    }
    
    func HudStop(alert: UIAlertAction!) {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func convertDateFormater(_ date: String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH-mm-ss"
        dateFormatter.locale = Locale(identifier: "US")
        let dates = dateFormatter.date(from: date)
        print(dates!)
        return dates!
    }
    
    @IBAction func close(_ sender: Any) {
        swiped()
    }
}
