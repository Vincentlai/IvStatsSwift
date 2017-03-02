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

enum SettingItemType {
    case About
    case Support
    case Logout
    
    func toString() -> String{
        switch self {
        case .About: return "About"
        case .Support: return "Support"
        default: return "Logout"
        }
    }
}

class DropdownMenuItem: UITableViewCell {

    var menuIcon: UIImageView!
    var menuLabel: UILabel!
    
    var menuItem: MenuItemType? {
        didSet{
            self.updateUI()
        }
    }
    
    var settingMenuItem: SettingItemType? {
        didSet{
            self.updateSettingUi()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.menuIcon = UIImageView.init(frame: CGRect.init(x: 8, y: 8, width: 24, height: 24))
        self.menuLabel = UILabel.init(frame: CGRect.init(x: 40, y: 0, width: 110, height: 40))
        self.contentView.addSubview(menuIcon)
        self.contentView.addSubview(menuLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func updateSettingUi()
    {
        switch settingMenuItem! {
        case .About:
            menuIcon.image = #imageLiteral(resourceName: "about")
            menuLabel.text = settingMenuItem?.toString()
            break
        case .Support:
            menuIcon.image = #imageLiteral(resourceName: "support")
            menuLabel.text = settingMenuItem?.toString()
        default:
            menuIcon.image = #imageLiteral(resourceName: "logout")
            menuLabel.text = settingMenuItem?.toString()
        }
        menuIcon.image = menuIcon.image!.withRenderingMode(.alwaysTemplate)
        menuIcon.tintColor = UIColor.black
    }
    
    private func updateUI() {
        
        switch menuItem! {
            
        case MenuItemType.Sort:
            menuIcon.image = #imageLiteral(resourceName: "ic_sort_white")
            menuLabel.text = menuItem?.toString()
            break
        case MenuItemType.Filter:
            menuIcon.image = #imageLiteral(resourceName: "ic_filter_list_white")
            menuLabel.text = menuItem?.toString()
            break
        default:
            menuIcon.image = #imageLiteral(resourceName: "ic_swap_vert_white")
            menuLabel.text = menuItem?.toString()
        }
        menuIcon.image = menuIcon.image!.withRenderingMode(.alwaysTemplate)
        menuIcon.tintColor = UIColor.black
    }
}
