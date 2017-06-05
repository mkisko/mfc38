//
//  TimeSlotDataSource.swift
//  mfc38
//
//  Created by Sunrizz on 18.05.17.
//  Copyright © 2017 Алексей Усанов. All rights reserved.
//

import UIKit

class TimeSlotDataSource: NSObject, UITableViewDataSource {
    
        var time = [String]()
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return time.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "time", for: indexPath) as! TimeTableViewCell
        cell.Title.text = convertDateFormaterForSelf(time[indexPath.row])
        return cell
    }
    
    func convertDateFormaterForSelf(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH-mm-ss"
        dateFormatter.locale = Locale(identifier: "US")
        let dates = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "EEEE, d MMMM в HH:mm"
        dateFormatter.locale = Locale(identifier: "RU")
        let timeStamp = dateFormatter.string(from: dates!)
        
        return timeStamp
    }

    
}
