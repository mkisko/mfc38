//
//  DetailViewController.swift
//  mfc38
//
//  Created by Алексей Усанов on 24.06.16.
//  Copyright © 2016 Алексей Усанов. All rights reserved.
//

import UIKit
import MapKit
import YandexMobileMetrica


//import Canvas
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


class DetailViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var weekView: UIView!
    @IBOutlet weak var officeStatus: UILabel!
    @IBOutlet weak var bossLabel: UILabel!
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var tuesdayLabel: UILabel!
    @IBOutlet weak var wednsdayLabel: UILabel!
    @IBOutlet weak var thursdayLabel: UILabel!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var saturdayLabel: UILabel!
    @IBOutlet weak var sundayLabel: UILabel!
    @IBOutlet var weekDayCollection: [UILabel]!
    @IBOutlet var weekDayColor: [UILabel]!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    
    @IBAction func preReg(_ sender: UIButton) {
      //  self.dismiss(animated: true) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "reg")
        
            self.showDetailViewController(vc!, sender: self)
      //  }
    }
    
    @IBAction func closeBtn(_ sender: UIButton) {
        self.dismiss(animated: true) {
        }
    }
    
    @IBAction func mapShow(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "gmapsVC") as! GmapsViewController
                    vc.latitude = self.latitude
                    vc.longitude = self.longitude
                    vc.address = self.address
                    vc.area = self.area
                    vc.status = self.officeStatus.text!
        
                    self.present(vc, animated: true, completion: nil)
    }
    
    //устанавливаем свойства
    var address: String = ""
    var area: String = ""
    
    var latitude: Double = 0
    var longitude: Double = 0
    var busySend: String = ""
    var boss: String = ""
    
    var monday: String = ""
    var tuesday: String = ""
    var wednesday: String = ""
    var thursday: String = ""
    var friday: String = ""
    var saturday: String = ""
    
    override func viewDidLoad() {

        YMMYandexMetrica.reportEvent("Информация об отделе - \(self.address)") { (error) in
        }
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(RegViewController.swiped))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)

        weekView.layer.shadowColor = UIColor.gray.cgColor
        weekView.layer.shadowOpacity = 0.8
        weekView.layer.shadowOffset = CGSize.zero
        weekView.layer.shadowRadius = 3
        navigationController?.navigationBar.isHidden = false
        
        weekColor()
        //передача параметров
        mondayLabel.text = monday
        tuesdayLabel.text = tuesday
        wednsdayLabel.text = wednesday
        thursdayLabel.text = thursday
        fridayLabel.text = friday
        saturdayLabel.text = saturday
        sundayLabel.text = "Выходной"
        addressLabel.text = "\(area), \(address)"
        navigationItem.title = area
        bossLabel.text = boss
        
        //установка цвета текущего дня недели
        for index in weekDayCollection  {
            let td = weekDay()
            if index.text == td {
                index.textColor = UIColor(colorLiteralRed: 218/255, green: 94/255, blue: 60/255, alpha: 1)
            }
        }
        status()
        super.viewDidLoad()
    }
    
    func swiped() {
        self.dismiss(animated: true) {
        }
    }

    func status() {
        let currentHour = Date()
        let todayFormat = DateFormatter()
        todayFormat.dateFormat = "HH"
        let today = todayFormat.string(from: currentHour)
        if Float(today) < Float(startStatusCheck()) {
            officeStatus.text = "Закрыто"
        } else if Float(today) >= Float(startStatusCheck()) && Float(today) < Float(stopStatusCheck()) {
            officeStatus.text = "Открыто"
        } else if Float(today) >= Float(stopStatusCheck()) {
            officeStatus.text = "Закрыто"
        }
    }
    
    func startStatusCheck() -> String{
        let td = weekDay()
        if td == "Понедельник" {
            var startTime = mondayLabel.text!
            let range = startTime.characters.index(startTime.endIndex, offsetBy: -8)..<startTime.endIndex
            startTime.removeSubrange(range)
            return startTime
        } else if td == "Вторник" {
            var startTime = tuesdayLabel.text!
            let range = startTime.characters.index(startTime.endIndex, offsetBy: -8)..<startTime.endIndex
            startTime.removeSubrange(range)
            return startTime
        } else if td == "Среда" {
            let day = Date()
            let todayFormat = DateFormatter()
            todayFormat.dateFormat = "d"
            let todayDay = todayFormat.string(from: day)
            if Int(todayDay) <= 7 {
                wednsdayLabel.text = "Закрыто"
                return "Закрыто"
            }
            var startTime = wednsdayLabel.text!
            let range = startTime.characters.index(startTime.endIndex, offsetBy: -8)..<startTime.endIndex
            startTime.removeSubrange(range)
            return startTime
        } else if td == "Четверг" {
            var startTime = thursdayLabel.text!
            let range = startTime.characters.index(startTime.endIndex, offsetBy: -8)..<startTime.endIndex
            startTime.removeSubrange(range)
            return startTime
        } else if td == "Пятница" {
            var startTime = fridayLabel.text!
            let range = startTime.characters.index(startTime.endIndex, offsetBy: -8)..<startTime.endIndex
            startTime.removeSubrange(range)
            return startTime
        } else if td == "Суббота" {
            var startTime = saturdayLabel.text!
            let range = startTime.characters.index(startTime.endIndex, offsetBy: -8)..<startTime.endIndex
            startTime.removeSubrange(range)
            return startTime
        } else if td == "Воскресенье" {
              return "Закрыто"
        } else {
            return "Закрыто"
        }
    }
    
    func stopStatusCheck() -> String{
        let td = weekDay()
        if td == "Понедельник" {
            var startTime = mondayLabel.text!
            let range = startTime.startIndex..<startTime.characters.index(startTime.startIndex, offsetBy: 8)
            startTime.removeSubrange(range)
            return startTime
        } else if td == "Вторник" {
            var startTime = tuesdayLabel.text!
            let range = startTime.startIndex..<startTime.characters.index(startTime.startIndex, offsetBy: 8)
            startTime.removeSubrange(range)
            return startTime
        } else if td == "Среда" {
            let day = Date()
            let todayFormat = DateFormatter()
            todayFormat.dateFormat = "d"
            let todayDay = todayFormat.string(from: day)
            if Int(todayDay) <= 7 {
                wednsdayLabel.text = "Закрыто"
                return "Закрыто"
            } else {
                var startTime = wednsdayLabel.text!
                let range = startTime.startIndex..<startTime.characters.index(startTime.startIndex, offsetBy: 8)
                startTime.removeSubrange(range)
                return startTime
            }
        } else if td == "Четверг" {
            var startTime = thursdayLabel.text!
            let range = startTime.startIndex..<startTime.characters.index(startTime.startIndex, offsetBy: 8)
            startTime.removeSubrange(range)
            return startTime
        } else if td == "Пятница" {
            var startTime = fridayLabel.text!
            let range = startTime.startIndex..<startTime.characters.index(startTime.startIndex, offsetBy: 8)
            startTime.removeSubrange(range)
            return startTime
        } else if td == "Суббота" {
            var startTime = saturdayLabel.text!
            let range = startTime.startIndex..<startTime.characters.index(startTime.startIndex, offsetBy: 8)
            startTime.removeSubrange(range)
            return startTime
        } else if td == "Воскресенье" {
            return "Закрыто"
        } else {
            return "Закрыто"
        }
    }
    
    func weekColor() {
        for index in weekDayColor  {
            let td = weekDay()
            if index.text == td {
                index.textColor = UIColor(colorLiteralRed: 218/255, green: 94/255, blue: 60/255, alpha: 1)
            }
        }
    }
    
    func weekDay() -> String {
        let day = Date()
        let todayFormat = DateFormatter()
        todayFormat.dateFormat = "EEEE"
        var today = todayFormat.string(from: day)
        switch today {
        case "понедельник":
            today = "Понедельник"
        case "вторник":
            today = "Вторник"
        case "среда":
            today = "Среда"
        case "четверг":
            today = "Четверг"
        case "пятница":
            today = "Пятница"
        case "суббота":
            today = "Суббота"
        default:
            today = "Воскресенье"
        }
        return today
    }
}
