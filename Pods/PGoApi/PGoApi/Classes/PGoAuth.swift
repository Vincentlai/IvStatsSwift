//
//  Auth.swift
//  Pokemon GO Map
//
//  Created by Luke Sapan on 7/20/16.
//  Copyright © 2016 Coadstal. All rights reserved.
//

import Foundation
import Alamofire


public protocol PGoAuth {
    var password: String! { get set }
    var accessToken: String? { get set }
    var expires: Int? { get set }
    var loggedIn: Bool { get }
    var expired: Bool { get set }
    var delegate: PGoAuthDelegate? { get set }
    var authType: PGoAuthType { get }
    var endpoint: String { get set }
    var authToken: Pogoprotos.Networking.Envelopes.AuthTicket? { get set }
    var manager: SessionManager { get set }
    var banned: Bool { get set }
    
    func getRefreshToken() -> String?
    
    func login(withUsername username:String, withPassword password:String)
    func login(withToken token:String)
    func loginWithRefreshToken(withRefreshToken token:String?)
}
