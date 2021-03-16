//
//  ViewController.swift
//  P04
//
//  Created by Guillaume Donzeau on 05/03/2021.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var button = UIButton()
    var index = 0
    var rank = 0
    var position = 1
    var oldPosition = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
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
        guard let button = sender.view as? UIButton else { return }
        findCamera(senderTag: button.tag)
    }
    @IBAction func longButtonSquareUpRight(_ sender: UILongPressGestureRecognizer) {
        guard let button = sender.view as? UIButton else { return }
        findCamera(senderTag: button.tag)
    }
    @IBAction func longButtonSquareDownLeft(_ sender: UILongPressGestureRecognizer) {
        guard let button = sender.view as? UIButton else { return }
        findCamera(senderTag: button.tag)
    }
    @IBAction func longButtonSquareDownRight(_ sender: UILongPressGestureRecognizer) {
        guard let button = sender.view as? UIButton else { return }
        findCamera(senderTag: button.tag)
    }
    @IBAction func buttonUpLeft(_ sender: UIButton) {
        findImage(senderTag: sender.tag)
    }
    @IBAction func buttonUpRight(_ sender: UIButton) {
        findImage(senderTag:sender.tag)
    }
    @IBAction func buttonDownLeft(_ sender: UIButton) {
        findImage(senderTag: sender.tag)
    }
    @IBAction func buttonDownRight(_ sender: UIButton) {
        findImage(senderTag: sender.tag)
    }

    func findImage(senderTag:Int) {
        if let tmpButton = self.view.viewWithTag(senderTag) as? UIButton {
            button = tmpButton
        }
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        button.imageView?.contentMode = .scaleAspectFill
        present(image, animated: true) {
            // After
        }
    }
    func findCamera(senderTag:Int) {
        if let tmpButton = self.view.viewWithTag(senderTag) as? UIButton {
            button = tmpButton
        }
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.camera
        image.allowsEditing = false
        button.imageView?.contentMode = .scaleAspectFill
        present(image, animated: true) {
            // After
        }
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            button.setImage(image, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.992049396, green: 0.9922187924, blue: 0.9920386672, alpha: 1)
        } else {
            // Message d'erreur
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func button01(_ sender: UIButton) {
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
        position = button02.tag
        button01.setImage(UIImage(imageLiteralResourceName: "Layout 1"), for: .normal)
        button02.setImage(UIImage(imageLiteralResourceName: "Selected"), for: .normal)
        button03.setImage(UIImage(imageLiteralResourceName: "Layout 3"), for: .normal)
        squareUpLeft.isHidden = false
        squareUpRight.isHidden = false
        squareDownLeft.isHidden = true
        squareDownRight.isHidden = false
    }
    
    @IBAction func button03(_ sender: UIButton) {
        position = button03.tag
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
        squareUpRight.backgroundColor = #colorLiteral(red: 0.992049396, green: 0.9922187924, blue: 0.9920386672, alpha: 1)
        squareUpLeft.backgroundColor = #colorLiteral(red: 0.992049396, green: 0.9922187924, blue: 0.9920386672, alpha: 1)
        squareDownRight.backgroundColor = #colorLiteral(red: 0.992049396, green: 0.9922187924, blue: 0.9920386672, alpha: 1)
        squareDownLeft.backgroundColor = #colorLiteral(red: 0.992049396, green: 0.9922187924, blue: 0.9920386672, alpha: 1)
        squareUpRight.setImage(UIImage(imageLiteralResourceName: "Plus"), for: .normal)
        squareUpLeft.setImage(UIImage(imageLiteralResourceName: "Plus"), for: .normal)
        squareDownRight.setImage(UIImage(imageLiteralResourceName: "Plus"), for: .normal)
        squareDownLeft.setImage(UIImage(imageLiteralResourceName: "Plus"), for: .normal)
    }
    @IBAction func swipeUp(_ sender: UISwipeGestureRecognizer) {
        if swipeToShare.text == "Swipe up to share" {
            print("Up")
            if checkThatAllImagesAreFull() {
                print("Toutes les images sont choisies")
                
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
            else {
                print("Il manque des images")
            }
           
        }
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        if swipeToShare.text == "Swipe left to share" {
            print("Left")
            if checkThatAllImagesAreFull() {
                print("Toutes les images sont choisies")
                
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
            else {
                print("Il manque des images")
            }
           
        }
    }
    
    
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) {
        start()
    }
    
    func checkThatAllImagesAreFull() -> Bool {
        // Variable globale en fonction du bouton du bas choisi en dernier
        var response = true
        // Changer la logique :
        // Si la case n'est pas isHidden et que Plus est true, refus et rouge.
        // Trouver si c'est possible de mettre les boutons dans un tableau ou d'y avoir accès par le tag.
        // En fait, la fonction checkButton
        if checkButton(sender: squareUpLeft) == true && response == true {
            response = false
        }
        if checkButton(sender: squareDownLeft) == true && response == true {
            response = false
        }
        if checkButton(sender: squareUpRight) == true && response == true {
            response = false
        }
        if checkButton(sender: squareDownRight) == true && response == true {
            response = false
        }
        /*
        
        if (squareUpRight.currentImage?.isEqual(UIImage(named:"Plus"))) == true || (squareDownRight.currentImage?.isEqual(UIImage(named:"Plus"))) == true {
            print("images à droite pas toutes remplies")
            response = false
        }
        if  (squareUpLeft.currentImage?.isEqual(UIImage(named:"Plus"))) == true && position != 1 {
            print("Pas de nouvelle image en haut à gauche")
            response = false
        }
        if (squareDownLeft.currentImage?.isEqual(UIImage(named:"Plus"))) == true && position != 2 {
            print("Pas de nouvelle image en bas à gauche")
            response = false
        }
        if ((squareUpLeft.currentImage?.isEqual(UIImage(named: "yourImageName"))) == true) {
            print("Hello")
        }
            
        if (squareUpRight.currentImage?.isEqual(UIImage(named:"Plus"))) == true {
            squareUpRight.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        } else {
            squareUpRight.backgroundColor = #colorLiteral(red: 0.992049396, green: 0.9922187924, blue: 0.9920386672, alpha: 1)
        }
        
        if (squareUpLeft.currentImage?.isEqual(UIImage(named:"Plus"))) == true {
            squareUpLeft.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        } else {
            squareUpRight.backgroundColor = #colorLiteral(red: 0.992049396, green: 0.9922187924, blue: 0.9920386672, alpha: 1)
        }
        if (squareDownRight.currentImage?.isEqual(UIImage(named:"Plus"))) == true {
            squareDownRight.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        } else {
            squareUpRight.backgroundColor = #colorLiteral(red: 0.992049396, green: 0.9922187924, blue: 0.9920386672, alpha: 1)
        }
        if (squareDownLeft.currentImage?.isEqual(UIImage(named:"Plus"))) == true {
            squareDownLeft.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        } else {
            squareUpRight.backgroundColor = #colorLiteral(red: 0.992049396, green: 0.9922187924, blue: 0.9920386672, alpha: 1)
        }
        print(String(describing: squareDownLeft.currentImage?.isEqual(UIImage(named:"Plus"))))
        */
        return response
    }
    
    func checkButton(sender:UIButton) -> Bool{
        var response = true
        if sender.isHidden != true && (sender.currentImage?.isEqual(UIImage(named:"Plus"))) == true {
            response = false
            sender.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }
        return response
    }
}
