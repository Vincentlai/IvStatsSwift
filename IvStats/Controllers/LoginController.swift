//
//  LoginController.swift
//  IvStats
//
//  Created by LaiQiang on 2016-12-30.
//  Copyright © 2016 LaiQiang. All rights reserved.
//

import UIKit
import PGoApi
class LoginController: UIViewController{

    var authMethod: AuthType!
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var mainField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        if (self.authMethod == AuthType.PTC) {
            loginButton.setTitle("Login With PTC", for: loginButton.state)
            loginButton.backgroundColor = backgroundColor
        }else {
            mainLabel.text = "Token"
            passwordLabel.isHidden = true
            passwordField.isHidden = true
        }
    }
    
    @IBAction func login(_ login: Button) {
        let handler = {
            [unowned me = self] (error: NSError?) in
            
            if let error = error {
//                me.hud.hide(animated: true)
                me.showAlert("Error", message: error.localizedDescription)
            }
            else{
//                me.hud.hide(animated: true)
                self.performSegue(withIdentifier: "Dashboard", sender: self)
            }
        }
        
        if(self.authMethod == AuthType.PTC){
            if(mainField.text! == "" || passwordField.text! == ""){
                showAlert("Error", message: "Username or Password cannot be empty.")
                return
            }
            ApiManager.defaultManager.login(withUsername: mainField.text!, password: passwordField.text!, handler: handler)

        }else{
            if mainField.text! == "" {
                showAlert("Error", message: "Authorization cannot be empty.")
                return
            }
            ApiManager.defaultManager.login(withToken: mainField.text!, handler: handler)
//            ApiManager.defaultManager.login(withRefreshToken: "1/4dGn7b86suZkl4WwbpdEyamh-sdo9eeHkK1OEzj6WQQ", handler: handler)
        }
    }
    
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
