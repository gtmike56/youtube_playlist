//
//  ViewController.swift
//  youtube-playlist-app
//
//  Created by Mikhail Udotov on 11.05.2020.
//

import UIKit

class ViewController: UITableViewController, ModelDelegate {

    var model = Model()
    var videos = [Video]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Playlist Videos"
        tableView.backgroundColor = .black

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: Constants.VIDEOCELL_ID)
        
        model.delegate = self
        
        model.getVideos()
    }
    
    //MARK: - Model Delegate Methods
    
    func videosFetched(videos: [Video]) {
        
        self.videos = videos
        
        tableView.reloadData()
    }
}

extension ViewController {
    
    //MARK: - TableView methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return videos.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath) as! VideoTableViewCell
        cell.selectionStyle = .none
        cell.uiSetUp()
        cell.setCell(v: videos[indexPath.row])
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        let destinationVC = DetailViewController()
        
        destinationVC.video = videos[indexPath.row]
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 385
    }
    
}

