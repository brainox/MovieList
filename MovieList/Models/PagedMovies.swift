//
//  PagedMovies.swift
//  MovieList
//
//  Created by Decagon on 21/08/2021.
//

import Foundation

// MARK: - PagedMoviesResponse
struct PagedMoviesResponse: Codable {
    let page: Int
    let results: [Movies]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
