//
//  NetworkManager.swift
//  Networking
//
//  Created by Vsevolod Lashin on 09.05.2023.
//

import Foundation

enum Link {
    case imageURL
    case courseURL
    case coursesURL
    case aboutUsURL
    case aboutUsURL2
    
    var url: URL {
        switch self {
        case .imageURL:
            return URL(string: "https://img.freepik.com/premium-photo/aurora-borealis-northern-lights-and-beautiful-star-on-night-sky-background-realistic-2d-illustration_67092-1103.jpg")!
        case .courseURL:
            return URL(string: "https://swiftbook.ru//wp-content/uploads/api/api_course")!
        case .coursesURL:
            return URL(string: "https://swiftbook.ru//wp-content/uploads/api/api_courses")!
        case .aboutUsURL:
            return URL(string: "https://swiftbook.ru//wp-content/uploads/api/api_website_description")!
        case .aboutUsURL2:
            return URL(string: "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
