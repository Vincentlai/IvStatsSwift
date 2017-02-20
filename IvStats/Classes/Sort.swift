//
//  Sort.swift
//  IvStats
//
//  Created by LaiQiang on 2017-02-05.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import Foundation

public enum SortType: CustomStringConvertible {

    case Cp
    case Iv
    case Name
    case Recent
    case Favorite
    case MaxCp
    case Number
    case None
    
    func toString() -> String {
        switch self {
        case .Cp: return "By Cp"
        case .Iv: return "By Iv"
        case .Name: return "By Name"
        case .Recent: return "By Recent"
        case .Favorite: return "By Favorite"
        case .MaxCp: return "By MaxCp"
        case .Number: return "By Number"
        case .None: return "By None"
        }
    }
    
    public var description: String {
        return toString()
    }
    
    public static func fromString(sortName: String) -> SortType {
        switch sortName {
            case "By Cp": return SortType.Cp
            case "By Iv": return SortType.Iv
            case "By Name": return SortType.Name
            case "By Recent": return SortType.Recent
            case "By Favorite": return SortType.Favorite
            case "By MaxCp": return SortType.MaxCp
            case "By Number": return SortType.MaxCp
        default:  return SortType.Recent
        }
    }
}

struct Sort{
    var sortType: SortType
    var enable: Bool
    
    func toString() -> String {
        return self.sortType.toString()
    }
}

class SortManager {
    static let sortNameList = [SortType.Recent, SortType.Cp, SortType.Iv, SortType.Name, SortType.Number, SortType.Favorite, SortType.MaxCp]
    var sortList = [Sort]()
    var isReversed: Bool = false
    var indexOfSelectedSortType: Int = 0 {
        didSet {
            self.selectedSortType = sortList[self.indexOfSelectedSortType].sortType
        }
    }
    var selectedSortType: SortType!
    static let sortManager = SortManager()
    static let sortKey = "Sort By"
    static let reverseKey = "Sort Reversed"
    
    init() {
        let userDefault = UserDefaults.standard
        if let sort = userDefault.string(forKey: SortManager.sortKey)
        {
            let sortType: SortType = SortType.fromString(sortName: sort)
            var index = 0
            for sortName in SortManager.sortNameList {
                if sortType == sortName {
                    sortList.append(Sort(sortType: sortName, enable: true))
                    self.indexOfSelectedSortType = index
                    self.selectedSortType = sortType
                }else {
                    sortList.append(Sort(sortType: sortName, enable: false))
                }
                index += 1
            }
        }else {
            for sortName in SortManager.sortNameList {
                sortList.append(Sort(sortType: sortName, enable: false))
            }
        }
        if self.selectedSortType == nil {
            self.selectedSortType = SortType.Recent
            sortList[0].enable = true
        }
        let reverse = userDefault.bool(forKey: SortManager.reverseKey)
        if reverse {
            self.isReversed = true
        }

    }
    
    public func save(withType type: SortType, reversed: Bool)
    {
        let userDefault = UserDefaults.standard
        self.isReversed = reversed
        userDefault.set(self.isReversed, forKey: SortManager.reverseKey)
        self.selectedSortType = type
        for i in 0...self.sortList.count-1
        {
            if sortList[i].sortType == type
            {
                sortList[i].enable = true
                self.indexOfSelectedSortType = i
            }else {
                sortList[i].enable = false
            }
        }
        userDefault.set(type.toString(), forKey: SortManager.sortKey)
        userDefault.synchronize()
    }
    
    public func saveSort(list: [Sort], reversed: Bool) {
        let userDefault = UserDefaults.standard
        self.isReversed = reversed
        userDefault.set(self.isReversed, forKey: SortManager.reverseKey)
        self.sortList = list
        var index = 0
        for sort in list {
            if sort.enable {
                userDefault.set(sort.toString(), forKey: SortManager.sortKey)
                self.indexOfSelectedSortType = index
                userDefault.synchronize()
                return
            }
            index += 1
        }
    }
    
}
