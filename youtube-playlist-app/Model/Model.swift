//
//  Model.swift
//  youtube-playlist-app
//
//  Created by Mikhail Udotov on 11.05.2020.
//

import Foundation

protocol ModelDelegate {
    
    func videosFetched(videos:[Video])
    
}

class Model {
    
    var delegate: ModelDelegate?
    
    
    func getVideos() {
        
        let url = URL(string: Constants.API_URL)
        
        guard let url = url else {
            print("Double check URL")
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("There is no data")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do{
                let response = try decoder.decode(Response.self, from: data)
                
                guard let items = response.items else {
                    print("Model error")
                    return
                }
                DispatchQueue.main.async {
                    self.delegate?.videosFetched(videos: items)
                }
            } catch(let decoderError) {
                print(decoderError)
            }
        }
        dataTask.resume()
    }
}
