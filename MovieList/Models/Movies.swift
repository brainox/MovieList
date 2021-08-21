//
//  Movies.swift
//  MovieList
//
//  Created by Decagon on 21/08/2021.
//

import Foundation

// MARK: - Movies
struct Movies: Codable {
    let originalTitle: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case posterPath = "poster_path"
    }
}


