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
    var items: [Item]?{
        didSet{
            collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        print(DataPersistanceManager.documentsDirectory())
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    @IBAction func options(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let edit = UIAlertAction(title: "Edit", style: .default) { (action) in
            print("Print Sumn")
        }
        let share = UIAlertAction(title: "Share", style: .default) { (action) in
            print("Share Sumn")
        }
        
        let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            print("Delete")
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
       let item = ItemModel.getItems()[indexPath.row]
        cell.caption.text = item.description
        cell.timeStamp.text = item.dateFormattedString
        return cell
    }
}
