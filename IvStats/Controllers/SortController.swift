//
//  SortController.swift
//  IvStats
//
//  Created by LaiQiang on 2017-02-05.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import UIKit

class SortController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var sortList: [Sort]?
    var indexOfSelectedSortType: Int?
    var isReversed: Bool = false
    public var delegate: PokemonControllerDelegate?
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var reverseSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doGetSortList()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "SortViewCell", bundle: nil), forCellReuseIdentifier: "Sort Cell")
    }
    
    private func doGetSortList() {
        sortList = SortManager.sortManager.sortList
        self.indexOfSelectedSortType = SortManager.sortManager.indexOfSelectedSortType
        self.isReversed = SortManager.sortManager.isReversed
        reverseSwitch.isOn = self.isReversed
    }
    
    @IBAction func ReverseList(_ sender: UISwitch) {
        self.isReversed = sender.isOn
    }
    

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortList!.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sort"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Sort Cell", for: indexPath) as! SortViewCell
        cell.sort = sortList?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if self.indexOfSelectedSortType! != indexPath.row {
            let lastSelectedSortTypeCell = tableView.cellForRow(at: IndexPath.init(row: self.indexOfSelectedSortType!, section: 0)) as! SortViewCell
            self.sortList![self.indexOfSelectedSortType!].enable = false
            lastSelectedSortTypeCell.sort!.enable = false
            let cell = tableView.cellForRow(at: indexPath) as! SortViewCell
            self.sortList![indexPath.row].enable = !(self.sortList![indexPath.row].enable)
            cell.sort!.enable = !(cell.sort!.enable)
        }

        self.indexOfSelectedSortType! = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func doSave(_ sender: UIBarButtonItem) {
        SortManager.sortManager.saveSort(list: self.sortList!, reversed: self.isReversed)
        let sortType = self.sortList![self.indexOfSelectedSortType!].sortType
        self.delegate!.sortPokemon(fromController: self, sortType: sortType, reversed: self.isReversed)
        
    }
    
}
