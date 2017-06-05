//
//  GmapsViewController.swift
//  mfc38
//
//  Created by Алексей Усанов on 12.12.16.
//  Copyright © 2016 Алексей Усанов. All rights reserved.
//

import UIKit
import GoogleMaps

class GmapsViewController: UIViewController {
    
    var latitude: Double = 0
    var longitude: Double = 0
    var address: String = ""
    var area: String = ""
    var status: String = ""

    @IBAction func closeBtn(_ sender: UIButton) {
        self.dismiss(animated: true) {
        }
    }
    
    @IBOutlet weak var map: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.layer.shadowColor = UIColor.gray.cgColor
        map.layer.shadowOpacity = 0.5
        map.layer.shadowOffset = CGSize.zero
        map.layer.shadowRadius = 10
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 14)
    map.camera = camera

        map.isMyLocationEnabled = true
        map.settings.myLocationButton = true
        map.settings.rotateGestures = true
        map.settings.scrollGestures = true
        map.settings.setAllGesturesEnabled(true)
        map.isBuildingsEnabled = true
        map.isTrafficEnabled = true
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = ("\(area), \(address)")
        marker.isFlat = false
        marker.snippet = status
        marker.map = map
    }
}
