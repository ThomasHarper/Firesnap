//
//  SnapsViewController.swift
//  Snapfire
//
//  Created by Thomas Bentkowski on 08/11/2016.
//  Copyright © 2016 Thomas Bentkowski. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    /////////////////// OUTLETS ////////////////////
    @IBOutlet weak var tableView: UITableView!
    ///////////////// PROPERTIES ///////////////////
    var snaps : [Snap] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Pulling the data from Firebase Database in order to display the list of snaps that the user received
        FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser!.uid)!).child("snaps").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            let snap = Snap()
            let snapshotDictionnary = snapshot.value as? NSDictionary
            snap.imageURL = (snapshotDictionnary!["imageURL"] as? String)!
            snap.from = (snapshotDictionnary!["from"] as? String)!
            snap.description = (snapshotDictionnary!["description"] as? String)!
            snap.key = snapshot.key
            snap.uuid = (snapshotDictionnary!["uuid"] as? String)!
            
            self.snaps.append(snap)
            self.tableView.reloadData()
            })
        
        // Reloading the tableView when the user deletes a snap
        FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser!.uid)!).child("snaps").observe(FIRDataEventType.childRemoved, with: {(snapshot) in
            var index = 0
            for snap in self.snaps {
                if snap.key == snapshot.key {
                    self.snaps.remove(at: index)
                }
                index += 1
            }
            
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let snap = snaps[indexPath.row]
        cell.textLabel?.text = snap.from
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        // Let's go to the snap that the user selected
        performSegue(withIdentifier: "showsnap", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Sending the snap to the next view controller (ViewSnapViewController)
        if segue.identifier == "showsnap" {
            let nextVC = segue.destination as! ViewSnapViewController
            nextVC.snap = sender as! Snap
        }
    }

    @IBAction func logoutTapped(_ sender: AnyObject) {
        // When the user taps on logout we dismiss the current view controller 
        // and he goes back to signin
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
