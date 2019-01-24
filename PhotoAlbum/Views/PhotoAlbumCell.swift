//
//  PhotoAlbumCell.swift
//  PhotoAlbum
//
//  Created by Joshua Viera on 1/17/19.
//  Copyright © 2019 Joshua Viera. All rights reserved.
//

import UIKit

class PhotoAlbumCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var optionsButton: UIButton!
}
