//
//  PokemonDetailController.swift
//  IvStats
//
//  Created by LaiQiang on 2017-02-13.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import UIKit
import Cartography

class PokemonDetailController: UITableViewController {

    var pokemon: Pokemon?
    var moveSet: [PokemonMove]?
    var pokemonPorototype: PokemonPrototype?
    var quickMoveSet: [PokemonMove]?
    var mainMoveSet: [PokemonMove]?
    var bestAttackMoveSet: [PokemonMove]?
    var bestDefenseMoveSet: [PokemonMove]?
    var candyNumber: Int32 = 0
    var maxCpAt40: Int = 0
    var evolve: [PokemonId] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // set page title
        self.navigationItem.title = pokemon?.getDisplayName()
        self.loadPokemonData()
    }

    private func loadPokemonData()
    {
        self.moveSet = pokemon?.getMoveSet()
        self.pokemonPorototype = PokemonHelper.getPokemonPrototype(withPokemonId: (self.pokemon!.pokemonId))
        self.quickMoveSet = self.pokemon?.getBaseQuickMoveSet()
        self.mainMoveSet = self.pokemon?.getBaseMainMoveSet()
        self.bestAttackMoveSet = self.pokemon?.getBestAttackMoveSet()
        self.bestDefenseMoveSet = self.pokemon?.getBestDefenseMoveSet()
        self.candyNumber = PokemonHelper.getCandy(forPokemonFamily: pokemonPorototype!.familyId)
        self.maxCpAt40 = pokemon!.getMaxCp()
        let firstEvolve = self.pokemonPorototype!.nextEvolve
        if firstEvolve.count != 0 {
            for i in 0...firstEvolve.count-1 {
                let nextEvolve = firstEvolve[i]
                evolve.append(nextEvolve)
            }
            for i in 0...firstEvolve.count-1 {
                let nextEvolve = firstEvolve[i]
                let proto = PokemonHelper.getPokemonPrototype(withPokemonId: nextEvolve)
                if proto!.nextEvolve.count != 0 {
                    for j in 0...proto!.nextEvolve.count-1 {
                        let secondEvolve = proto!.nextEvolve[j]
                        evolve.append(secondEvolve)
                    }
                }
                
            }
        }
        

    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {// basic infor
            return 1
        }
        else if section == 1
        {
            //moves
            if let set = self.moveSet
            {
                return set.count
            }
            else
            {
                return 0
            }
        }
        else if section == 2
        {
            if self.quickMoveSet == nil
            {
                return 0
            }
            else
            {
                return self.quickMoveSet!.count
            }
        }else if section == 3
        {
            if self.mainMoveSet == nil
            {
                return 0
            }
            else
            {
                return self.mainMoveSet!.count
            }
        }else if section == 4 {
            if self.evolve.count == 0 {
                return 1
            }else {
                return self.evolve.count
            }
        }else {
            return 1
        }
        
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 390
        }
        else if indexPath.section == 5
        {
            return 100
        }
        else if indexPath.section == 4 {
            return 60
        }
        else
        {
            return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 {
            return 40
        }
        else{
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {

        if section == 0
        {
            return nil
        }
        let headView = UIView()
        let headerName = UILabel()
        headView.addSubview(headerName)
        constrain(headerName)
        {
            (view) in
            view.left == view.superview!.left + 5
            view.centerY == view.superview!.centerY
            view.width == view.superview!.width
            view.height == 20
        }
        headView.backgroundColor = lightBgColor
        headerName.font = UIFont.init(name: primaryFontFamily, size: 16)
        if section == 1
        {
            var title: String = "Move Set"
            if self.pokemon!.isBestAttackMoveSet && self.pokemon!.isBestDefenseMoveSet
            {
                title.append(" -> Best Attack/Defense Move Set")
            }
            else if self.pokemon!.isBestAttackMoveSet {
                title.append(" -> Best Attack Move Set")
            }
            else if self.pokemon!.isBestDefenseMoveSet {
                title.append(" -> Best Defense Move Set")
            }
           headerName.text = title
            return headView
        }else if section == 2 {
            headerName.text = "Base Quick Move Set"
            return headView
        }else if section == 3{
            headerName.text = "Base Main Move Set"
            return headView
        }else if section == 4 {
            headerName.text = "CP After Evolve"
            return headView
        }
        else {
            headerName.text = "CP Calculator"
            return headView
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicInfo", for: indexPath) as! PokemonBasicInfoCell
            cell.pokemon = self.pokemon
            cell.setBestMoveIcons(isBestAttackMoveSet: self.pokemon!.isBestAttackMoveSet, isBestDefenseMoveSet: self.pokemon!.isBestDefenseMoveSet)
            cell.pokemonPrototype = self.pokemonPorototype
            cell.setPokemonCandy(withCandy: self.candyNumber)
            cell.setMaxCp(withMaxCp: self.maxCpAt40)
            cell.setCaptureDate(withCaptureDate: self.pokemon!.creationTime)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.isUserInteractionEnabled = false
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentMoveSet", for: indexPath) as! PokemonMoveSetCell
            cell.move = self.moveSet?[indexPath.row]
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.isUserInteractionEnabled = false
            return cell
        }
        else if indexPath.section == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentMoveSet", for: indexPath) as! PokemonMoveSetCell
            let move = self.quickMoveSet?[indexPath.row]
            cell.move = move
            cell.addIcon(isBestAttack: PokemonHelper.isBestAttackMove(withMove: move!, pokemon: self.pokemon!.pokemonId), isBestDefense: PokemonHelper.isBestDefenseMove(withMove: move!, pokemon: self.pokemon!.pokemonId))
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.isUserInteractionEnabled = false
            return cell
        }
        else if indexPath.section == 3
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentMoveSet", for: indexPath) as! PokemonMoveSetCell
            let move = self.mainMoveSet?[indexPath.row]
            cell.move = move
            cell.addIcon(isBestAttack: PokemonHelper.isBestAttackMove(withMove: move!, pokemon: self.pokemon!.pokemonId), isBestDefense: PokemonHelper.isBestDefenseMove(withMove: move!, pokemon: self.pokemon!.pokemonId))
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.isUserInteractionEnabled = false
            return cell
        }
        else if indexPath.section == 4{
            if self.evolve.count != 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "EvolveCell", for: indexPath) as! PokemonEvolveCell
                cell.pokemon = self.pokemon
                cell.evolveId = self.evolve[indexPath.row]
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.isUserInteractionEnabled = false
                return cell
            }else {
                let cell = UITableViewCell.init(style: .default, reuseIdentifier: "noEvolve")
                cell.textLabel?.text = "No Further Evolve"
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.isUserInteractionEnabled = false
                return cell
            }
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CpCalculator", for: indexPath) as! PokemonCpCalculatorCell
            cell.pokemon = self.pokemon
            cell.selectionStyle = UITableViewCellSelectionStyle.none
//            cell.isUserInteractionEnabled = false
            return cell

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
