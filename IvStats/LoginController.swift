//
//  LoginController.swift
//  IvStats
//
//  Created by LaiQiang on 2016-12-30.
//  Copyright © 2016 LaiQiang. All rights reserved.
//

import UIKit
import PGoApi
class LoginController: UIViewController, PGoAuthDelegate, PGoApiDelegate {

    var auth: PGoAuth!
    var request: PGoApiRequest? = nil
    var authMethod: String!
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var mainField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        if (self.authMethod == "PTC") {
            loginButton.setTitle("Login With PTC", for: loginButton.state)
            loginButton.backgroundColor = backgroundColor
        }else {
            mainLabel.text = "Token"
            passwordLabel.isHidden = true
            passwordField.isHidden = true
        }
    }
    
    @IBAction func login(_ login: Button) {
        if(self.authMethod == "PTC"){
            if(mainField.text! == "" || passwordField.text! == ""){
                showAlert("Error", message: "Username or Password cannot be empty.")
                return
            }
            auth = PtcOAuth()
            auth.delegate = self
            auth.login(withUsername: mainField.text!, withPassword: passwordField.text!)
        }else{
            if mainField.text! == "" {
                showAlert("Error", message: "Authorization cannot be empty.")
                return
            }
            auth = GPSOAuth()
            auth.delegate = self
            auth.login(withToken: mainField.text!)
        }
    }
    
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func didReceiveAuth() {
        request = PGoApiRequest(auth: auth)
        request!.simulateAppStart()
        request!.makeRequest(intent: .login, delegate: self)
    }
    
    func didNotReceiveAuth() {
        showAlert("Error", message: "Failed to Login.")
    }
    
    func didReceiveApiResponse(_ intent: PGoApiIntent, response: PGoApiResponse){
        if intent == .login {
            print("\(response)")
            self.performSegue(withIdentifier: "Dashboard", sender: self)
        }
        
    }
    
    func didReceiveApiError(_ intent: PGoApiIntent, statusCode: Int?) {
        print("API Error: \(statusCode)")
    }
    
    func didReceiveApiException(_ intent: PGoApiIntent, exception: PGoApiExceptions) {
        print("\(exception)")
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
