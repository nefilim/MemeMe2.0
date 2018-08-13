//
//  SentMemeCollectionViewController.swift
//  MemeMe20
//
//  Created by peter on 8/9/18.
//  Copyright © 2018 peter. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SentMemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    var memes = (UIApplication.shared.delegate as! AppDelegate).memes
    
    var mem = [Meme]()
    
    private let backgroundColours: [UIColor] = [.blue, .red]

    override func viewDidLoad() {
        super.viewDidLoad()
        // make sure we can scroll if there are more items than fits in the frame
        self.collectionView!.bounces = true
        self.collectionView!.alwaysBounceVertical = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        debugPrint("VIEW WILL APPEAR")
        self.tabBarController?.tabBar.isHidden = false
        memes = (UIApplication.shared.delegate as! AppDelegate).memes
        self.collectionView!.reloadData() // pick up the new meme that was added
        setupFlowLayout(view.frame.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        debugPrint("VIEW WILL TRANSITION!!! size \(size)")
        setupFlowLayout(size)
    }

    private func setupFlowLayout(_ size: CGSize) {
        let itemsPerRow: CGFloat
        let spacingBetweenCells: CGFloat
        let portraitAspectRatio: CGFloat // assuming screenshots are being created in portrait mode only
        if (size.height > size.width) { // portrait
            itemsPerRow = 3
            spacingBetweenCells = 3.0
            portraitAspectRatio = size.width / size.height
        } else { // landscape
            itemsPerRow = 5
            spacingBetweenCells = 1.0
            portraitAspectRatio = size.height / size.width
        }
        let width = (size.width - (itemsPerRow * 2 * spacingBetweenCells)) / itemsPerRow
        let height = width / portraitAspectRatio
        debugPrint("frame size width \(size.width) height \(size.height) and width \(width) height \(height) aspect ratio \(portraitAspectRatio)")
        flowLayout.minimumInteritemSpacing = spacingBetweenCells / 2.0
        flowLayout.minimumLineSpacing = spacingBetweenCells
        flowLayout.itemSize = CGSize(width: width, height: height)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
//        cell.backgroundColor = self.backgroundColours[(indexPath as NSIndexPath).row % 2]
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.imageView?.image = meme.compositedImage
        cell.imageView?.contentMode = .scaleAspectFit
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        navigationController!.pushViewController(detailController, animated: true)
    }
}
