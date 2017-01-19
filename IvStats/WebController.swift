//
//  WebController.swift
//  IvStats
//
//  Created by LaiQiang on 2017-01-09.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import UIKit
import PGoApi
class WebController: UIViewController {

    var GoogleAuthKeyUrl = "https://accounts.google.com/o/oauth2/auth?client_id=848232511240-73ri3t7plvk96pj4f85uj8otdat2alem.apps.googleusercontent.com&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&scope=openid%20email%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email"
    
    @IBOutlet weak var GoogleWeb: UIWebView!
    @IBOutlet weak var NavBar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let url = URL (string: GoogleAuthKeyUrl)
        let request = URLRequest(url: url!)
        GoogleWeb.loadRequest(request)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoogleLogin" {
            let destination = segue.destination as! LoginController
            destination.navigationItem.title = "Google Login"
            destination.authMethod = "Google"
        }
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
