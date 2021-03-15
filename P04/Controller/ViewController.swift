//
//  ViewController.swift
//  P04
//
//  Created by Guillaume Donzeau on 05/03/2021.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var button = UIButton()
   //var tmpButton = UIButton()
    var index = 0
    var rank = 0
    var position = 1
    var oldPosition = 1
    //var usedButton = self.view.viewWithTag(tmpTag) as? UIButton
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        start()
        print("Début")
    }
    @IBOutlet weak var button01: UIButton!
    @IBOutlet weak var button02: UIButton!
    @IBOutlet weak var button03: UIButton!
    @IBOutlet weak var squareUpLeft: UIButton!
    @IBOutlet weak var squareUpRight: UIButton!
    @IBOutlet weak var squareDownLeft: UIButton!
    @IBOutlet weak var squareDownRight: UIButton!
    @IBOutlet weak var swipeToShare: UILabel!
    @IBOutlet weak var arrow: UIButton!
    @IBOutlet weak var finalImage: UIView!
    override func didRotate(from fromInterfaceOrientation : UIInterfaceOrientation) {
        if fromInterfaceOrientation == .portrait || fromInterfaceOrientation == .portraitUpsideDown {
            swipeToShare.text = "Swipe left to share"
            arrow.setImage(UIImage(imageLiteralResourceName: "Arrow Left"), for: .normal)
        } else {
            swipeToShare.text = "Swipe up to share"
            arrow.setImage(UIImage(imageLiteralResourceName: "Arrow Up"), for: .normal)
        }
    }
    @IBAction func longButtonSquareUpLeft(_ sender: UILongPressGestureRecognizer) {
        
        rank = 1
        findCamera()
        squareUpLeft.imageView?.contentMode = .scaleAspectFill
    }
    @IBAction func longButtonSquareUpRight(_ sender: UILongPressGestureRecognizer) {
        rank = 2
        findCamera()
        squareUpRight.imageView?.contentMode = .scaleAspectFill
    }
    @IBAction func longButtonSquareDownLeft(_ sender: UILongPressGestureRecognizer) {
        rank = 3
        findCamera()
        squareDownLeft.imageView?.contentMode = .scaleAspectFill
    }
    @IBAction func longButtonSquareDownRight(_ sender: UILongPressGestureRecognizer) {
        rank = 4
        findCamera()
        squareDownRight.imageView?.contentMode = .scaleAspectFill
    }
    @IBAction func buttonUpLeft(_ sender: UIButton) {
        test(sender)
        rank = 1
        findImage(senderTag: sender.tag)
        squareUpLeft.imageView?.contentMode = .scaleAspectFill
    }
    @IBAction func buttonUpRight(_ sender: UIButton) {
        test(sender)
        findImage(senderTag:sender.tag)
    }
    @IBAction func buttonDownLeft(_ sender: UIButton) {
        test(sender)
    }
    @IBAction func buttonDownRight(_ sender: UIButton) {
        test(sender)
    }
    @IBAction func buttonSquareUpLeft() {
        /*
         rank = 1
         findImage()
         squareUpLeft.imageView?.contentMode = .scaleAspectFill
         */
    }
    
    @IBAction func buttonSquareUpRight() {
        /*
         rank = 2
         findImage()
         squareUpRight.imageView?.contentMode = .scaleAspectFill
         */
    }
    @IBAction func buttonSquareDownLeft() {
        /*
         rank = 3
         findImage()
         squareDownLeft.imageView?.contentMode = .scaleAspectFill
         */
    }
    @IBAction func buttonSquareDownRight() {
        /*
         rank = 4
         findImage()
         squareDownRight.imageView?.contentMode = .scaleAspectFill
         */
    }
    func test(_ sender: UIButton) {
        print (sender.tag)
    }
    func findImage(senderTag:Int) {
        if let tmpButton = self.view.viewWithTag(senderTag) as? UIButton {
            button = tmpButton
        }
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        present(image, animated: true) {
            // After
        }
    }
    func findCamera() {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.camera
        image.allowsEditing = false
        present(image, animated: true) {
            // After
        }
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            button.setImage(image, for: .normal)
            /*
            switch rank {
            case 1:
                squareUpLeft.setImage(image, for: .normal)
            case 2:
                squareUpRight.setImage(image, for: .normal)
            case 3:
                squareDownLeft.setImage(image, for: .normal)
            case 4:
                squareDownRight.setImage(image, for: .normal)
            default:
                print("???")
            }
            */
        } else {
            // Message d'erreur
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func button01(_ sender: UIButton) {
        test(sender)
        position = button01.tag
        button01.setImage(UIImage(imageLiteralResourceName: "Selected"), for: .normal)
        button02.setImage(UIImage(imageLiteralResourceName: "Layout 2"), for: .normal)
        button03.setImage(UIImage(imageLiteralResourceName: "Layout 3"), for: .normal)
        squareUpLeft.isHidden = true
        squareUpRight.isHidden = false
        squareDownLeft.isHidden = false
        squareDownRight.isHidden = false
    }
    @IBAction func button02(_ sender: UIButton) {
        test(sender)
        position = button01.tag
        button01.setImage(UIImage(imageLiteralResourceName: "Layout 1"), for: .normal)
        button02.setImage(UIImage(imageLiteralResourceName: "Selected"), for: .normal)
        button03.setImage(UIImage(imageLiteralResourceName: "Layout 3"), for: .normal)
        squareUpLeft.isHidden = false
        squareUpRight.isHidden = false
        squareDownLeft.isHidden = true
        squareDownRight.isHidden = false
    }
    
    @IBAction func button03(_ sender: UIButton) {
        test(sender)
        position = button01.tag
        button01.setImage(UIImage(imageLiteralResourceName: "Layout 1"), for: .normal)
        button02.setImage(UIImage(imageLiteralResourceName: "Layout 2"), for: .normal)
        button03.setImage(UIImage(imageLiteralResourceName: "Selected"), for: .normal)
        squareUpLeft.isHidden = false
        squareUpRight.isHidden = false
        squareDownLeft.isHidden = false
        squareDownRight.isHidden = false
    }
    
    private func start() {
        button01.setImage(UIImage(imageLiteralResourceName: "Selected"), for: .normal)
        button02.setImage(UIImage(imageLiteralResourceName: "Layout 2"), for: .normal)
        button03.setImage(UIImage(imageLiteralResourceName: "Layout 3"), for: .normal)
        squareUpLeft.isHidden = true
        squareUpRight.isHidden = false
        squareDownLeft.isHidden = false
        squareDownRight.isHidden = false
    }
    @IBAction func swipeUp(_ sender: UISwipeGestureRecognizer) {
        if swipeToShare.text == "Swipe up to share" {
            print("Up")
            if checkThatAllImagesAreFull() {
                print("Toutes les images sont choisies")
            }
            else {
                print("Il manque des images")
            }
            let renderer = UIGraphicsImageRenderer(size: finalImage.bounds.size)
            let image = renderer.image { ctx in
                finalImage.drawHierarchy(in: finalImage.bounds, afterScreenUpdates: true)
            }
            let screenHeight = UIScreen.main.bounds.height
            var translationTransform: CGAffineTransform
            var translationBackTransform: CGAffineTransform
            translationTransform = CGAffineTransform(translationX: 0, y: -screenHeight)
            translationBackTransform = CGAffineTransform(translationX: 0, y: 0)
            UIView.animate(withDuration: 0.3) {
                self.finalImage.transform = translationTransform
            }
            // Envoi photo
            let items = [image]
            let sendPhoto = UIActivityViewController(activityItems: items, applicationActivities: nil)
            present(sendPhoto, animated: true)
            sendPhoto.completionWithItemsHandler = { activity, success, items, error in
                UIView.animate(withDuration: 0.3) {
                    self.finalImage.transform = translationBackTransform
                }
            }
        }
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        if swipeToShare.text == "Swipe left to share" {
            print("Left")
            if checkThatAllImagesAreFull() {
                print("Toutes les images sont choisies")
            }
            else {
                print("Il manque des images")
            }
            let renderer = UIGraphicsImageRenderer(size: finalImage.bounds.size)
            let image = renderer.image { ctx in
                finalImage.drawHierarchy(in: finalImage.bounds, afterScreenUpdates: true)
            }
            let screenWidth = UIScreen.main.bounds.width
            var translationTransform: CGAffineTransform
            var translationBackTransform: CGAffineTransform
            translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
            translationBackTransform = CGAffineTransform(translationX: 0, y: 0)
            UIView.animate(withDuration: 0.3) {
                self.finalImage.transform = translationTransform
                print("Anim")
            }
            let items = [image]
            let sendPhoto = UIActivityViewController(activityItems: items, applicationActivities: nil)
            present(sendPhoto, animated: true)
            sendPhoto.completionWithItemsHandler = { activity, success, items, error in
                UIView.animate(withDuration: 0.3) {
                    self.finalImage.transform = translationBackTransform
                }
            }
        }
    }
    func checkThatAllImagesAreFull() -> Bool {
        // Variable globale en fonction du bouton du bas choisi en dernier
        var response = true
        if (squareUpRight.currentImage?.isEqual(UIImage(named:"Plus"))) != nil || (squareDownRight.currentImage?.isEqual(UIImage(named:"Plus"))) != nil {
            print("images à droite pas toutes remplies")
            response = false
        }
        if  (squareUpLeft.currentImage?.isEqual(UIImage(named:"Plus"))) != nil || position != 1 {
            print("Pas de nouvelle image en haut à gauche")
            response = false
        }
        if (squareDownLeft.currentImage?.isEqual(UIImage(named:"Plus"))) != nil || position != 2 {
            print("Pas de nouvelle image en bas à gauche")
            response = false
        }
    
        return response
    }
}
