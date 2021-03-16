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
    let layOuts = ["Layout 1","Layout 2","Layout 3"]
    
    enum State {
        case horizontal, vertical
    }
    
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
    @IBAction func severalButtons(_ sender: UIButton) {
        let buttonsArray = [button01,button02,button03]
        print("Bouton \(sender.tag) appuyé.")
        // Boucle qui compare le tag envoyé à celui des boutons et agit en conséquence
        // Image "Selected" si égal ou alors le Layout correspondant dans le tableau Layouts
        
        for i in 0..<3 {
            if sender.tag != buttonsArray[i]?.tag {
                buttonsArray[i]?.setImage(UIImage(imageLiteralResourceName: layOuts[i]), for: .normal)
            } else {
                buttonsArray[i]?.setImage(UIImage(imageLiteralResourceName: "Selected"), for: .normal)
            }
        }
        switch sender.tag {
        case 1:
            squareUpLeft.isHidden = true
            squareDownLeft.isHidden = false
        case 2:
            squareUpLeft.isHidden = false
            squareDownLeft.isHidden = true
        case 3:
            squareUpLeft.isHidden = false
            squareDownLeft.isHidden = false
        default :
            squareUpLeft.isHidden = true
            squareDownLeft.isHidden = false
        }
        
    }
    
    @IBAction func allButtons(_ sender: UIButton) {
        findMedia(senderTag: sender.tag, camera: false)
    }
    
    @IBAction func longAllButtons(_ sender: UILongPressGestureRecognizer) {
        guard let button = sender.view as? UIButton else { return }
        //findCamera(senderTag: button.tag)
        findMedia(senderTag: button.tag, camera: true)
    }
    
    func findMedia (senderTag:Int, camera:Bool) {
        if let tmpButton = self.view.viewWithTag(senderTag) as? UIButton {
            button = tmpButton
        }
        let image = UIImagePickerController()
        image.delegate = self
        if camera {
            image.sourceType = UIImagePickerController.SourceType.camera
        } else {
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
        }
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
    
    private func start() {
        let squareButtons = [squareUpLeft,squareUpRight,squareDownLeft,squareDownRight]
        severalButtons(button01)
        for button in squareButtons {
            button?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            button?.setImage(UIImage(imageLiteralResourceName: "Plus"), for: .normal)
        }
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
        let squareArray = [squareUpRight,squareUpLeft,squareDownRight,squareDownLeft]
        // Si la case n'est pas isHidden et que Plus est true, refus et rouge.
        for i in 0..<squareArray.count {
            if checkButton(sender: squareArray[i]!) == false { // ici ! car je suis sûr
                response = false // Si l'un des carrés n'est pas valide, la réponse devient fausse.
                // Pas de break pour vérifier la situation de chaque carré.
            }
        }
        return response
    }
    func checkButton(sender:UIButton) -> Bool{
        var response = true // Présomption d'innocence
        if sender.isHidden == false && (sender.currentImage?.isEqual(UIImage(named:"Plus"))) == true {
            response = false
            sender.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }
        return response
    }
}
