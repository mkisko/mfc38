//
//  NewsDetailViewController.swift
//  mfc38
//
//  Created by Алексей Усанов on 21.07.16.
//  Copyright © 2016 Алексей Усанов. All rights reserved.
//

import UIKit
import ImageSlideshow
import MBProgressHUD

extension String {
    func regex (_ pattern: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let nsstr = self as NSString
            let all = NSRange(location: 0, length: nsstr.length)
            var matches : [String] = [String]()
            regex.enumerateMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: all) {
                (result : NSTextCheckingResult?, _, _) in
                if let r = result {
                    let result = nsstr.substring(with: r.range) as String
                    matches.append(result)
                }}
            return matches
        } catch {
            return [String]()
        }}}

class NewsDetailViewController: UIViewController {
    
    @IBOutlet weak var slideshow: ImageSlideshow!
    var news: String = String()
    var titleNews: String = String()
    var date: String = String()
    var link: String = String()
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var newsDetail: UILabel!
   // @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    
    
    
    
    @IBAction func shareAction(_ sender: AnyObject) {
        let text = "\(titleNews + link) (Отправлено с мобильного приложения \"Мои Документы Иркутской области\")"
        let obj = [text]
        
        let activityVC = UIActivityViewController(activityItems: obj, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        activityVC.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(RegViewController.swiped))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)

        self.title = date
        
        titleView.text = titleNews
        newsDetail.text = news.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        
        Notify().loadingNotify(text: "", view: slideshow)
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.imageG()
        }
    }
    
    func didTap() {
        slideshow.presentFullScreenController(from: self)
    }
    
    func swiped() {
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func closeBtn(_ sender: UIButton) {
        swiped()
    }
    
    func imageG() {
   
        var img:[UIImage] = []
        let newsCount = news.regex("http[^\\s]+(jpg|jpeg)\\b").count
        if newsCount > 0 {
            for index in 0..<newsCount {
                let url = URL(string: news.regex("http[^\\s]+(jpg|jpeg)\\b")[index])
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!)
                img.append(image!)
            }
        } else {
            img.append(UIImage(named: "icon")!)
        }
        var setImg: [ImageSource] = []
        
        for index in 0..<img.count {
            setImg.append(ImageSource(image: img[index]))
        }
        
        DispatchQueue.main.async {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
            self.slideshow.addGestureRecognizer(gestureRecognizer)
            
            self.slideshow.zoomEnabled = true
            self.slideshow.circular = true
            self.slideshow.contentScaleMode = .scaleAspectFit
            if setImg.count > 1 {
                self.slideshow.pageControl.currentPageIndicatorTintColor = UIColor(colorLiteralRed: 218/255, green: 94/255, blue: 60/255, alpha: 1)
                self.slideshow.pageControl.pageIndicatorTintColor = UIColor.lightGray
            } else {
                self.slideshow.pageControl.currentPageIndicatorTintColor = UIColor.clear
                self.slideshow.pageControl.pageIndicatorTintColor = UIColor.lightGray
                
            }
            self.slideshow.setImageInputs(setImg)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            MBProgressHUD.hide(for: self.slideshow, animated: true)
        }
    }
}
