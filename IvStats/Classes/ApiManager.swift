//
//  ApiManager.swift
//  IvStats
//
//  Created by LaiQiang on 2017-01-29.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import Foundation
import PGoApi
import RNCryptor

enum AuthType: Int {
    case PTC
    case Google
}

class ApiManager {
    
    static let UsernameKey = "username"
    static let PassworkKey = "password"
    static let TokenKey = "token"
    static let AuthTypeKey = "auth"
    static let defaultManager = ApiManager()
    
    var auth: PGoAuth?
    var isLoggedIn = false
    
    typealias LoginHandler = (NSError?)->()
    var loginHandler: LoginHandler?
    
    typealias FetchPlayerInfoHandler = (Player?, NSError?)->()
    var fetchPlayerInfoHandler: FetchPlayerInfoHandler?
    
    typealias FetchDataHandler = ([Pokemon]?, NSError?)->()
    var fetchDataHandler: FetchDataHandler?
    
    private var username: String?
    private var password: String?
    private var token: String?
    private var authType: AuthType?
    
    // MARK: - Main functions
    init() {
        let userDefault = UserDefaults.standard
        if (userDefault.string(forKey: ApiManager.UsernameKey) != nil && userDefault.data(forKey: ApiManager.PassworkKey) != nil) || (userDefault.data(forKey: ApiManager.TokenKey) != nil)
        {
            self.isLoggedIn = true;
        }
    }
    
    // MARK: - Login
    
    func login(withUsername username: String, password: String, handler: LoginHandler?) {
        self.loginHandler = handler
        self.username = username
        self.password = password
        self.authType = AuthType.PTC
        
        self.auth = PtcOAuth()
        self.auth?.delegate = self
        self.auth?.login(withUsername: username, withPassword: password)
        
    }
    
    
    func login(withToken token: String, handler: LoginHandler?) {
        self.loginHandler = handler
        self.token = token
        self.authType = AuthType.Google
        
        self.auth = GPSOAuth()
        self.auth?.delegate = self
        
        if self.isLoggedIn {
            self.auth?.loginWithRefreshToken(withRefreshToken: token)
        }else{
            self.auth?.login(withToken: token)
        }
    }
    
    func autoLogin(handler: @escaping LoginHandler){
        
        let userDefault = UserDefaults.standard
        if let authType = AuthType(rawValue: userDefault.integer(forKey: ApiManager.AuthTypeKey)){
            if authType == .PTC {
                if let username = userDefault.string(forKey: ApiManager.UsernameKey)
                , let encryptData = userDefault.data(forKey: ApiManager.PassworkKey)
                , let passwordData = try? RNCryptor.decrypt(data: encryptData, withPassword: username + "ivstats")
                , let password = String.init(data: passwordData, encoding: String.Encoding.utf8)
                {
                    self.login(withUsername: username, password: password, handler: handler)
                }
            } else {
                if let encryptData = userDefault.data(forKey: ApiManager.TokenKey)
                    , let tokenData = try? RNCryptor.decrypt(data: encryptData, withPassword: "ivstats")
                    , let token = String.init(data: tokenData, encoding: String.Encoding.utf8)
                {
                    self.login(withToken: token, handler: handler)
                }
            }
        }

    }
    
    func logout() {
        let userDefault = UserDefaults.standard
        if authType == AuthType.PTC {
            userDefault.removeObject(forKey: ApiManager.UsernameKey)
            userDefault.removeObject(forKey: ApiManager.PassworkKey)
        }else
        {
            userDefault.removeObject(forKey: ApiManager.TokenKey)
        }
        userDefault.removeObject(forKey: ApiManager.AuthTypeKey)
        
        self.isLoggedIn = false
        self.auth = nil
    }
    
    func saveLoginInfo(refreshToken: String?) {
        let userDefault = UserDefaults.standard
        if authType == AuthType.PTC {
            if let username = self.username,
            let password = self.password,
            let authType = self.authType,
            let data = password.data(using: String.Encoding.utf8)
            {
                let key = username + "ivstats"
                let encryptData = RNCryptor.encrypt(data: data, withPassword: key)
                userDefault.set(username, forKey: ApiManager.UsernameKey)
                userDefault.set(encryptData, forKey: ApiManager.PassworkKey)
                userDefault.set(authType.rawValue, forKey: ApiManager.AuthTypeKey)
                userDefault.synchronize()
            }
        }
        else{
            if let token = refreshToken,
                let authType = self.authType,
                let data = token.data(using: String.Encoding.utf8)
            {
                let key = "ivstats"
                let encryptData = RNCryptor.encrypt(data: data, withPassword: key)
                userDefault.set(encryptData, forKey: ApiManager.TokenKey)
                userDefault.set(authType.rawValue, forKey: ApiManager.AuthTypeKey)
                userDefault.synchronize()
            }

        }
    
    }
    
