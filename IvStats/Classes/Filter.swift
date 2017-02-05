//
//  Filter.swift
//  IvStats
//
//  Created by LaiQiang on 2017-02-05.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import Foundation

enum FilterType: Int{
    case type = 0
    case favorite = 1
    case cp = 2
    case ip = 3
    case bestAttack = 4
    case bestDefense = 5
    case grass = 6
    case water = 7
    case fire = 8
    case bug = 9
    case ground = 10
    case normal = 11
    case flying = 12
    case fighting = 13
    case poison = 14
    case fairy = 15
    case rock = 16
    case electric = 17
    case psychic = 18
    case ghost = 19
    case ice = 20
    case steel = 21
    case dark = 22
    case dragon = 23
    
    func toString() -> String {
        switch self {
        case .type: return "Pokemon Type"
        case .favorite: return "Favorite"
        case .cp: return "Pokemon CP"
        case .ip: return "Pokemon IP"
        case .bestAttack: return "Best Attack"
        case .bestDefense: return "Best Defense"
        case .grass: return "Grass"
        case .water: return "water"
        case .fire: return "Fire"
        case .bug: return "Bug"
        case .ground: return "Ground"
        case .normal: return "Normal"
        case .flying: return "Flying"
        case .fighting: return "Fighting"
        case .poison: return "Poison"
        case .fairy: return "Fairy"
        case .rock: return "Rock"
        case .electric: return "Electric"
        case .psychic: return "Psychic"
        case .ghost: return "Ghost"
        case .ice: return "Ice"
        case .steel: return "Steel"
        case .dark: return "Dark"
        case .dragon: return "Dragon"
        }
    }
}

struct Filter {
    var filterType: FilterType
    var innerFilters: [Filter]?
    var isSelected: Bool = false
    
    mutating func setSelection(){
        if let filters = self.innerFilters {
            for filter in filters {
                if filter.isSelected {
                    isSelected = true
                    break
                }
            }
            isSelected = false
        }else {
            isSelected = !self.isSelected
        }
    }
}

