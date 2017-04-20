//
//  Episode.swift
//  Episodes
//
//  Created by TJ Carney on 3/20/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import Foundation

class Episode {
    var name: String
    var season: Int
    var episode: Int
    var summary: String
    
    init(dictionary: [String:Any]) {
        name = dictionary["name"] as? String ?? "No Title Available"
        season = dictionary["season"] as? Int ?? 0
        episode = dictionary["number"] as? Int ?? 0
        let rawSummary = dictionary["summary"] as? String ?? "No Description Available"
        summary = rawSummary.replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "</p>", with: "").replacingOccurrences(of: "<br />", with: "").replacingOccurrences(of: "<span>", with: "").replacingOccurrences(of: "</span>", with: "")
    }
}

extension Episode: CustomStringConvertible {
    var description: String {
        return "Name: \(name), Season: \(season), Episode: \(episode)"
    }
}
