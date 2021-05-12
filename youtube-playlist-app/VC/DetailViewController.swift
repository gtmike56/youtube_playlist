//
//  DetailViewController.swift
//  youtube-playlist-app
//
//  Created by Mikhail Udotov on 11.05.2020.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var titleLabel = UILabel()
    
    var dateLabel = UILabel()
    
    var videoWebView = WKWebView()

    var descriptionTextView = UITextView()
    
    var stackView = UIStackView()
    
    var video: Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetUp()
    }
    
    func viewSetUp(){
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.contentMode = . scaleToFill
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.numberOfLines = 2
        
        dateLabel.textColor = .systemGray
        dateLabel.font = UIFont.systemFont(ofSize: 17)
        dateLabel.numberOfLines = 1
        
        descriptionTextView.font = UIFont.systemFont(ofSize: 17)
        
        videoWebView.translatesAutoresizingMaskIntoConstraints = false
        videoWebView.widthAnchor.constraint(equalTo: videoWebView.heightAnchor, multiplier: 1280/720).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(videoWebView)
        stackView.addArrangedSubview(descriptionTextView)
        
        view.backgroundColor = .black
        titleLabel.textColor = .white
        descriptionTextView.textColor = .white
        descriptionTextView.backgroundColor = .black
        
}
    
    override func viewWillAppear(_ animated: Bool) {
        
        title = "Video Details"
                
        guard video != nil else {return}
        
        let url = URL(string: Constants.VIDEO_URL + video!.video_id)
        
        let request = URLRequest(url: url!)
        videoWebView.load(request)
        
        titleLabel.text = video!.title
        
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        
        dateLabel.text = df.string(from: video!.published)
        
        descriptionTextView.text = video!.description
    }

}
