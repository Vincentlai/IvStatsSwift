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
class PlayerController: UIViewController
    ,MBProgressHUDDelegate
    ,UITableViewDelegate
    ,UITableViewDataSource{

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
    
    @IBOutlet weak var playerTableView: UITableView!
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
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
        if section == 0 {
            return self.playerInfo.count
        }else if section == 1 {
            return self.pokemonStats.count
        }else{
            return self.battleStats.count
        }
    }
    
    @IBAction func showLogoutConfirmAlert(_ sender: UIBarButtonItem) {
        self.showAlert("Are you sure to logout?", message: "")
    }
    
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        let handler = {
            [unowned me = self]
            (action: UIAlertAction) in
            me.doLogout()
        }
        let action = UIAlertAction.init(title: "Yes", style: UIAlertActionStyle.cancel, handler: handler)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

}
