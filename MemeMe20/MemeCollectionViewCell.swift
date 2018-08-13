//
//  MemeCollectionViewCell.swift
//  MemeMe20
//
//  Created by peter on 8/9/18.
//  Copyright © 2018 peter. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    // MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    func populateCell(_ meme: Meme) {
        imageView.image = meme.compositedImage
        imageView.contentMode = .scaleAspectFit
    }
}
