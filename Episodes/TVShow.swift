//
//  TVShow.swift
//  Episodes
//
//  Created by TJ Carney on 3/20/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import Foundation

class TVShow {
    
    let name: String
    let id: Int
    
    init(dictionary: [String:Any]) {
        name = dictionary["name"] as? String ?? "No Show Found"
        id = dictionary["id"] as? Int ?? 0
    }
}

extension TVShow: CustomStringConvertible {
    var description: String {
        return "Name: \(name), ID: \(id)"
    }
}
