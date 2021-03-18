//
//  ViewController.swift
//  P04
//
//  Created by Guillaume Donzeau on 05/03/2021.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var buttonPlus = UIButton() // Square or rectangle pressed to receive photo
    var application = Application()
    var position = UIDevice.current.orientation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
        print("Le téléphone est \(position)")
    }
    
    override func viewDidLayoutSubviews() {
            if UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height {
                print("Portrait")
                swipeToShare.text = "Swipe up to share"
                arrow.setImage(UIImage(imageLiteralResourceName: "Arrow Up"), for: .normal)
                application.state = .vertical
                
            } else {
                print("Landscape")
                swipeToShare.text = "Swipe left to share"
                arrow.setImage(UIImage(imageLiteralResourceName: "Arrow Left"), for: .normal)
                application.state = .horizontal
            }
        }
    
    @IBOutlet var buttonsDown: [UIButton]!
    @IBOutlet var squares: [UIButton]!
    @IBOutlet weak var swipeToShare: UILabel!
    @IBOutlet weak var arrow: UIButton!
    @IBOutlet weak var finalImage: UIView!
    
    
    /*
    override func didRotate(from fromInterfaceOrientation : UIInterfaceOrientation) { // Text changes depending of device's orientation
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
    */
    @IBAction func severalButtons(_ sender: UIButton) { // Buttons for disposal
        print("Bouton \(sender.tag) appuyé.")
        for initializing in buttonsDown {
            initializing.isSelected = false
        }
        sender.isSelected = true
        switch sender.tag {
        case 1:
            squares[0].isHidden = true
            squares[2].isHidden = false
        case 2:
            squares[0].isHidden = false
            squares[2].isHidden = true
        case 3:
            squares[0].isHidden = false
            squares[2].isHidden = false
        default :
            squares[0].isHidden = true
            squares[2].isHidden = false
        }
    }
    @IBAction func allButtons(_ sender: UIButton) { // Adding photo from library
        findMedia(senderTag: sender.tag, camera: false)
    }
    @IBAction func longAllButtons(_ sender: UILongPressGestureRecognizer) { // To take a photo
        guard let button = sender.view as? UIButton else { return }
        findMedia(senderTag: button.tag, camera: true)
    }
    private func findMedia (senderTag:Int, camera:Bool) { // getting photo from library or from camera
        if let tmpButton = self.view.viewWithTag(senderTag) as? UIButton { // identifying button with its tag
            buttonPlus = tmpButton
        }
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        if camera {
            imagePickerController.sourceType = UIImagePickerController.SourceType.camera
        } else {
            imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        }
        imagePickerController.allowsEditing = false
        buttonPlus.imageView?.contentMode = .scaleAspectFill
        present(imagePickerController, animated: true) {
            // After
        }
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            buttonPlus.setImage(imagePicked, for: .normal)
            buttonPlus.backgroundColor = #colorLiteral(red: 0.992049396, green: 0.9922187924, blue: 0.9920386672, alpha: 1)
        } else {
            // Message d'erreur
        }
        dismiss(animated: true, completion: nil)
    }
    private func start() {
        for centralButton in squares {
            centralButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            centralButton.setImage(UIImage(imageLiteralResourceName: "Plus"), for: .normal)
        }
        severalButtons(buttonsDown[0]) // First button taped
    }
    @IBAction func senderImage(_ sender: UISwipeGestureRecognizer) { // Swipe up of left to send photo
        // Animation's parameters
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        var translationTransform: CGAffineTransform
        var translationBackTransform: CGAffineTransform
        translationBackTransform = CGAffineTransform(translationX: 0, y: 0)
        // Depending of phone's position, the animation back has to be planed
        if application.state == .vertical {
            print("Up")
            translationTransform = CGAffineTransform(translationX: 0, y: -screenHeight)
        } else {
            translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
        }
        // Animation's parameters are ready
        if checkThatAllImagesNotHiddenAreFull() {
            print("Toutes les images sont pleines")
            sendingMedia(translation: translationTransform, translationBack: translationBackTransform)
        }
        else {
            print("Il manque des images") // Ici alerte
            showAlert()
        }
    }
    private func checkThatAllImagesNotHiddenAreFull() -> Bool {
        var response = true
        // Si la case n'est pas isHidden et que Plus est true, refus et rouge.
        for i in 0..<squares.count {
            if checkButton(sender: squares[i]) == false {
                response = false // Si l'un des carrés n'est pas valide, la réponse devient fausse.
                // Pas de break pour vérifier la situation de chaque carré.
            }
            if squares[i].backgroundColor == #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) {
                response = false
            }
        }
        return response
    }
    private func checkButton(sender:UIButton) -> Bool{ // All images which are not hidden have an image which is not "Plus"
        var response = true // Présomption d'innocence
        if sender.isHidden == false && (sender.currentImage?.isEqual(UIImage(named:"Plus"))) == true {
            response = false
            sender.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) // Background of empty cases becomes red to signal them
        }
        return response
    }
    private func finalizingImage() -> UIImage{
        let renderer = UIGraphicsImageRenderer(size: finalImage.bounds.size)
        let imageFinalized = renderer.image { ctx in
            finalImage.drawHierarchy(in: finalImage.bounds, afterScreenUpdates: true)
        }
        return imageFinalized
    }
    private func sendingMedia(translation:CGAffineTransform,translationBack:CGAffineTransform) {
        UIView.animate(withDuration: 0.3) {
            self.finalImage.transform = translation
        }
        // Envoi photo
        let items = [finalizingImage()]
        let sendPhoto = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(sendPhoto, animated: true)
        
        sendPhoto.completionWithItemsHandler = { activity, success, items, error in
            UIView.animate(withDuration: 0.3) {
                self.finalImage.transform = translationBack
            }
        }
    }
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) { // Reinitialization swiping down
        start()
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
