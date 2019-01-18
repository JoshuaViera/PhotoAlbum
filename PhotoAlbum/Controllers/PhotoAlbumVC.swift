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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
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
extension PhotoAlbumVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoAlbumCell", for: indexPath) as? PhotoAlbumCell else {return UICollectionViewCell()}
        return cell
    }
}
extension PhotoAlbumVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 400, height: 400)
    }
    
}
