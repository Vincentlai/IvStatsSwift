//
//  PokemonHelper.swift
//  IvStats
//
//  Created by LaiQiang on 2017-02-06.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import Foundation

class PokemonHelper {
    
    class func doSortPokemon(sortType: SortType?, reverse: Bool?) {
        if sortType == nil || reverse == nil{
            return
        }
        switch sortType! {
        case .Cp:
            if !reverse! {
                pokemonList.sort(by: { (first, second) -> Bool in
                    return first.cp > second.cp
                })
            }else {
                pokemonList.sort(by: { (first, second) -> Bool in
                    return first.cp > second.cp
                })
            }
            break
        case .Favorite:
            if !reverse! {
                pokemonList.sort(by: { (first, second) -> Bool in
                    if first.isFavorite && !second.isFavorite {
                        return true
                    }else if !first.isFavorite && second.isFavorite {
                        return false
                    }else {
                        if first.getIv() > second.getIv() {
                            if first.cp > second.cp {
                                return true
                            }else {
                                return false
                            }
                        }else {
                            return false
                        }
                    }
                })
            }else {
                pokemonList.sort(by: { (first, second) -> Bool in
                    if first.isFavorite && !second.isFavorite {
                        return false
                    }else if !first.isFavorite && second.isFavorite {
                        return true
                    }else {
                        if first.getIv() > second.getIv() {
                            return true
                        }else {
                            return false
                        }
                    }
                })
            }
            break
        case .Iv:
            if !reverse! {
                pokemonList.sort(by: { (first, second) -> Bool in
                    return first.getIv() > second.getIv()
                })
            }else {
                pokemonList.sort(by: { (first, second) -> Bool in
                    return first.getIv() < second.getIv()
                })
            }
            break
        case .MaxCp:
            break
        case .Name:
            if !reverse! {
                pokemonList.sort(by: { (first, second) -> Bool in
                    return first.pokemonId.toString() < second.pokemonId.toString()
                })
            }else {
                pokemonList.sort(by: { (first, second) -> Bool in
                    return first.pokemonId.toString() > second.pokemonId.toString()
                })
            }
            break
        case .Recent:
            if !reverse! {
                pokemonList.sort(by: { (first, second) -> Bool in
                    return first.creationTimeInMs > second.creationTimeInMs
                })
            }else {
                pokemonList.sort(by: { (first, second) -> Bool in
                    return first.creationTimeInMs < second.creationTimeInMs
                })
            }
            break
        default :
            break
        }
    }
}
