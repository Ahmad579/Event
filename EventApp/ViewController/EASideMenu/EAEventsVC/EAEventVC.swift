//
//  EAEventVC.swift
//  EventApp
//
//  Created by Ahmed Durrani on 07/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class EAEventVC: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var lblNameOfUser: UILabel!
    let photoPicker = PhotoPicker()
     var cover_image: UIImage?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fullName = UserDefaults.standard.string(forKey: "fullName")
        let mblNo = UserDefaults.standard.string(forKey: "mbl")
        let email = UserDefaults.standard.string(forKey: "email")

        lblNameOfUser.text = fullName!
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(EAEventVC.imageTappedForDp(img:)))
        userImage.isUserInteractionEnabled = true
        userImage.addGestureRecognizer(tapGestureRecognizerforDp)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func imageTappedForDp(img: AnyObject)
    {
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) { (orignal, edited) in
            
            self.userImage.image = orignal
            let cgFloat: CGFloat = self.userImage.frame.size.width/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(self.userImage, radius: CGFloat(someFloat))
            self.cover_image = orignal
            
            let idOfUser = UserDefaults.standard.string(forKey: "id")
            
            let params =        ["userid"                    :  "\(idOfUser!)"  ,
                               ] as [String : Any]
            
            WebServiceManager.multiPartImage(params: params  as Dictionary<String, AnyObject> , serviceName: UPDATE_PROFILE_PIC, imageParam:"file", serviceType: "Update Avatar", profileImage: self.userImage.image, cover_image_param: "file", cover_image: nil , modelType: UserProfile.self, success: { (response) in
                let responseObj = response as! UserProfile
                
                if responseObj.success == true {
                    self.showAlert(title: "", message: responseObj.message!, controller: self)
                    
                    if responseObj.userProfile?.imageName == nil {
                        let cgFloat: CGFloat = self.userImage.frame.size.width/2.0
                        let someFloat = Float(cgFloat)
                        WAShareHelper.setViewCornerRadius(self.userImage , radius: CGFloat(someFloat))
                        self.userImage.image = orignal

                    } else {
                        let cgFloat: CGFloat = self.userImage.frame.size.width/2.0
                        let someFloat = Float(cgFloat)
                        WAShareHelper.setViewCornerRadius(self.userImage , radius: CGFloat(someFloat))
                        let imageOfUser = responseObj.userProfile?.image?.replacingOccurrences(of: " ", with: "%20")
                        WAShareHelper.loadImage(urlstring:imageOfUser! , imageView: self.userImage!, placeHolder: "profile")

                    }
                   
                    
                }
                else
                {
                    self.showAlert(title: "", message: responseObj.message!, controller: self)

                }
                
            }) { (error) in
//                JSSAlertView().danger(self, title: KMessageTitle, text: error.description)
                
                
            }
            
        }
    }
    
    @IBAction func btnMap_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EAMapVC") as? EAMapVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
        
    }
    
    @IBAction func btnLogout_Pressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        UserDefaults.standard.set(nil  , forKey : "fullName")
        UserDefaults.standard.set(nil  , forKey : "id")
        UserDefaults.standard.set(nil  , forKey : "email")
        UIApplication.shared.keyWindow?.rootViewController = vc

    }
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
