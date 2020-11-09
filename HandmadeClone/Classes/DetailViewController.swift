//
//  DetailViewController.swift
//  HandmadeClone
//
//  Created by 백상휘 on 2020/11/06.
//

import UIKit

class DetailViewController: UIViewController {
    
    // @IBOutlets
    @IBOutlet weak var contentsScrollView: UIScrollView!
    @IBOutlet weak var modelDataView: UIView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var contentsView: UIView!
    
    @IBOutlet weak var screenShotImageView: UIImageView!
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var fileSizeLabel: UILabel!
    @IBOutlet weak var contentRatingLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    @IBOutlet weak var releaseNoteTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // Local Variables
    private var shareButtonURL: URL?
    
    // model
    var result: iTunesSearchList?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.releaseNoteTextView.isHidden = true
        self.descriptionTextView.transform = CGAffineTransform(translationX: 0, y: self.releaseNoteTextView.frame.height * -1)
        
        self.contentsScrollView.frame.size.height = UIScreen.main.bounds.height
        self.contentsScrollView.contentSize = contentsView.frame.size
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.releaseNoteTextView.isHidden = true
        
        var tempFrame = self.descriptionTextView.frame
        tempFrame = CGRect(origin: tempFrame.origin,
                           size: CGSize(width: tempFrame.width, height: tempFrame.height - self.releaseNoteTextView.frame.height))
        self.descriptionTextView.frame = tempFrame
        
        if result != nil {
            
            self.bindModel(data: result!)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func bindModel(data result: iTunesSearchList) {
        
        if let screenshotUrl = result.screenshotUrls.first, let url = URL(string: screenshotUrl) {
            
            do {
                
                let data = try Data(contentsOf: url)
                self.screenShotImageView.image = UIImage(data: data)
            } catch {
                
                print(error)
            }
            
        }
        
        self.trackNameLabel.text = result.trackName
        self.priceLabel.text = result.formattedPrice
        self.artistNameLabel.text = result.artistName
        
        self.shareButtonURL = URL(string: result.trackViewUrl)
        
        // 공유하기 버튼 개발 필요.
        
        self.fileSizeLabel.text = "\((Int(result.fileSizeBytes) ?? 0) / 1024 / 1024)MB"
        
        self.contentRatingLabel.text = result.contentAdvisoryRating
        
        self.versionLabel.text = result.version
        
        self.releaseNoteTextView.text = result.releaseNotes ?? ""
        
        self.descriptionTextView.text = result.description
    }
    
    @IBAction func releaseNoteButtonTouchUpInside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.8) {
            
            let height = self.releaseNoteTextView.frame.height
            
            //이미 숨겨져 있는 상태
            self.descriptionTextView.transform = CGAffineTransform(translationX: 0, y: height * (self.releaseNoteTextView.isHidden ? 1 : -1))
            self.releaseNoteTextView.isHidden.toggle()
            
        }
    }
    
    @IBAction func showButtonTouchUpInside(_ sender: UIButton) {
        let alertController = UIAlertController(title: "", message: self.shareButtonURL?.absoluteString ?? "", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        
        alertController.addAction(action1)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension CGSize {
    static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}
