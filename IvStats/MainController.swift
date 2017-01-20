//
//  MainController.swift
//  IvStats
//
//  Created by LaiQiang on 2017-01-17.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import UIKit
import PGoApi
import MBProgressHUD
class MainController: UIViewController
, PGoAuthDelegate, PGoApiDelegate, MBProgressHUDDelegate {

    var auth: PGoAuth!
    var request: PGoApiRequest? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        auth = GPSOAuth()
        auth.delegate = self
        let userDefault = UserDefaults.standard
        if let refreshToken = userDefault.string(forKey: "refreshToken") as String! {
            print("\(refreshToken)")
            auth.loginWithRefreshToken(withRefreshToken: refreshToken)
        }else{
            self.performSegue(withIdentifier: "NoUserConfig", sender: self)
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
            self.performSegue(withIdentifier: "HasUserConfig", sender: self)
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