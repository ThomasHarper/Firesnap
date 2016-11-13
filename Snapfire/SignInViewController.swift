//
//  SignInViewController.swift
//  Snapfire
//
//  Created by Thomas Bentkowski on 08/11/2016.
//  Copyright © 2016 Thomas Bentkowski. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController, UITextFieldDelegate {

    /////////////////// OUTLETS ////////////////////
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var signinupButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    ///////////////// PROPERTIES ///////////////////
    var errors = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Managing z-index of the image and its blur effect
        self.view.bringSubview(toFront: logoLabel)
        self.view.bringSubview(toFront: emailTextField)
        self.view.bringSubview(toFront: passwordTextField)
        self.view.bringSubview(toFront: signinupButton)
        self.view.bringSubview(toFront: errorMessage)
        
        // Setting the delegate of UITextFieldDelegate in order to tap on "Done" (keyboard)
        passwordTextField.delegate = self
        
        // We hide the error label as long as we've got no errors to display
        // and setting the textfield number of lines to two
        errorMessage.isHidden = true
        errorMessage.numberOfLines = 2
    }
    
    // When tapped, we want the user to be signed in or signed up and then signed in
    @IBAction func signinupTapped(_ sender: AnyObject) {
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("We tried to sign in")
            if error != nil {
                self.errorMessage.text = error!.localizedDescription
                self.errorMessage.isHidden = false
                
                // Create the user if it doesn't exist
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create an user")
                    if  error != nil {
                        // Code 17999 corresponds to a field not filled (e.g password field)
                        // This isn't neat but we have to because of the auto account creation
                        if error!._code == 17999 {
                            self.errorMessage.text = "Please fill both texfields"
                            self.errorMessage.isHidden = false
                        } else {
                            print(error!._code)
                            self.errorMessage.text = error!.localizedDescription
                            self.errorMessage.isHidden = false
                        }
                        
                    } else {
                        FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email)
                        // If the user creation works, let's go to the list of snaps
                        print("Created user successfully")
                        self.performSegue(withIdentifier: "signinsegue", sender: nil)
                    }
                    
                })
            } else {
                // If user has already an account and is loged in, let's go to the list of snaps
                print("Signed in successfully")
                self.performSegue(withIdentifier: "signinsegue", sender: nil)
            }
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // releasing the focus on the textField and hiding the keyboard
        passwordTextField.resignFirstResponder()
        self.signinupTapped(self)
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

