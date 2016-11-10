//
//  ViewSnapViewController.swift
//  Snapfire
//
//  Created by Thomas Bentkowski on 10/11/2016.
//  Copyright © 2016 Thomas Bentkowski. All rights reserved.
//

import UIKit

class ViewSnapViewController: UIViewController {

    /////////////////// OUTLETS ////////////////////
    @IBOutlet weak var snapImage: UIImageView!
    @IBOutlet weak var snapDescriptionLabel: UILabel!
    ///////////////// PROPERTIES ///////////////////
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        snapDescriptionLabel.text = snap.description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
