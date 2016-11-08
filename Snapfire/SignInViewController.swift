//
//  SignInViewController.swift
//  Snapfire
//
//  Created by Thomas Bentkowski on 08/11/2016.
//  Copyright © 2016 Thomas Bentkowski. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    /////////////////// OUTLETS ////////////////////
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var signinupButton: UIButton!
    ///////////////// PROPERTIES ///////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bringSubview(toFront: logoLabel)
        self.view.bringSubview(toFront: emailTextField)
        self.view.bringSubview(toFront: passwordTextField)
        self.view.bringSubview(toFront: signinupButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

