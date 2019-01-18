//
//  PhotoAlbumVC.swift
//  PhotoAlbum
//
//  Created by Joshua Viera on 1/17/19.
//  Copyright © 2019 Joshua Viera. All rights reserved.
//

import UIKit

class PhotoAlbumVC: UIViewController {
    
    @IBOutlet  weak var collectionView: UICollectionView!
    public var photoAlbumArr = [UIImage]()
    var items = [Item](){
        didSet{
            collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setItems()
        print(DataPersistanceManager.documentsDirectory())
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setItems()
        collectionView.reloadData()
    }
    
    func setItems() {
        self.items = ItemModel.getItems()
    }
    
    @IBAction func options(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let edit = UIAlertAction(title: "Edit", style: .default) { (action) in
            
        }
        let share = UIAlertAction(title: "Share", style: .default) { (action) in
            print("Share button pressed")
        }
        
        let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
           ItemModel.delete(atIndex: sender.tag)
            self.setItems()
            
        }
        actionSheet.addAction(delete)
        actionSheet.addAction(edit)
        actionSheet.addAction(share)
        actionSheet.addAction(cancel)
        present(actionSheet,animated: true, completion: nil)
        
    }
}

extension PhotoAlbumVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 400, height: 400)
    }
}
extension PhotoAlbumVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ItemModel.getItems().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoAlbumCell", for: indexPath) as? PhotoAlbumCell else {return UICollectionViewCell()}
        
       let item = items[indexPath.row]
        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath

        cell.photo.image = UIImage(data: item.imageData)
        cell.caption.text = item.description
        cell.optionsButton.tag = indexPath.row
        cell.timeStamp.text = item.dateFormattedString
        return cell
    }
}
