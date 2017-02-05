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

var player: Player?
var pokemonList = Array<Pokemon>()
var candyList = Array<Candy>()

enum ViewType {
    case Grid
    case List
}

class PokemonController: UIViewController
        , MBProgressHUDDelegate
        , UICollectionViewDelegate
        , UICollectionViewDataSource
        , UISearchBarDelegate
{

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    @IBOutlet weak var filterButton: UIBarButtonItem!
    private var hud: MBProgressHUD!
    private var pokemonCollectionview: UICollectionView!

    var list = Pogoprotos.Networking.Responses.GetPlayerResponse()
    
    var viewType: ViewType?{
        didSet {
            self.changeViewType()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewType = .List
        self.setCollectionView()
        
    }
    
    private func changeViewType() {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    private func setCollectionView() {
        let rect = CGRect.init(x: self.view.frame.origin.x , y: self.searchBar.frame.origin.y + self.searchBar.frame.height, width: self.view.frame.width, height: (self.tabBarController?.tabBar.frame.origin.y)! - (self.searchBar.frame.origin.y + self.searchBar.frame.height))
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = UICollectionViewScrollDirection.vertical
        if self.viewType! == .Grid {
            flowlayout.minimumInteritemSpacing = 5
            flowlayout.minimumLineSpacing = 5
            let width = Helper.getPokemonCellWidth()
            flowlayout.itemSize = CGSize.init(width: width, height: 130 )
        }else {
            flowlayout.minimumInteritemSpacing = 0
            flowlayout.minimumLineSpacing = 2
            let width = UIScreen.main.bounds.width
            flowlayout.itemSize = CGSize.init(width: width, height: 80  )
        }
        
        self.pokemonCollectionview = UICollectionView.init(frame: rect, collectionViewLayout: flowlayout)
        self.pokemonCollectionview.delegate = self
        self.pokemonCollectionview.dataSource = self
        self.pokemonCollectionview.showsVerticalScrollIndicator = true
        self.pokemonCollectionview.backgroundColor = UIColor.clear
        self.pokemonCollectionview.register(UINib.init(nibName: "PokemonGridCell", bundle: nil), forCellWithReuseIdentifier: "grid cell")
        self.pokemonCollectionview.register(UINib.init(nibName: "PokemonListCell", bundle: nil), forCellWithReuseIdentifier: "list cell")
        self.setCellInset()
        self.view.addSubview(self.pokemonCollectionview)
    }
    
    private func setCellInset() {
        if self.viewType! == .Grid {
            self.pokemonCollectionview.contentInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        }else {
            self.pokemonCollectionview.contentInset = UIEdgeInsets.init(top: 5, left: 0, bottom: 5, right: 0)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.doFetchPokemons()
    }
        private func doFetchPokemons() {
        self.hud = HUDHelper.createHud(withView: self.view, title: "Loading Data...", detailText: nil, delegate: self)
        self.hud.show(animated: true)
        ApiManager.defaultManager.fetchPokemons {
            (pokemons, error) in
            let backgroundQueue = DispatchQueue(label: "backgroundQueue", qos: DispatchQoS.background)
            backgroundQueue.async {
                if let error = error {
                    print("\(error.debugDescription)")
                }
                else{
                    pokemonList = pokemons!
                    pokemonList.sort(by: { (first, second) -> Bool in
                        return first.creationTimeInMs < second.creationTimeInMs
                    })
                    DispatchQueue.main.async {
                        self.hud.label.text = "Done"
                        self.hud.hide(animated: true, afterDelay: 0.3)
                        self.pokemonCollectionview.reloadData()
                    }
                    
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = self.pokemonCollectionview.dequeueReusableCell(withReuseIdentifier: "list cell", for: indexPath)
        if let pokemonCell = cell as? PokemonCollectionCell {
            pokemonCell.pokemon = pokemonList[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return
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
    
 }
