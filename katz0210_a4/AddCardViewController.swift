//
//  AddCardViewController.swift
//  katz0210_a4
//
//  Created by Bradley Katz on 2018-02-26.
//  Copyright © 2018 Bradley Katz. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var uiImageView: UIImageView!
    
    private let imagePicker = UIImagePickerController()
    
    private var newCard: Card?
    
    private func updateSaveButtonState()
    {
        let questionText = questionField.text ?? ""
        let answerText = answerField.text ?? ""
        
        saveButton.isEnabled = !questionText.isEmpty && !answerText.isEmpty
    }
    
    public func getCard() -> Card?
    {
        return newCard
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        questionField.delegate = self
        answerField.delegate = self
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func textFieldDidEndEditing(_ sender: UITextField)
    {
        answerField.resignFirstResponder()
        questionField.resignFirstResponder()
        updateSaveButtonState()
    }
    
    @IBAction func onViewTapped(_ sender: Any)
    {
        questionField.resignFirstResponder()
        answerField.resignFirstResponder()
        updateSaveButtonState()
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        uiImageView.contentMode = .scaleAspectFit
        uiImageView.image = chosenImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onImageViewTapped(_ sender: UITapGestureRecognizer)
    {
        // Close the keyboard if they were open when uiImageView is tapped
        answerField.resignFirstResponder()
        questionField.resignFirstResponder()
        
        present(imagePicker, animated: true, completion: nil)
        
        //let tappedImageView = sender.view as! UIImageView
    }
    
    // MARK: - Navigation

    @IBAction func onCancelButtonTapped(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        
        let question = questionField.text ?? ""
        let answer = answerField.text ?? ""
        let image = uiImageView.image
        
        newCard = Card(question: question, answer: answer, image: image)
    }
}
