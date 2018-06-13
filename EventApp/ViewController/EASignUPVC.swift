//
//  EASignUPVC.swift
//  EventApp
//
//  Created by Ahmed Durrani on 07/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class EASignUPVC: UIViewController {
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtConfirmPass: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    var isTermConditionCheck : Bool?
    @IBOutlet weak var checkOrUncheckImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        isTermConditionCheck = false
        txtEmail.setLeftPaddingPoints(10)
        txtPassword.setLeftPaddingPoints(10)
//        txtUserName.setLeftPaddingPoints(10)
        txtFirstName.setLeftPaddingPoints(10)
        txtLastName.setLeftPaddingPoints(10)
        txtConfirmPass.setLeftPaddingPoints(10)
//        (red: 26/255.0, green: 83/255.0, blue: 155/255.0, alpha: 1.0)

     

//        WAShareHelper.setBorderAndCornerRadius(layer: txtUserName.layer, width: 1.0, radius: 20, color: UIColor(red: 26/255.0, green: 83/255.0, blue: 155/255.0, alpha: 1.0))
        WAShareHelper.setBorderAndCornerRadius(layer: txtFirstName.layer, width: 1.0, radius: 20, color: UIColor(red: 26/255.0, green: 83/255.0, blue: 155/255.0, alpha: 1.0))
        WAShareHelper.setBorderAndCornerRadius(layer: txtLastName.layer, width: 1.0, radius: 20, color: UIColor(red: 26/255.0, green: 83/255.0, blue: 155/255.0, alpha: 1.0))
        WAShareHelper.setBorderAndCornerRadius(layer: txtConfirmPass.layer, width: 1.0, radius: 20, color: UIColor(red: 26/255.0, green: 83/255.0, blue: 155/255.0, alpha: 1.0))
        WAShareHelper.setBorderAndCornerRadius(layer: txtPassword.layer, width: 1.0, radius: 20, color: UIColor(red: 26/255.0, green: 83/255.0, blue: 155/255.0, alpha: 1.0))
        WAShareHelper.setBorderAndCornerRadius(layer: btnSignUp.layer, width: 1.0, radius: 20, color: UIColor(red: 26/255.0, green: 83/255.0, blue: 155/255.0, alpha: 1.0))
        WAShareHelper.setBorderAndCornerRadius(layer: txtEmail.layer, width: 1.0, radius: 20, color: UIColor(red: 26/255.0, green: 83/255.0, blue: 155/255.0, alpha: 1.0))
        WAShareHelper.setBorderAndCornerRadius(layer: btnLogin.layer, width: 1.0, radius: 20, color: UIColor(red: 26/255.0, green: 83/255.0, blue: 155/255.0, alpha: 1.0))



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnTermCondition_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true {
            isTermConditionCheck = true
            checkOrUncheckImage.image = UIImage(named: "check")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EATermAndConditionVC") as? EATermAndConditionVC
            self.navigationController?.pushViewController(vc!, animated: true)
            
        } else {
            isTermConditionCheck = false
            checkOrUncheckImage.image = UIImage(named: "unCheck")
        }
        
    }
    
    @IBAction func btnSignUP_Pressed(_ sender: UIButton) {
        let loginParam =  [ "firstname"           : txtFirstName.text!,
                            "lastname"          : txtLastName.text!,
                             "password"       : txtPassword.text! ,
                             "email"           : txtEmail.text!
            
            ] as [String : Any]
        
        if isTermConditionCheck == true {
            WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: SIGNUP, isLoaderShow: true, serviceType: "Sign Up", modelType: UserResponse.self, success: { (response) in
                let responseObj = response as! UserResponse
                
                if responseObj.success == true {

                    localUserData = responseObj.data
                    let firstName = localUserData.firstname
                    let lastName  = localUserData.lastname
                    let fullName  = "\(firstName!) \(lastName!)"
                    UserDefaults.standard.set(fullName , forKey: "fullName")
                    UserDefaults.standard.set(localUserData.email , forKey: "email")
                    UserDefaults.standard.set(localUserData.id, forKey: "id")
                    WAShareHelper.goToHomeController(vcIdentifier: "MainTabBarVC", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "EASideMenuVC")
                    

                    
                }else {
                    self.showAlert(title: "Empty", message: responseObj.message!, controller: self)
                    
                    
                }
                //        }
            }, fail: { (error) in
                
                
            }, showHUD: true)
        } else {
            self.showAlert(title: "Event App", message: "You must be select the term and condition", controller: self)
            
        }
        

        
    }
    
    @IBAction func btnLogin_Pressed(_ sender: UIButton) {
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
