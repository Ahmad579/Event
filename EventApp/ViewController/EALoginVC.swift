//
//  EALoginVC.swift
//  EventApp
//
//  Created by Ahmed Durrani on 06/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import GoogleSignIn

class EALoginVC: UIViewController , GIDSignInUIDelegate , GIDSignInDelegate {
    @IBOutlet weak var viewOfTextField: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnLinkToRegister: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self

        let userID = UserDefaults.standard.string(forKey: "id")

        if userID == nil  {

        } else {
            WAShareHelper.goToHomeController(vcIdentifier: "MainTabBarVC", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "EASideMenuVC")
        }
        
        
        txtEmail.setLeftPaddingPoints(10)
        txtPassword.setLeftPaddingPoints(10)

        WAShareHelper.setBorderAndCornerRadius(layer: viewOfTextField.layer, width: 1.0, radius: 20, color: UIColor(red: 26/255.0, green: 83/255.0, blue: 155/255.0, alpha: 1.0))
        WAShareHelper.setBorderAndCornerRadius(layer: btnLogin.layer, width: 1.0, radius: 20, color: UIColor(red: 26/255.0, green: 83/255.0, blue: 155/255.0, alpha: 1.0))
        WAShareHelper.setBorderAndCornerRadius(layer: btnLinkToRegister.layer, width: 1.0, radius: 20, color: UIColor(red: 26/255.0, green: 83/255.0, blue: 155/255.0, alpha: 1.0))
//        txtEmail.text = "ahmadyar@ibexglobal.com"
//        txtPassword.text = "123456789"
        
    }
    
 
    
//
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSign_Pressed(_ sender: UIButton) {
        
        let loginParam =  ["email"           : txtEmail.text!
                ] as [String : Any]
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: LOGIN, isLoaderShow: true, serviceType: "Sign Up", modelType: UserResponse.self, success: { (response) in
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
    }
    
    @IBAction func btnFacebook_Pressed(_ sender: UIButton) {
        let facebookMangager = SocialMediaManager()
        facebookMangager.facebookSignup(self)
        facebookMangager.successBlock = { (response) -> Void in
            self.signInWebservice(response as! Dictionary)
            
        }
    }
    
    func signInWebservice(_ params: Dictionary<String, String>) {
        
        let email : String?
        //        let idOfFb : String?
        let firstName : String?
        let lastName : String?
     
                email       =    params["data[User][email]"]
                firstName   =  params["data[User][first_name]"]
                lastName    =  params["data[User][last_name]"]
      
            let param = ["email"         :  email! ,
                         "firstname"      : firstName! ,
                         "lastname"       : lastName! ,
                         "provider"       : "facebook"
                     ] as [String : Any]
        
        
        WebServiceManager.post(params:param as Dictionary<String, AnyObject> , serviceName: SOCIALLOGINORREGISTER, isLoaderShow: true, serviceType: "Social Sign In", modelType: UserResponse.self, success: { (response) in
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

            } else {
                self .showAlert(title: "OPEN SPOT", message: "You must be sign Up first" , controller: self)
            }
        }, fail: { (error) in
            self.showAlert(title: "OPEN SPOT", message: error.description , controller: self)
        }, showHUD: true)
        
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            let param = ["email"         :  email! ,
                         "firstname"      : fullName! ,
                         "lastname"       : " " ,
                         "provider"       : "gmail"
                ] as [String : Any]
            
            
            WebServiceManager.post(params:param as Dictionary<String, AnyObject> , serviceName: SOCIALLOGINORREGISTER, isLoaderShow: true, serviceType: "Social Sign In", modelType: UserResponse.self, success: { (response) in
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
                    
                } else {
                    self .showAlert(title: "OPEN SPOT", message: "You must be sign Up first" , controller: self)
                }
            }, fail: { (error) in
                self.showAlert(title: "OPEN SPOT", message: error.description , controller: self)
            }, showHUD: true)
            
            // ...
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        print("Some Error ")
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    
    @IBAction func btnGoogleSign_Pressed(_ sender: UIButton) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    @IBAction func btnSignUp_Pressed(_ sender: UIButton) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EASignUPVC") as? EASignUPVC
           self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}
