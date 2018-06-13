//
//  EAMapVC.swift
//  EventApp
//
//  Created by Ahmed Durrani on 08/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import GoogleMaps

class EAMapVC: UIViewController {
    @IBOutlet var viewOfMaps: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.viewOfMaps.settings.myLocationButton = true
//        let mapInsets = UIEdgeInsets(top: 0, left: 0, bottom: 180.0 , right: 0.0)
//        self.viewOfMaps.padding = mapInsets
//
//        self.viewOfMaps.settings.compassButton = true
//        self.viewOfMaps.settings.zoomGestures = true
        
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
        self.viewOfMaps.isTrafficEnabled = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
       self.navigationController?.popViewController(animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
