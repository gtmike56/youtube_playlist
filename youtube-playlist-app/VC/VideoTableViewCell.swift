//
//  VideoTableViewCell.swift
//  youtube-playlist-app
//
//  Created by Mikhail Udotov on 11.05.2020.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    var thumbnailImageView = UIImageView()

    var titleLabel = UILabel()

    var dateLabel = UILabel()
    
    var stackView = UIStackView()
    
    var video : Video?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func uiSetUp(){

        contentView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.contentMode = .scaleToFill
        stackView.alignment = .fill
        stackView.distribution = .fill

        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2

        dateLabel.textColor = .lightGray
        dateLabel.font = UIFont.systemFont(ofSize: 17)
        dateLabel.numberOfLines = 1

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true

        thumbnailImageView.widthAnchor.constraint(equalTo: thumbnailImageView.heightAnchor, multiplier: 480/360).isActive = true
        thumbnailImageView.contentMode = .scaleAspectFit

        stackView.addArrangedSubview(thumbnailImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
        
        contentView.backgroundColor = .black
        
    }
    
    func setCell(v:Video){
        
        self.video = v
        
        guard self.video != nil else {return}
        
        self.titleLabel.text = video?.title
        
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        
        self.dateLabel.text = df.string(from: video!.published)
        
        guard self.video?.thumbnail != "" else {return}
        
        if let cacheData = CacheManager.getVideoCache(url: self.video!.thumbnail){
            self.thumbnailImageView.image = UIImage(data: cacheData)
            return
        }
        
        let url = URL(string: self.video!.thumbnail)
        
        let session = URLSession.shared
        
        let datatask = session.dataTask(with: url!) { (data, response, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("There is no image")
                return
            }
            
            CacheManager.setVideoCache(url: url!.absoluteString, data: data)
            
            if url?.absoluteString != self.video?.thumbnail {
                return
            }
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.thumbnailImageView.image = image
            }
        }
        datatask.resume()
    }
}
