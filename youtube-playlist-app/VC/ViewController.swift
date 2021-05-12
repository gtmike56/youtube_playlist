//
//  ViewController.swift
//  youtube-playlist-app
//
//  Created by Mikhail Udotov on 11.05.2020.
//

import UIKit

class ViewController: UIViewController, ModelDelegate {

    var model = Model()
    var videos = [Video]()
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        model.delegate = self
        
        uiSetUp()
        model.getVideos()
    }
    
    func uiSetUp(){
        view.addSubview(tableView)
        
        tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: Constants.VIDEOCELL_ID)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.backgroundColor = .black
        
        title = "Playlist Videos"
        
    }
    
    //MARK: - Model Delegate Methods
    
    func videosFetched(videos: [Video]) {
        
        self.videos = videos
        
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    //MARK: - TableView methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return videos.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath) as! VideoTableViewCell
        cell.selectionStyle = .none
        cell.uiSetUp()
        cell.setCell(v: videos[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        let destinationVC = DetailViewController()
        
        destinationVC.video = videos[indexPath.row]
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 385
    }
    
}

