//
//  RealmServerManager.swift
//  RealmServer
//
//  Created by Ahmad Almasri on 2/5/18.
//  Copyright © 2018 Ahmad Almasri. All rights reserved.
//

import Foundation
import RealmSwift

class RealmServerManager {

    private let username = "realm-admin"
    private let password = ""
    
    private let authServerURL = URL(string: "http://127.0.0.1:9080")!
    private let syncServerURL = URL(string: "realm://127.0.0.1:9080/~/MYDB")!
    
    private var user: SyncUser?

    func logIn(completion: (()->Void)? = nil) {
        guard user == nil else {
            completion?()
            return
        }
        
        let credentials = SyncCredentials.usernamePassword(username: username, password: password)
        SyncUser.logIn(with: credentials, server: authServerURL, timeout: 30) {
            user, error in
            if let user = user {
                self.user = user
                DispatchQueue.main.async {
                    completion?()
                }
                
            } else if let user = SyncUser.current {
                self.user = user
                DispatchQueue.main.async {
                    completion?()
                }
            } else if let error = error {
                fatalError("Could not log in: \(error)")
            }
        }
    }
    
    func realm() -> Realm? {
        if let user = user {
            let syncConfig = SyncConfiguration(user: user, realmURL: syncServerURL)
            let config = Realm.Configuration(syncConfiguration: syncConfig)
            guard let realm = try? Realm(configuration: config) else {
                fatalError("Could not load Realm")
            }
            return realm
        } else {
            return nil
        }
    }
}
