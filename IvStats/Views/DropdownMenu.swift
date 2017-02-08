//
//  DropdownMenu.swift
//  IvStats
//
//  Created by LaiQiang on 2017-02-07.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import UIKit

enum MenuItemType {
    case Sort
    case Filter
    case Swap
    
    func toString() -> String{
        switch self {
        case .Sort: return "Sort"
        case .Filter: return "Filter"
        default: return "Reverse List"
        }
    }
}

class DropdownMenu: UITableViewCell {

    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var menuLable: UILabel!
    
    var menuItem: MenuItemType? {
        didSet{
            self.updateUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        menuLable.textColor = UIColor.white
    }
    
    private func updateUI() {
        
        switch menuItem! {
            
        case MenuItemType.Sort:
            menuIcon.image = #imageLiteral(resourceName: "ic_sort_white")
            menuLable.text = menuItem?.toString()
            break
        case MenuItemType.Filter:
            menuIcon.image = #imageLiteral(resourceName: "ic_filter_list_white")
            menuLable.text = menuItem?.toString()
            break
        default:
            menuIcon.image = #imageLiteral(resourceName: "ic_swap_vert_white")
            menuLable.text = menuItem?.toString()
        }
    }
  
}
