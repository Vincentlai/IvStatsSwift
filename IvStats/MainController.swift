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

var request: PGoApiRequest? = nil

class MainController: UIViewController
, PGoAuthDelegate, PGoApiDelegate, MBProgressHUDDelegate {

    var auth: PGoAuth!
    var hud: MBProgressHUD!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let userDefault = UserDefaults.standard
        if let refreshToken = userDefault.string(forKey: "refreshToken") as String! {
            auth = GPSOAuth()
            auth.delegate = self
            auth.loginWithRefreshToken(withRefreshToken: refreshToken)
            hud = HUDHelper.createHud(withView: self.view, title: "Loging in..", detailText: nil, delegate: self)
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
            self.hud.hide(animated: true)
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
