//
//  SentMemeTableViewController.swift
//  MemeMe20
//
//  Created by peter on 8/7/18.
//  Copyright © 2018 peter. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UITableViewController {
    
    var memes = (UIApplication.shared.delegate as! AppDelegate).memes

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        memes = (UIApplication.shared.delegate as! AppDelegate).memes
        self.tableView.reloadData() // pick up the new meme that was added
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = "\(meme.topText ?? "")...\(meme.bottomText ?? "")"
        if let image = meme.compositedImage {
            cell.imageView!.image = image
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        navigationController!.pushViewController(detailController, animated: true)
    }
}
