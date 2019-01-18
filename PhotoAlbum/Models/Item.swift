//
//  Item.swift
//  PhotoAlbum
//
//  Created by Joshua Viera on 1/17/19.
//  Copyright © 2019 Joshua Viera. All rights reserved.
//

import Foundation

struct Item : Codable {
    let description: String
    let createdAt: String
    let imageData: Data
    
    public var dateFormattedString: String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = createdAt
        if let date = isoDateFormatter.date(from: createdAt){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyy hh:mm a"
            formattedDate = dateFormatter.string(from: date)
            
        }
        return formattedDate
    }
    public var date: Date{
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = Date()
        if let date = isoDateFormatter.date(from: createdAt){
            formattedDate  = date
        }
        return formattedDate
    }
}
