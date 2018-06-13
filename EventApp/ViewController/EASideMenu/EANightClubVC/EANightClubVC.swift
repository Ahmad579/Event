//
//  EANightClubVC.swift
//  EventApp
//
//  Created by Ahmed Durrani on 07/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import GoogleMaps

class EANightClubVC: UIViewController {
    @IBOutlet var viewOfMaps: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: DEVICE_LAT , longitude: DEVICE_LONG , zoom: 15.0)
        self.viewOfMaps.camera = camera
        viewOfMaps.isMyLocationEnabled = true
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: DEVICE_LAT, longitude: DEVICE_LONG)
        marker.map = viewOfMaps
        self.viewOfMaps.settings.myLocationButton = true
        let mapInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0 , right: 0.0)
        self.viewOfMaps.padding = mapInsets
        self.viewOfMaps.settings.compassButton = true
        self.viewOfMaps.settings.zoomGestures = true
        self.viewOfMaps.mapType = GMSMapViewType(rawValue: 3)!
        self.viewOfMaps.isTrafficEnabled = true        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
        
    }
   

}
