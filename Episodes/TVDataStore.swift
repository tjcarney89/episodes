//
//  TVDataStore.swift
//  Episodes
//
//  Created by TJ Carney on 3/20/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import Foundation

final class TVDataStore {
    static let sharedInstance = TVDataStore()
    private init () {}
    
    var episodes: [Episode] = []
    var show: TVShow?
    
    func createShow(name: String, completion: @escaping () -> Void) {
        TVMazeAPIClient.getShow(name: name) { (showDict) in
            self.show = TVShow(dictionary: showDict)
            completion()

        }
    }
    
    func createEpisodes(id: Int, completion: @escaping () -> Void) {
        TVMazeAPIClient.getAllEpisodes(id: id) { (jsonResponse) in
            for response in jsonResponse {
                let newEpisode = Episode(dictionary: response)
                self.episodes.append(newEpisode)
            }
            completion()
        }
    }
}
