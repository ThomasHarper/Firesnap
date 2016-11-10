//
//  ViewSnapViewController.swift
//  Snapfire
//
//  Created by Thomas Bentkowski on 10/11/2016.
//  Copyright © 2016 Thomas Bentkowski. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ViewSnapViewController: UIViewController {

    /////////////////// OUTLETS ////////////////////
    @IBOutlet weak var snapImage: UIImageView!
    @IBOutlet weak var snapDescriptionLabel: UILabel!
    ///////////////// PROPERTIES ///////////////////
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Showing the snap
        snapDescriptionLabel.text = snap.description
        snapImage.sd_setImage(with: URL(string: snap.imageURL))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Removing the current snap from Firebase database
        // when the user goes back to previous view controller
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").child(snap.key).removeValue()
        
        // Removing the current image snap from Firebase storage
        // when the user goes back to previous view controller
        FIRStorage.storage().reference().child("images").child("\(snap.uuid).jpg").delete { (error) in
            print("We deleted the image from Firebase storage")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
