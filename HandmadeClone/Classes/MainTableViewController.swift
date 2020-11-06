//
//  MainTableViewController.swift
//  HandmadeClone
//
//  Created by 백상휘 on 2020/11/06.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var iTunesSearchResult: iTunesSearch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.iTunesSearchResult?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 세그웨이 이동 만들 예정.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableItemCell", for: indexPath) as! MainTableItemCell
        
        guard let model = iTunesSearchResult?.results[indexPath.row] else { return cell }
        
        // serviceImage
        
        
        // serviceLabel
        cell.serviceLabel.text = model.trackCensoredName
        
        // licenseLabel
        
        
        // categoryLabel
        
        
        // priceLabel
        
        
        // ratingView
        
        
        
        return cell
    }
    
    
}

class MainTableItemCell: UITableViewCell {
    @IBOutlet weak var serviceImage: UIImageView!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var licenseLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingView: UIView!
}
