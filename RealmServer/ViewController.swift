//
//  ViewController.swift
//  RealmServer
//
//  Created by Ahmad Almasri on 1/28/18.
//  Copyright © 2018 Ahmad Almasri. All rights reserved.
//

import UIKit
import RealmSwift

extension Results {
    func toArray<T:RealmCollectionValue>(ofType: T.Type) -> List<T> {
        let array = List<T>()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}

class ViewController: UITableViewController {
   
    deinit {
        notificationToken.invalidate()
    }

    private let realmManager = RealmServerManager()
    private var notificationToken: NotificationToken!
    private var userList = List<UserModel>()

    override func viewDidLoad() {
        super.viewDidLoad()

         realmSetUp()
    
    }
  
    func realmSetUp() {
        
        realmManager.logIn () {
            if let realm = self.realmManager.realm() {
                let userList = realm.objects(UserModel.self)
                    self.userList = userList.toArray(ofType: UserModel.self)
                    self.tableView.reloadData()
                    self.notificationToken = realm.observe { _ ,realm in
                        
                       self.userList  = realm.objects(UserModel.self).toArray(ofType: UserModel.self)
                        
                        self.tableView.reloadData()
                    }
                
                    
                }
            }
        }
    
    override func tableView(_ tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = userList[indexPath.row]
        cell.textLabel?.text = task.text
        return cell
    }
    
    func add() {
        let alertController = UIAlertController(title: "New User", message: "Enter  Name", preferredStyle: .alert)
        var alertTextField: UITextField!
        alertController.addTextField { textField in
            alertTextField = textField
            textField.placeholder = "User Name"
        }
        alertController.addAction(UIAlertAction(title: "Add", style: .default) { _ in
            guard let text = alertTextField.text , !text.isEmpty else { return }
            if let realm = self.realmManager.realm(){
                try! realm.write {
                   let user =  UserModel()
                    user.text = text
                    user.id = NSUUID().uuidString
                    realm.add(user)
                    self.userList.append(user)
                    self.tableView.reloadData()
                }
            }
            
        })
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        add()
    }
    
}

