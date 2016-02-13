//
//  HzManager.swift
//  houzie
//
//  Created by syahRiza on 2/13/16.
//  Copyright © 2016 roomtech. All rights reserved.
//

import Foundation

class Manager {
    static let sharedManager = Manager()
    private let accessToken = "MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjJjaWQgdXNlcl9pZCA9IEByaXphOmxvY2FsaG9zdAowMDE2Y2lkIHR5cGUgPSBhY2Nlc3MKMDAxZGNpZCB0aW1lIDwgMTQ1NDc3NjA2OTczNAowMDJmc2lnbmF0dXJlIF5TWbxwDikyXTyIqAQsG2wyvEXOZVQPEPOODKe11MoBCg"
    private let userID = "@riza:localhost"
    private let homeserver = "http://www.roomtech.io:8008"
    let mxClient : MXRestClient
    let roomID = "!AtetEyzubXwpWQmvCX:localhost"
    private init(){
        let credentials = MXCredentials(homeServer: homeserver, userId: "@riza:localhost", accessToken: accessToken)
        self.mxClient = MXRestClient(credentials: credentials) { (datas) -> Bool in
            return true
        }
    }
    
}
