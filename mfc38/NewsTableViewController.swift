//
//  NewsTableViewController.swift
//  mfc38
//
//  Created by Алексей Усанов on 21.07.16.
//  Copyright © 2016 Алексей Усанов. All rights reserved.
//

import UIKit
import MBProgressHUD
import YandexMobileMetrica

class NewsTableViewController: UITableViewController, XMLParserDelegate {
    
    var dateStr = String()
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    var cat = NSMutableString()
    var category = NSMutableString()
    var link = NSMutableString()
    var images:[String] = [];
    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    let searchController = UISearchController(searchResultsController: nil)
    var newsText = String()
    
    override func viewDidLoad() {
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "icon"), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage(named: "icon")
        
        
                tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        
        loadingNotification.label.text = ""
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.beginParsing()
            DispatchQueue.main.sync(execute: {
                MBProgressHUD.hide(for: self.view, animated: true)
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
        }
        
        self.refreshControl?.backgroundColor = UIColor.white
        self.refreshControl?.tintColor = UIColor(colorLiteralRed: 218/255, green: 94/255, blue: 60/255, alpha: 1)
        self.refreshControl?.addTarget(self, action: #selector(NewsTableViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        
     //   searchController.searchResultsUpdater = self as! UISearchResultsUpdating
//        searchController.dimsBackgroundDuringPresentation = false
//        definesPresentationContext = true
//        tableView.tableHeaderView = searchController.searchBar
//        
        
        super.viewDidLoad()
    }
    
    func refresh(_ sender:AnyObject) {
        beginParsing()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        YMMYandexMetrica.reportEvent("Список новостей") { (error) in
        }
    }
    
    func beginParsing()
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        posts = []
        parser = XMLParser(contentsOf:(URL(string:"http://mfc38.ru/information-service/news?format=feed&type=rss"))!)!
        parser.delegate = self
        parser.parse()
        tableView.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            date = NSMutableString()
            date = ""
            cat = NSMutableString()
            cat = ""
            category = NSMutableString()
            category = ""
            link = NSMutableString()
            link = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "title") {
            title1.append(string)
        } else if element.isEqual(to: "pubDate") {
            date.append(string)
        } else if element.isEqual(to: "description") {
            cat.append(string)
        } else if element.isEqual(to: "category") {
            category.append(string)
        } else if element.isEqual(to: "link") {
            link.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "item") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "title" as NSCopying)
            }
            if !date.isEqual(nil) {
                elements.setObject(date, forKey: "date" as NSCopying)
            }
            if !cat.isEqual(nil) {
                elements.setObject(cat, forKey: "description" as NSCopying)
            }
            if !category.isEqual(nil) {
                elements.setObject(category, forKey: "category" as NSCopying)
            }
            if !link.isEqual(nil) {
                elements.setObject(link, forKey: "link" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! NewsTableViewCell
        
        let titleString = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "title") as! String
        let newTitle = titleString.trimmingCharacters(in: CharacterSet.init(charactersIn: "\t, \n"))
        
        cell.titleNews.text = newTitle
        
        let dateString = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "date") as? String
        
        let newDate = dateString!.trimmingCharacters(in: CharacterSet.init(charactersIn: "\t, \n"))
        
        cell.dateNewsLabel.text = convertDateFormater(newDate)
        dateStr = convertDateFormater(newDate)
        
        return cell
    }
    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "US")
        let dates = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "d MMMM, EEEE"
        dateFormatter.locale = Locale(identifier: "RU")
        let timeStamp = dateFormatter.string(from: dates!)
        
        return timeStamp
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let controller = segue.destination as! NewsDetailViewController
                
                controller.news = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "description") as! String
                
                controller.titleNews = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "title") as! String
                
                let dateString = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "date") as? String
                
                let newDate = dateString!.trimmingCharacters(in: CharacterSet.init(charactersIn: "\t, \n"))
                
                controller.link = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "link") as! String
                
                controller.date = convertDateFormater(newDate)
            }
        }
    }
}
