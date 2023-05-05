//
//  Course.swift
//  Networking
//
//  Created by Vsevolod Lashin on 05.05.2023.
//

import Foundation

struct Course: Decodable {
    let name: String
    let imageUrL: URL
    let number_of_lessons: Int
    let number_of_tests: Int
}
