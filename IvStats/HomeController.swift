//
//  ViewController.swift
//  IvStats
//
//  Created by LaiQiang on 2016-12-30.
//  Copyright © 2016 LaiQiang. All rights reserved.
//

import UIKit
import PGoApi

class HomeController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        let mainColor: UIColor = UIColor.gray
        
//        self.NavController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PTCLogin" {
            let destination = segue.destination as! LoginController
            destination.navigationItem.title = "PTC Login"
            destination.authMethod = "PTC"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

