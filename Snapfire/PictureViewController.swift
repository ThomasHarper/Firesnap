//
//  PictureViewController.swift
//  Snapfire
//
//  Created by Thomas Bentkowski on 09/11/2016.
//  Copyright © 2016 Thomas Bentkowski. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {

    /////////////////// OUTLETS ////////////////////
    @IBOutlet weak var snapImage: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    ///////////////// PROPERTIES ///////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cameraTapped(_ sender: Any) {
    }
    @IBAction func nextTapped(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
