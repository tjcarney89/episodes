//
//  TVMazeAPIClient.swift
//  Episodes
//
//  Created by TJ Carney on 3/20/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import Foundation
import Alamofire

class TVMazeAPIClient {
    
    class func getShow(name: String, completion: @escaping ([String:Any]) -> Void) {
        let parameters = [
            "q" : name
        ]
        Alamofire.request("http://api.tvmaze.com/singlesearch/shows?", method: .get, parameters: parameters, headers: nil).responseJSON { (response) in
            DispatchQueue.main.async {
                
                let jsonResponse = response.result.value as? [String:Any] ?? [:]
                completion(jsonResponse)
            }
        }
    }
    
    class func getAllEpisodes(id: Int, completion: @escaping ([[String:Any]]) -> Void) {
        Alamofire.request("http://api.tvmaze.com/shows/\(id)/episodes").responseJSON { (response) in
            DispatchQueue.main.async {
                
                
                let jsonResponse = response.result.value as? [[String:Any]] ?? [[:]]
                completion(jsonResponse)
            }
        }
    }
}
