//
//  PhotoAlbumDetailVC.swift
//  PhotoAlbum
//
//  Created by Joshua Viera on 1/17/19.
//  Copyright © 2019 Joshua Viera. All rights reserved.
//

import UIKit
import AVFoundation

enum Functions {
    case edit
    case save
}

class PhotoAlbumDetailVC: UIViewController{
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var selectedImage: UIImage!
    var functions: Functions!
    
    private var itemDescriptionPlaceHolder = "Description..."
    let imagePicker =  UIImagePickerController()
    var index = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextViews()
        imagePicker.delegate = self
        if functions == .edit {
            photo.image = selectedImage
        }
    }
    
    
    
    
    
    private func setUpTextViews() {
        textField.delegate = self
        textField.text = itemDescriptionPlaceHolder
        textField.textColor = .lightGray
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        guard let itemDescription = textField.text, let image = photo.image else {fatalError("title, description nil")}
        let data = image.jpegData(compressionQuality: 0.5)
        let date = Date()
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate ,.withFullTime,.withInternetDateTime, .withTimeZone,.withDashSeparatorInDate]
        let timeStamp = isoDateFormatter.string(from: date)
        let item = Item.init(description: itemDescription, createdAt: timeStamp, imageData: data!)
        if functions == .edit{
            ItemModel.edit(item: item, index: index)
        }
        if functions == .save {
            ItemModel.addItem(item: item)
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func photos(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
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
            textView.textColor = .white
        }
    }
    
}
