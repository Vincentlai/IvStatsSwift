//
//  PlayerControllerViewController.swift
//  IvStats
//
//  Created by LaiQiang on 2017-02-01.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import UIKit
import MBProgressHUD

class PlayerController: UIViewController, MBProgressHUDDelegate {

    private var hud: MBProgressHUD!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doFetchPlayerInfo(){
            [unowned me = self](success: Bool) in
            if success {
                me.navigationItem.title = player?.nickname
            }
        }
    }
    
    private func doFetchPlayerInfo(handler: @escaping (Bool) -> ()){
        self.hud = HUDHelper.createHud(withView: self.view, title: "Loading Data...", detailText: nil, delegate: self)
        self.hud.show(animated: true)
        ApiManager.defaultManager.fetchPlayerInfo {
            [unowned me = self] (playerInfo, error) in
            let backgroundQueue = DispatchQueue(label: "backgroundQueue", qos: DispatchQoS.background)
            backgroundQueue.async {
                if let error = error {
                    print("\(error.debugDescription)")
                    DispatchQueue.main.async {
                        self.hud.label.text = "Error"
                        self.hud.hide(animated: true, afterDelay: 0.3)
                        self.showAlert("Error", message: error.description)
                    }
                    handler(false)
                }
                else{
                    player = playerInfo!
                    DispatchQueue.main.async {
                        self.hud.label.text = "Done"
                        self.hud.hide(animated: true, afterDelay: 0.3)
                        handler(true)
                    }
                }
            }
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
