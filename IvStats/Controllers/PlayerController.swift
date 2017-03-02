//
//  PlayerControllerViewController.swift
//  IvStats
//
//  Created by LaiQiang on 2017-02-01.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import UIKit
import MBProgressHUD
import Cartography
import MessageUI

class PlayerController: UIViewController
    ,MBProgressHUDDelegate
    ,UITableViewDelegate
    ,UITableViewDataSource
    ,MFMailComposeViewControllerDelegate{

    private let playerInfo: [String] = [
    "Level", "Stardust", "Total XP Gained", "Total Km Walked", "Total PokeStops Visited"]
    private let pokemonStats: [String] = [
    "Total Pokemon in Storage", "Total Evolutions", "Total Pokeballs Used", "Pokemon Deployed", "Pokemon Captured", "Pokemon Encoutered"]
    private let battleStats: [String] = [
    "Total Gym Attacks", "Total Gym Attack Won", "Total Gym Trainings", "Total Gym Trainings Won", "Total Prestige Raise", "Total Prestige Drop"]
    private let playerInfoImageName: [String] = ["level", "stardust", "xp", "km_walked", "pokestop"
    ]
    private let pokemonStatsImageName: [String] =
        ["pokemons", "total_evolve", "ball", "total_deployed", "total_captured", "total_seen"]
    private let battleStatsImageName: [String] =
    ["attack", "attack2", "defense", "defense2", "prestige_raise", "prestige_drop"]
    private let menuItems: [SettingItemType] = [.About, .Support, .Logout]
    
    @IBOutlet weak var playerTableView: UITableView!
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    private var dropdownMenu: UITableView?
    var popover: Popover!
    
    private var playerInfoValue: [String] = []
    private var pokemonStatsValue: [String] = []
    private var battleStatsValue: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        playerTableView.delegate = self
        playerTableView.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.title = player.nickname
        self.playerInfoValue = player.getPlayerInfo()
        self.pokemonStatsValue = player.getPokemonStats()
        self.battleStatsValue = player.getBattleStats()
        self.playerTableView.reloadData()
    }
    
    private func doLogout() {
        ApiManager.defaultManager.logout()
        pokemonList.removeAll()
        pokemonResultList.removeAll()
        candyList.removeAll()
        player = Player()
        let rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "FirstNavigationController")
        self.present(rootViewController, animated:true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.dropdownMenu
        {
            if indexPath.row == 0 {
                
            }else if indexPath.row == 1 {
                if !MFMailComposeViewController.canSendMail() {
                    print("Mail services are not available")
                }
                let emailTitle = "IvStats Support"
                let toRecipents = ["vincent.lai.cn@gmail.com"]
                let mailController = MFMailComposeViewController()
                mailController.mailComposeDelegate = self
                mailController.setSubject(emailTitle)
                mailController.setToRecipients(toRecipents)
//                self.present(mailController, animated: true, completion: nil)
                self.show(mailController, sender: self)
            }else {
                self.showAlert("Are you sure to logout?", message: "", style: .Logout)
            }
        }
        self.popover.dismiss()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.dropdownMenu
        {
            return 1
        }else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.dropdownMenu
        {
            let cell = dropdownMenu?.dequeueReusableCell(withIdentifier: "dropdown menu item", for: indexPath)
            if let dropdownMenuCell = cell as? DropdownMenuItem {
                dropdownMenuCell.settingMenuItem = self.menuItems[indexPath.row]
            }
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerInfoCell", for: indexPath) as! playerInfoCell
            var label: String
            var value: String = "N/A"
            var imageName: String
            if indexPath.section == 0 {
                label = self.playerInfo[indexPath.row]
                if self.playerInfoValue.count == self.playerInfo.count {
                    value = self.playerInfoValue[indexPath.row]
                }
                imageName = self.playerInfoImageName[indexPath.row]
            }else if indexPath.section == 1 {
                label = self.pokemonStats[indexPath.row]
                if self.pokemonStatsValue.count == self.pokemonStats.count {
                    value = self.pokemonStatsValue[indexPath.row]
                }
                imageName = self.pokemonStatsImageName[indexPath.row]
            }else{
                label = self.battleStats[indexPath.row]
                if self.battleStatsValue.count == self.battleStats.count {
                    value = self.battleStatsValue[indexPath.row]
                }
                imageName = self.battleStatsImageName[indexPath.row]
            }
            cell.updateUi(withItemLabel: label, value: value, itemIconName: imageName)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.dropdownMenu {
            return 40.0
        }else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == self.dropdownMenu
        {
            return 0
        }else {
            return 35
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if tableView == self.dropdownMenu {
            return nil
        }
        let headView = UIView()
        let headerName = UILabel()
        headView.addSubview(headerName)
        constrain(headerName)
        {
            (view) in
            view.centerY == view.superview!.centerY
            view.width == view.superview!.width
            view.height == 35
        }
        headView.backgroundColor = UIColor.groupTableViewBackground
        headerName.font = UIFont.init(name: primaryFontFamily, size: 18)
        headerName.textAlignment = NSTextAlignment.center
        if section == 0
        {
            headerName.text = "-Player Info-"
            return headView
        }else if section == 1 {
            headerName.text = "-Pokemon Stats-"
            return headView
        }else{
            headerName.text = "-Battle Stats-"
            return headView
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.dropdownMenu {
            return 3
        }else {
            if section == 0 {
                return self.playerInfo.count
            }else if section == 1 {
                return self.pokemonStats.count
            }else{
                return self.battleStats.count
            }
        }
    }
    
    @IBAction func showLogoutConfirmAlert(_ sender: UIBarButtonItem) {
        self.dropdownMenu = UITableView(frame: CGRect(x: 0, y: 0, width: 150, height: 120))
        dropdownMenu?.delegate = self
        dropdownMenu?.dataSource = self
        dropdownMenu?.isScrollEnabled = false
        dropdownMenu?.separatorStyle = .none
        dropdownMenu?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let dropdownMenuOptions: [PopoverOption] = [.type(.down),
                                                    .cornerRadius(4),
                                                    .showBlackOverlay(true),
                                                    .blackOverlayColor(UIColor.init(white: 0, alpha: 0.4)),
                                                    .sideEdge(5)]
        dropdownMenu?.register(DropdownMenuItem.self, forCellReuseIdentifier: "dropdown menu item")
        self.popover = Popover(options: dropdownMenuOptions)
        let startPoint = CGPoint(x: self.view.frame.size.width - 27, y: playerTableView.frame.origin.y - 5)
        self.popover.show(self.dropdownMenu!, point: startPoint)
    }

    @objc(mailComposeController:didFinishWithResult:error:)
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: NSError?) {
        switch result {
        case MFMailComposeResult.cancelled:
            break
        case MFMailComposeResult.saved:
            break
        case MFMailComposeResult.sent:
            self.showAlert("Thank you for reporting issue to us", message: "We will get back to you as soon as possible.",style: .Ok)
            break
        case MFMailComposeResult.failed:
            self.showAlert("Error occurred while sending Email.", message: "Please try again later.",style: .Cancel)
            break
        }
        self.dismiss(animated: true, completion: nil)
        self.showAlert("Thank you for reporting issue to us", message: "We will get back to you as soon as possible.",style: .Ok)
    }
    
    func showAlert(_ title: String, message: String, style: AlertStyle) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        if style == .Logout {
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
            let handler = {
                [unowned me = self]
                (action: UIAlertAction) in
                me.doLogout()
            }
            let action = UIAlertAction.init(title: "Yes", style: UIAlertActionStyle.cancel, handler: handler)
            alert.addAction(action)
        }else if style == .Ok{
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        }else {
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
}
