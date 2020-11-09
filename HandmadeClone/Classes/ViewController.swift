//
//  ViewController.swift
//  HandmadeClone
//
//  Created by 백상휘 on 2020/11/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    private var iTunesSearchResult: iTunesSearch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let urlString = "https://itunes.apple.com/search?term=game&country=kr&media=software"
        let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
        
        if let url = URL(string: encodedUrlString) {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let data = data {
                    
                    do {
                        
                        self.iTunesSearchResult = try JSONDecoder().decode(iTunesSearch.self, from: data)
//                        sleep(2)
                        
                        DispatchQueue.main.async {
                            
                            self.performSegue(withIdentifier: "MainTableViewControllerSegue", sender: self)
                            
                        }
                    } catch {
                        
                        print(error)
                    }
                }
                
            }.resume()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? MainTableViewController {
            dest.iTunesSearchResult = self.iTunesSearchResult
        }
    }
}

struct iTunesSearch: Codable {
    var resultCount: Int
    var results: [iTunesSearchList]
}

struct iTunesSearchList: Codable {
    var isGameCenterEnabled: Bool
    var advisories: [String]
    var screenshotUrls: [String]
    var ipadScreenshotUrls: [String]
    
    var appletvScreenshotUrls: [String]
    var artworkUrl60: String
    var artworkUrl512: String
    var artworkUrl100: String
    var artistViewUrl: String
    var supportedDevices: [String]
    var features: [String]
    var kind: String
    var formattedPrice: String?
    var isVppDeviceBasedLicensingEnabled: Bool
    var sellerName: String
    var minimumOsVersion: String
    var primaryGenreId: Int
    var releaseNotes: String?
    var currentVersionReleaseDate: String
    var releaseDate: String
    var genreIds: [String]
    var contentAdvisoryRating: String
    var averageUserRatingForCurrentVersion: Double
    var userRatingCountForCurrentVersion: Int
    var trackViewUrl: String
    var trackContentRating: String
    var trackCensoredName: String
    var languageCodesISO2A: [String]
    var fileSizeBytes: String
    var sellerUrl: String?
    var averageUserRating: Double
    var currency: String
    var genres: [String]
    var artistId: Int
    var artistName: String
    var price: Double?
    var description: String
    var bundleId: String
    var primaryGenreName: String
    var trackId: Int
    var trackName: String
    var version: String
    var wrapperType: String
    var userRatingCount: Int
}
