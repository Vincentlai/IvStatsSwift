//
//  PokemonController.swift
//  IvStats
//
//  Created by LaiQiang on 2017-01-18.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import UIKit
import MBProgressHUD
import PGoApi

var user: User?
var pokemonList = Array<Pokemon>()
var candyList = Array<Candy>()

class PokemonController: UIViewController
        , MBProgressHUDDelegate
        , PGoApiDelegate
        , UICollectionViewDelegate
        , UICollectionViewDataSource
{


    @IBOutlet weak var searchBar: UISearchBar!
    
    private var hud: MBProgressHUD!
    private var pokemonCollectionview: UICollectionView!
//    private var isGridView: Bool {
//        get {
//            if self.isGridView == nil {
//                return true
//            }
//            return self.isGridView
//        }
//        set {
//            self.isGridView = newValue
//        }
//        
//    }
    var list = Pogoprotos.Networking.Responses.GetPlayerResponse()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCollectionView()
    }
    
    private func setCollectionView() {
        let rect = CGRect.init(x: self.view.frame.origin.x , y: self.searchBar.frame.origin.y + self.searchBar.frame.height, width: self.view.frame.width, height: (self.tabBarController?.tabBar.frame.origin.y)! - (self.searchBar.frame.origin.y + self.searchBar.frame.height))
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = UICollectionViewScrollDirection.vertical
        flowlayout.minimumInteritemSpacing = 2
        flowlayout.minimumLineSpacing = 2
        flowlayout.itemSize = CGSize.init(width: self.view.frame.width/3 - 10, height: 100)
        self.pokemonCollectionview = UICollectionView.init(frame: rect, collectionViewLayout: flowlayout)
        self.pokemonCollectionview.delegate = self
        self.pokemonCollectionview.dataSource = self
        self.pokemonCollectionview.showsVerticalScrollIndicator = true
        self.pokemonCollectionview.backgroundColor = UIColor.clear
        self.pokemonCollectionview.register(PokemonCollectionCell.self, forCellWithReuseIdentifier: "Pokemon Cell")
        self.view.addSubview(self.pokemonCollectionview)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if user != nil {
//            return
//        }
        if(request != nil){
            DispatchQueue.global(qos: .default).async {
                request!.getPlayer()
                request!.makeRequest(intent: .getPlayer, delegate: self)
                DispatchQueue.main.async {
                    self.hud = HUDHelper.createHud(withView: self.view, title: "Loading Data...", detailText: nil, delegate: self)
                    self.hud.show(animated: true)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = self.pokemonCollectionview.dequeueReusableCell(withReuseIdentifier: "Pokemon Cell", for: indexPath) as! PokemonCollectionCell
//        cell.size = CGSize.init(width: self.view.frame.width/3, height: 100)
        cell.pokemonName.text = String(pokemonList[indexPath.row].pokemonIdInt)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return
    }
    
    func didReceiveApiResponse(_ intent: PGoApiIntent, response: PGoApiResponse){
        if intent == .getPlayer {
            user = User.init(withResponse: response)
            DispatchQueue.global(qos: .default).async {
                request!.getInventory()
                request!.makeRequest(intent: .getInventory, delegate: self)
                DispatchQueue.main.async {
            
                }
            }
        }else if intent == .getInventory{
            DispatchQueue.global(qos: .default).async {
                self.handleGetInventoryResponse(response: response)
                pokemonList.sort(by: { (first, second) -> Bool in
                    return first.creationTimeInMs < second.creationTimeInMs
                })
                DispatchQueue.main.async {
                    self.hud.label.text = "Done"
                    self.hud.hide(animated: true, afterDelay: 1)
                    self.pokemonCollectionview.reloadData()
                }
            }
        }
    }
    
    private func handleGetInventoryResponse(response: PGoApiResponse){
        if response.subresponses.count == 0 {
            return
        }
        if pokemonList.count > 0 {
            pokemonList.removeAll()
        }
        let inventory = response.subresponses[0] as! Pogoprotos.Networking.Responses.GetInventoryResponse
        if inventory.hasSuccess && inventory.success {
            if inventory.hasInventoryDelta && inventory.inventoryDelta.inventoryItems.count != 0{
                let inventoryList = inventory.inventoryDelta.inventoryItems
                for inventoryItem in inventoryList {
                    if inventoryItem.inventoryItemData.hasPokemonData {
                        let pokemonData = inventoryItem.inventoryItemData.pokemonData!
                        if pokemonData.hasIsEgg && pokemonData.isEgg {
                            continue
                        }
                        let pokemon = Pokemon(withPokemonData: pokemonData)
                        pokemonList.append(pokemon)
                    }
                    
                }
                
            }
        }
    }
    
    
    
    func didReceiveApiError(_ intent: PGoApiIntent, statusCode: Int?) {
        print("API Error: \(statusCode)")
        self.hud.label.text = "Error"
        self.hud.hide(animated: true, afterDelay: 3)
    }
    
    func didReceiveApiException(_ intent: PGoApiIntent, exception: PGoApiExceptions) {
        print("\(exception)")
        if intent == .getInventory && exception == .delayRequired {
            DispatchQueue.global(qos: .default).async {
                request!.getInventory()
                request!.makeRequest(intent: .getInventory, delegate: self)
                return
            }
        }
        self.hud.label.text = "Error"
        self.hud.hide(animated: true, afterDelay: 3)
    }

    
 }
