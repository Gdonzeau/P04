//
//  ViewController.swift
//  P04
//
//  Created by Guillaume Donzeau on 05/03/2021.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var buttonPlus = UIButton() // Square or rectangle pressed to receive photo
    var orientation = "" // To describe device's position
    override func viewDidLoad() {
        super.viewDidLoad()
        start() // To initialize squares
        checkOrientation()
    }
    @IBOutlet var buttonsDown: [UIButton]! //To choose disposal for photos
    @IBOutlet var squares: [UIButton]! // The location of each photo
    @IBOutlet weak var swipeToShare: UILabel! // The texte "swipe up" or "swipe left"
    @IBOutlet weak var arrow: UIView! // The symbol for swiping direction
    @IBOutlet weak var finalImage: UIView! // The central square
    
    @IBAction func severalButtons(_ sender: UIButton) { // Press on buttons to choose disposal
        for initializing in buttonsDown { //All buttons are initialized
            initializing.isSelected = false
        }
        sender.isSelected = true // The button taped is selected
        switch sender.tag { // And the layout is set.
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
    @IBAction func longAllButtons(_ sender: UILongPressGestureRecognizer) { // To take a photo with camera
        guard let button = sender.view as? UIButton else { return } // Checking which button is associated (by tag) with longpress
        findMedia(senderTag: button.tag, camera: true)
    }
    @IBAction func senderImage(_ sender: UISwipeGestureRecognizer) { // Swipe up or left to send photo
        // Animation's parameters
        var movementAuthorized = false
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        var translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
        let translationBackTransform = CGAffineTransform(translationX: 0, y: 0)
        // Depending of phone's position, the animation is planned
        checkOrientation()
        switch sender.direction {
        case .left :
            if orientation == "Paysage" {
                translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
                movementAuthorized = true
            }
        case .up :
            if orientation == "Portrait" {
                translationTransform = CGAffineTransform(translationX: 0, y: -screenHeight)
                movementAuthorized = true
            }
        default :
            print("?")
        }
        // Animation's parameters are ready
        if checkThatAllImagesNotHiddenAreFull() { // If there are no images not hidden still with "Plus"
            if movementAuthorized { // The swipe is UP and the device is vertical or the swipe is left and the device is horizontal
                sendingMedia(translation: translationTransform, translationBack: translationBackTransform) //we send the photo
            }
        }
        else { // if there are still images notHidden "Plus" ...
            showAlert()
        }
    }
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) { // Reinitialization swiping down
        start()
    }
    // we chose the image from library or camera. Now we put it in place
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            buttonPlus.setImage(imagePicked, for: .normal)
            buttonPlus.backgroundColor = #colorLiteral(red: 0.992049396, green: 0.9922187924, blue: 0.9920386672, alpha: 1)
            squareBusy()
        } else {
            // Error message
        }
        dismiss(animated: true, completion: nil)
    }
    private func squareBusy() {
        for test in squares {
            if test.tag == buttonPlus.tag {
                test.accessibilityIdentifier = "Busy"
            }
        }
    }
    private func findMedia (senderTag:Int, camera:Bool) { // getting photo from library or from camera
        if let temporButton = self.view.viewWithTag(senderTag) as? UIButton { // identifying button with its tag
            buttonPlus = temporButton
        }
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        if camera {
            imagePickerController.sourceType = UIImagePickerController.SourceType.camera
        } else {
            imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        }
        imagePickerController.allowsEditing = false
        buttonPlus.imageView?.contentMode = .scaleAspectFill // Adjusting photo
        present(imagePickerController, animated: true) {
            // After
        }
    }
    private func start() { // Initializing
        for centralButton in squares {
            centralButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            centralButton.setImage(UIImage(imageLiteralResourceName: "Plus"), for: .normal)
            centralButton.accessibilityIdentifier = "None"
        }
        severalButtons(buttonsDown[0]) // First button taped
    }
    private func checkThatAllImagesNotHiddenAreFull() -> Bool {
        var response = true
        // If the image is not hidden and is still without photo...
        for imageChecked in squares {
            if imageChecked.isHidden == false && imageChecked.accessibilityIdentifier == "None" {
                imageChecked.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                response = false
            }
        }
        return response
    }
    private func checkOrientation() {
        if UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height {
            orientation = "Portrait"
        }
        else {
            orientation = "Paysage"
        }
    }
    private func finalizingImage() -> UIImage{ // Image from central square to be sent
        let renderer = UIGraphicsImageRenderer(size: finalImage.bounds.size)
        let imageFinalized = renderer.image { ctx in
            finalImage.drawHierarchy(in: finalImage.bounds, afterScreenUpdates: true)
        }
        return imageFinalized
    }
    private func sendingMedia(translation:CGAffineTransform,translationBack:CGAffineTransform) {
        UIView.animate(withDuration: 0.3) { // Animation
            self.finalImage.transform = translation
        }
        // Envoi photo
        let items = [finalizingImage()]
        let sendPhoto = UIActivityViewController(activityItems: items, applicationActivities: nil) // Choosing how to send image
        present(sendPhoto, animated: true)
        
        sendPhoto.completionWithItemsHandler = { activity, success, items, error in // After sending, animation back
            UIView.animate(withDuration: 0.3) {
                self.finalImage.transform = translationBack
            }
        }
    }
    private func showAlert() { // If there are squares without image, Alert !
        let alert = UIAlertController(title: "Some images are empty", message: "Please fill them.", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Sure", style: .default) { (action:UIAlertAction) in }
        alert.addAction(action1)
        self.present(alert, animated: true, completion: nil)
    }
}
