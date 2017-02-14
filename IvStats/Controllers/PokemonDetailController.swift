//
//  PokemonDetailController.swift
//  IvStats
//
//  Created by LaiQiang on 2017-02-13.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import UIKit

class PokemonDetailController: UITableViewController {

    var pokemon: Pokemon?
    var moveSet: [PokemonMove]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // set page title
        self.navigationItem.title = pokemon?.getDisplayName()
        self.moveSet = pokemon?.getMoveSet()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
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
        else
        {
            return 0
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicInfo", for: indexPath) as! PokemonBasicInfoCell
            cell.pokemon = self.pokemon
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.isUserInteractionEnabled = false
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicInfo", for: indexPath) as! PokemonBasicInfoCell
            cell.pokemon = self.pokemon
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.isUserInteractionEnabled = false
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicInfo", for: indexPath) as! PokemonBasicInfoCell
            cell.pokemon = self.pokemon
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.isUserInteractionEnabled = false
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
