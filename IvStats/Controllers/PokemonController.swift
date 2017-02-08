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

public protocol PokemonControllerDelegate {
    func sortPokemon(fromController: UIViewController, sortType: SortType?)
    func fitlerPokemon()
}


class PokemonController: UIViewController
        , MBProgressHUDDelegate
        , UICollectionViewDelegate
        , UICollectionViewDataSource
        , UISearchBarDelegate
        , PokemonControllerDelegate
{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var changeViewButton: UIBarButtonItem!
    
    private var hud: MBProgressHUD!
    private var pokemonCollectionview: UICollectionView!
    var viewType: ViewType?
    private var isLoaded: Bool = false
    private var sortType: SortType! {
        didSet {
            PokemonHelper.doSortPokemon(sortType: self.sortType, reverse: false)
        }
    }
    public let MenuItems: [MenuItemType] = [MenuItemType.Sort, MenuItemType.Filter, MenuItemType.Swap]
    public var dropdownMenu: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewType = .Grid
        self.setCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !(self.isLoaded) {
            self.doFetchPokemons()
            self.isLoaded = !(self.isLoaded)
        }
    }
    
    private func changeViewType() {
        var flowLayout = self.pokemonCollectionview.collectionViewLayout
        flowLayout = self.getCollectionViewLayout(flowlayout: flowLayout as! UICollectionViewFlowLayout)
        self.pokemonCollectionview.collectionViewLayout = flowLayout
        self.setCellInset()
        self.pokemonCollectionview.reloadData()
        self.scrollToTop()
    }
    
    private func scrollToTop() {
        self.pokemonCollectionview.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    private func getCollectionViewLayout(flowlayout: UICollectionViewFlowLayout) -> UICollectionViewFlowLayout{
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
        return flowlayout
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setCollectionView() {
        let rect = CGRect.init(x: self.view.frame.origin.x , y: self.searchBar.frame.origin.y + self.searchBar.frame.height, width: self.view.frame.width, height: (self.tabBarController?.tabBar.frame.origin.y)! - (self.searchBar.frame.origin.y + self.searchBar.frame.height))
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout = self.getCollectionViewLayout(flowlayout: flowLayout)
        self.pokemonCollectionview = UICollectionView.init(frame: rect, collectionViewLayout: flowLayout)
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
                    pokemonList.filter({ (Pokemon) -> Bool in
                        return true
                    })
                    if self.sortType == nil {
                        self.sortType = SortManager.sortManager.selectedSortType!
                    }else {
                        PokemonHelper.doSortPokemon(sortType: self.sortType, reverse: false)
                    }
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
        let identifier: String
        if self.viewType! == .Grid {
            identifier = "grid cell"
        }else {
            identifier = "list cell"
        }
        let cell = self.pokemonCollectionview.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if let pokemonCell = cell as? PokemonCollectionCell {
            pokemonCell.viewType = self.viewType
            pokemonCell.pokemon = pokemonList[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return
    }
    
    @IBAction func changeView(_ sender: UIBarButtonItem) {
        if self.viewType! == ViewType.List {
            changeViewButton.image = #imageLiteral(resourceName: "ic_view_module_white")
            self.viewType = .Grid
            self.changeViewType()
        }else {
            changeViewButton.image = #imageLiteral(resourceName: "ic_view_list_white")
            self.viewType = .List
            self.changeViewType()
        }
    }
    
    
    
    @IBAction func refreshPokemon(_ sender: UIBarButtonItem) {
        self.doFetchPokemons()
    }
    
    func sortPokemon(fromController: UIViewController, sortType: SortType?) {
        _ = fromController.navigationController?.popViewController(animated: true)
        if sortType != nil {
            if self.sortType == sortType {
                return
            }
            self.sortType = sortType
            self.pokemonCollectionview.reloadData()
        }
    }
    
    func fitlerPokemon() {

    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Sort" {
            if let destination = segue.destination as? SortController {
                destination.delegate = self
            }
        }
    }
}

extension PokemonController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.popover.dismiss()
    }
    
}

extension PokemonController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dropdownMenu!.dequeueReusableCell(withIdentifier: "Dropdown", for: indexPath)
        if let dropdownMenuCell = cell as? DropdownMenu {
            dropdownMenuCell.menuItem = MenuItems[indexPath.row]
        }
        return cell

    }
    
}



