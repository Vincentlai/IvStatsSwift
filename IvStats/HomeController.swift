//
//  ViewController.swift
//  IvStats
//
//  Created by LaiQiang on 2016-12-30.
//  Copyright © 2016 LaiQiang. All rights reserved.
//

import UIKit
import PGoApi
import MBProgressHUD
class HomeController: UIViewController, MBProgressHUDDelegate{

    var auth: PGoAuth!
    var hud: MBProgressHUD!
    
    @IBOutlet weak var googleLogin: Button!
    @IBOutlet weak var ptcLogin: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.googleLogin.isHidden = true
        self.ptcLogin.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if ApiManager.defaultManager.isLoggedIn {
            self.hud = HUDHelper.createHud(withView: self.view, title: "Loging in..", detailText: nil, delegate: self)
            let handler = {
                [unowned me = self] (error: NSError?) in
                
                if let error = error {
                    me.hud.hide(animated: true)
                    me.showAlert("Error", message: error.localizedDescription)
                    //                    me.showAlert("Error", message: "Failed to Login.")
                    self.googleLogin.isHidden = false
                    self.ptcLogin.isHidden = false
                }
                else{
                    me.hud.hide(animated: true)
                    me.performSegue(withIdentifier: "HasUserConfig", sender: self)
                }
            }
            ApiManager.defaultManager.autoLogin(handler: handler)
        }else{
            self.googleLogin.isHidden = false
            self.ptcLogin.isHidden = false
        }
        
    }
    
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
//        let handler = {
//            (action: UIAlertAction) in
//            print("heiheihei")
//            
//        }
//        let action = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.cancel, handler: handler)
//        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PTCLogin" {
            let destination = segue.destination as! LoginController
            destination.navigationItem.title = "PTC Login"
            destination.authMethod = AuthType.PTC
        }
    }


}

