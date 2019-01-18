//
//  PhotoAlbumDetailVC.swift
//  PhotoAlbum
//
//  Created by Joshua Viera on 1/17/19.
//  Copyright © 2019 Joshua Viera. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoAlbumDetailVC: UIViewController{

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var textField: UITextView!
    
    private var itemDescriptionPlaceHolder = "Description..."
    let imagePicker =  UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextViews()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
    }
    
    
    @IBAction func photos(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func setUpTextViews() {
        textField.delegate = self
        textField.text = itemDescriptionPlaceHolder
        textField.textColor = .white
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        guard let itemDescription = textField.text else {fatalError("title, description nil")}
        
        //timeStamp base on the current time
        let date = Date()
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate ,.withFullTime,.withInternetDateTime, .withTimeZone,.withDashSeparatorInDate]
        let timeStamp = isoDateFormatter.string(from: date)
        
        //create an item
        let item = Item.init(description: itemDescription, createdAt: timeStamp)
        
        //save item to documents directory
        ItemModel.addItem(item: item)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func camera(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
}
extension PhotoAlbumDetailVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("\ninfo: \(info)\n")
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photo.image = image
        } else {
            print("original image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
}
extension PhotoAlbumDetailVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textField.text == itemDescriptionPlaceHolder {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
}
