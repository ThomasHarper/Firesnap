//
//  PictureViewController.swift
//  Snapfire
//
//  Created by Thomas Bentkowski on 09/11/2016.
//  Copyright © 2016 Thomas Bentkowski. All rights reserved.
//

import UIKit
import Firebase

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    /////////////////// OUTLETS ////////////////////
    @IBOutlet weak var snapImage: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    ///////////////// PROPERTIES ///////////////////
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Where do we want our photos from and we don't want edited photos
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        
        
        // Let's take the image from the picker
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        snapImage.image = image
        
        // When the user picks a picture, disabling the background color of the UIImageView
        snapImage.backgroundColor = UIColor.clear
        
        // Closing the image picker
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func cameraTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func nextTapped(_ sender: Any) {
        // When uploading the image we don't want the user to hit next multiple times
        nextButton.isEnabled = false
        nextButton.setTitle("Uploading...", for: .normal)
        
        // Let's get our Firebase storage path
        let imagesFolder = FIRStorage.storage().reference().child("images")
        
        // Let's shrink our image to a lower quality in order to upload it faster
        let imageData = UIImageJPEGRepresentation(snapImage.image!, 0.1)!
        
        // uploading the image to Firebase
        imagesFolder.child("images.png").put(imageData, metadata: nil, completion: {(metadata, error) in
            print("We tried to upload")
            if error != nil {
                print("Something went wrong uploading : \(error)")
            } else {
                self.performSegue(withIdentifier: "selectusersegue", sender: nil)
            }
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
