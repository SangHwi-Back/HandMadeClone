//
//  MainTableViewController.swift
//  HandmadeClone
//
//  Created by 백상휘 on 2020/11/06.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var iTunesSearchResult: iTunesSearch?
    let ratingOffset = 10
    
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
        
        // serviceImage : artworkUrl512
        let serviceImageUrl = URL(string: model.artworkUrl512)
        if let serviceImageUrl = serviceImageUrl {
            
            do {
                
                let data = try Data(contentsOf: serviceImageUrl)
                cell.serviceImage.image = UIImage(data: data)
            } catch {
                
                print(error)
            }
            
        }
        
        // serviceLabel
        cell.serviceLabel.text = model.trackCensoredName
        
        // licenseLabel
        cell.licenseLabel.text = model.sellerName
        
        
        
        // categoryLabel
        var categoryText = ""
        model.genres.forEach({categoryText += $0 + ","})
        
        if categoryText.last == "," {
            
            categoryText.removeLast()
        }
        
        cell.categoryLabel.text = categoryText.replacingOccurrences(of: ",", with: ", ")
        
        // priceLabel
        cell.priceLabel.text = model.formattedPrice ?? "무료"
        
        // ratingView: averageUserRating
        
        
        let indexInteger = Int(model.averageUserRating)
        let indexLeftOver = model.averageUserRating.truncatingRemainder(dividingBy: model.averageUserRating)
        
        for i in 0 ..< indexInteger {
            let starImageView = UIImageView()
            starImageView.image = UIImage(systemName: "star.fill")
            
            cell.ratingView.addSubview(starImageView)
            
            starImageView.frame = CGRect(x: i * (20 + ratingOffset), y: 0, width: 20, height: 20)
        }
        
        if indexLeftOver > 0 {
            let starImageView = UIImageView()
            starImageView.image = UIImage(systemName: "star.fill")
            starImageView.alpha = CGFloat(indexLeftOver)
            
            cell.ratingView.addSubview(starImageView)
            
            starImageView.frame = CGRect(x: indexInteger * (20 + ratingOffset), y: 0, width: 20, height: 20)
        }
        
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


