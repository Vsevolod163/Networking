//
//  Course.swift
//  Networking
//
//  Created by Vsevolod Lashin on 05.05.2023.
//

import Foundation

struct Course: Codable {
    let name: String
    let imageUrl: URL
    let numberOfLessons: Int
    let numberOfTests: Int
    
//    enum CodingKeys: String, CodingKey {
//        case name = "Name"
//        case imageUrl = "ImageUrl"
//        case numberOfLessons = "NumberOfLessons"
//        case numberOfTests = "NumberOfTests"
//    }
}

struct SwiftBookInfo: Codable {
    let courses: [Course]
    let websiteDescription: String
    let websiteName: String
}