    // MARK: - Get Player Info
    func fetchPlayerInfo(handler: FetchPlayerInfoHandler?){
        
        let fetch = {
            if let auth = self.auth {
                self.fetchPlayerInfoHandler = handler
                let request = PGoApiRequest(auth: auth)
                request.getPlayer()
                request.makeRequest(intent: .getPlayer, delegate: self)
            }
        }
        
        if let _ = self.auth {
            fetch()
        } else if self.isLoggedIn {
            self.autoLogin() {
                (error) in
                
                if error != nil {
                    handler?(nil, Error.Code.Authorization.nserror())
                }
                else{
                    fetch()
                }
            }
            
        } else {
            handler?(nil, Error.Code.Authorization.nserror())
        }
        
    }
    
    // MARK: - Fetch Pokemons
    func fetchPokemons(handler: FetchDataHandler?){
        
        let fetch = {
            if let auth = self.auth {
                self.fetchDataHandler = handler
                let request = PGoApiRequest(auth: auth)
                request.getInventory()
                request.makeRequest(intent: .getInventory, delegate: self)
            }
        }
        
        if let _ = self.auth {
            fetch()
        }
        else if self.isLoggedIn {
            self.autoLogin() {
                (error) in
                
                if error != nil {
                    handler?(nil, Error.Code.Authorization.nserror())
                }
                else{
                    fetch()
                }
            }
        } else {
            handler?(nil, Error.Code.Authorization.nserror())
        }
   
    }
}

extension ApiManager: PGoAuthDelegate {
    func didReceiveAuth() {
        if let auth = self.auth {
            let request = PGoApiRequest(auth: auth)
            request.getPlayer()
            request.makeRequest(intent: .login, delegate: self)
        }
    }
    
    func didNotReceiveAuth() {
        self.loginHandler?(Error.Code.Login.nserror())
        self.loginHandler = nil
        self.isLoggedIn = false
    }
}

extension ApiManager: PGoApiDelegate {
    
    func didReceiveApiResponse(_ intent: PGoApiIntent, response: PGoApiResponse) {
        
        if intent == .login {
            if let envelop = response.response as? Pogoprotos.Networking.Envelopes.ResponseEnvelope {
                self.auth?.endpoint = "https://" + envelop.apiUrl + "/rpc"
                self.saveLoginInfo(refreshToken: self.auth?.getRefreshToken())
                self.loginHandler?(nil)
                self.loginHandler = nil
            } else {
                self.loginHandler?(Error.Code.Authorization.nserror())
                self.loginHandler = nil
            }

        } else if intent == .getPlayer {
            
            let playerInfo = response.subresponses.first as! Pogoprotos.Networking.Responses.GetPlayerResponse
            if playerInfo.hasSuccess && playerInfo.success && playerInfo.hasPlayerData {
                let player = Player.init(withPlayerData: playerInfo.playerData)
                self.fetchPlayerInfoHandler?(player, nil)
                self.fetchPlayerInfoHandler = nil
            }
            else {
                self.fetchPlayerInfoHandler?(nil, Error.Code.ResovePlayerData.nserror())
                self.fetchPlayerInfoHandler = nil
            }
        } else if intent == .getInventory {
            if response.subresponses.count > 0
            {
                var pokemonList = Array<Pokemon>()

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
                    
                    self.fetchDataHandler?(pokemonList, nil)
                    self.fetchDataHandler = nil
                    
                }else {
                    self.fetchDataHandler?(nil, Error.Code.ResoceInventoryData.nserror())
                    self.fetchDataHandler = nil
                }

            }else {
                self.fetchDataHandler?(nil, Error.Code.ResoceInventoryData.nserror())
                self.fetchDataHandler = nil
            }
            
        }
    }
    
    func didReceiveApiError(_ intent: PGoApiIntent, statusCode: Int?) {
        
        if intent == .login {
            self.loginHandler?(Error.Code.Connection.nserror())
            self.loginHandler = nil
        } else if intent == .getPlayer {
            self.fetchPlayerInfoHandler?(nil, Error.Code.Connection.nserror())
            self.fetchPlayerInfoHandler = nil
        } else {
            self.fetchDataHandler?(nil, Error.Code.Connection.nserror())
            self.fetchDataHandler = nil
        }
    }
    
    func didReceiveApiException(_ intent: PGoApiIntent, exception: PGoApiExceptions) {
        print("\(exception)")
    }
}
