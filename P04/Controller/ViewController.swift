//
//  ViewController.swift
//  P04
//
//  Created by Guillaume Donzeau on 05/03/2021.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var app = Application()
    var rank = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        start()
        print("Début")
    }
    
    
    
    @IBOutlet weak var rectangleDown: UIStackView!
    @IBOutlet weak var rectangleUp: UIStackView!
    @IBOutlet weak var doubleSquareUp: UIStackView!
    @IBOutlet weak var doubleSquareDown: UIStackView!
    
    @IBOutlet weak var imageRectangleUp: UIImageView!
    @IBOutlet weak var imageRectangleDown: UIImageView!
    @IBOutlet weak var imageSquareUpLeft: UIImageView!
    @IBOutlet weak var imageSquareUpRight: UIImageView!
    @IBOutlet weak var imageSquareDownLeft: UIImageView!
    @IBOutlet weak var imageSquareDownRight: UIImageView!
    
    @IBOutlet weak var selected01: UIImageView!
    @IBOutlet weak var selected02: UIImageView!
    @IBOutlet weak var selected03: UIImageView!
    
    @IBOutlet weak var button01: UIButton!
    @IBOutlet weak var button02: UIButton!
    @IBOutlet weak var button03: UIButton!
    
    @IBAction func importImageSquareUpRight(_ sender: UIButton) {
        rank = 1
        print("1")
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            // After
        }
    }
    @IBAction func importImageSquareUpLeft(_ sender: UIButton) {
        rank = 2
        print("2")
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            // After
        }
    }
    
    @IBAction func importImageRectangleUp(_ sender: UIButton) {
        rank = 3
        print(rank)
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            // After
        }
    }
    @IBAction func importImageSquareDownRight(_ sender: UIButton) {
        rank = 4
        print(rank)
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            // After
        }
    }
    
    @IBAction func importImageSquareDownLeft(_ sender: UIButton) {
        rank = 5
        print(rank)
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            // After
        }
    }
    @IBAction func importImageRectangleDown(_ sender: UIButton) {
        rank = 6
        print(rank)
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            // After
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            switch rank {
            case 1:
                imageSquareUpRight.image = image
                print("1")
            case 2:
                imageSquareUpLeft.image = image
                print("2")
            case 3:
                imageRectangleUp.image = image
                print("3")
            case 4:
                imageSquareDownRight.image = image
                print("4")
            case 5:
                imageSquareDownLeft.image = image
                print("5")
            case 6:
                imageRectangleDown.image = image
                print("6")
            default:
                print("Rien")
            }
            
        }
        else {
            // Message d'erreur
        }
        self.dismiss(animated: true, completion: nil)
        }
    
    @IBAction func Bouton1() {
        doubleSquareUp.isHidden = true
        rectangleUp.isHidden = false
        doubleSquareDown.isHidden = false
        rectangleDown.isHidden = true
        
        button01.alpha = 1.0
        button02.alpha = 0.1
        button03.alpha = 0.1
 
        /*
        button01.isHidden = false
        button02.isHidden = true
        button03.isHidden = true
 */
    }
    
    @IBAction func Bouton2() {
        doubleSquareUp.isHidden = false
        rectangleUp.isHidden = true
        doubleSquareDown.isHidden = true
        rectangleDown.isHidden = false
        
        button01.alpha = 0.1
        button02.alpha = 1.0
        button03.alpha = 0.1
 
        /*
        button01.isHidden = true
        button02.isHidden = false
        button03.isHidden = true
 */
    }
    
    @IBAction func Bouton3() {
        doubleSquareUp.isHidden = false
        rectangleUp.isHidden = true
        doubleSquareDown.isHidden = false
        rectangleDown.isHidden = true
        
        button01.alpha = 0.1
        button02.alpha = 0.1
        button03.alpha = 1.0
 
        /*
        button01.isHidden = true
        button02.isHidden = true
        button03.isHidden = false
 */
    }
    
    private func start() {
        doubleSquareUp.isHidden = true
        rectangleUp.isHidden = false
        doubleSquareDown.isHidden = false
        rectangleDown.isHidden = true
        button01.alpha = 1.0
        button02.alpha = 0.1
        button03.alpha = 0.1
    }
    
    @IBAction func SwipeUp(_ sender: UISwipeGestureRecognizer) {
        print("UP")
        /*
        let items = [profileImageView.image]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
        */
    }
    
    
    @IBAction func SwipeRight(_ sender: UISwipeGestureRecognizer) {
        print("Right")
    }
}

