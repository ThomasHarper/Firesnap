//
//  SelectUserViewController.swift
//  Snapfire
//
//  Created by Thomas Bentkowski on 09/11/2016.
//  Copyright © 2016 Thomas Bentkowski. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SelectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /////////////////// OUTLETS ////////////////////
    @IBOutlet weak var tableView: UITableView!
    ///////////////// PROPERTIES ///////////////////
    var users : [User] = []
    var snapImageURL = ""
    var snapDescription = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            let user = User()
            let snapshotDictionnary = snapshot.value as? NSDictionary
            user.email = snapshotDictionnary!["email"] as? String
            user.uid = snapshot.key
            
            self.users.append(user)
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let snap = ["email":user.email, "description":snapDescription, "imageURL":snapImageURL]
        
        FIRDatabase.database().reference().child("users").child(user.uid!).child("snaps").childByAutoId().setValue(snap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
