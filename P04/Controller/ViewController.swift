//
//  ViewController.swift
//  P04
//
//  Created by Guillaume Donzeau on 05/03/2021.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var button = UIButton() // Square or rectangle pressed to receive photo
   
    var application = Application()
    
    
    /*
    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
    NSLog("The \"OK\" alert occured.")
    }))
    self.present(alert, animated: true, completion: nil)
    */
    
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
            application.state = .horizontal
        } else {
            swipeToShare.text = "Swipe up to share"
            arrow.setImage(UIImage(imageLiteralResourceName: "Arrow Up"), for: .normal)
            application.state = .vertical
        }
    }
    @IBAction func severalButtons(_ sender: UIButton) { // Buttons to choose disposition
        let buttonsArray = [button01,button02,button03]
        let layOuts = ["Layout 1","Layout 2","Layout 3"]
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
    @IBAction func allButtons(_ sender: UIButton) { // Adding photo from library
        findMedia(senderTag: sender.tag, camera: false)
    }
    
    @IBAction func longAllButtons(_ sender: UILongPressGestureRecognizer) { // To take a photo
        guard let button = sender.view as? UIButton else { return }
        findMedia(senderTag: button.tag, camera: true)
    }
    
    func findMedia (senderTag:Int, camera:Bool) { // getting photo from library or from camera
        if let tmpButton = self.view.viewWithTag(senderTag) as? UIButton { // identifying button with its tag
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
    @IBAction func sendImage(_ sender: UISwipeGestureRecognizer) { // Swipe up of left to send photo
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        var translationTransform: CGAffineTransform
        var translationBackTransform: CGAffineTransform
        translationBackTransform = CGAffineTransform(translationX: 0, y: 0)
        
        if application.state == .vertical {
            print("Up")
            translationTransform = CGAffineTransform(translationX: 0, y: -screenHeight)
        } else {
            translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
        }
        if checkThatAllImagesAreFull() {
            print("Toutes les images sont choisies")
            let renderer = UIGraphicsImageRenderer(size: finalImage.bounds.size)
            let image = renderer.image { ctx in
                finalImage.drawHierarchy(in: finalImage.bounds, afterScreenUpdates: true)
            }
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
            print("Il manque des images") // Ici alerte
            //alert.actions
            showAlert()
            
        }
    }
    
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) { // Reinitialization swiping down
        start()
    }
    
    private func checkThatAllImagesAreFull() -> Bool {
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
    private func checkButton(sender:UIButton) -> Bool{
        var response = true // Présomption d'innocence
        if sender.isHidden == false && (sender.currentImage?.isEqual(UIImage(named:"Plus"))) == true {
            response = false
            sender.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }
        return response
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Some images are empty", message: "Please fill them.", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Sure", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
        }
        alert.addAction(action1)
        self.present(alert, animated: true, completion: nil)
        
    }
}
