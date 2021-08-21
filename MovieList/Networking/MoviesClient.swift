//
//  MoviesClient.swift
//  MovieList
//
//  Created by Decagon on 21/08/2021.
//

import Foundation

final class MoviesClient {
    
    static let apiKey = "8b9cbfd10eb1a4a16347d56dd4db8e4c"
    private lazy var baseURL: String = {
        return "https://api.themoviedb.org/3/movie/popular?"
    }()
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchMovies(at page: Int, completion: @escaping (Result<PagedMoviesResponse, DataResponseError>) -> Void) {
        
        guard var urlComponents = URLComponents(string: baseURL) else { return }
        let apiQuery = URLQueryItem(name: "api_key", value: MoviesClient.apiKey)
        let languageQuery = URLQueryItem(name: "language", value: "en-US")
        let pageQuery = URLQueryItem(name: "page", value: "\(page)")
        urlComponents.queryItems?.append(apiQuery)
        urlComponents.queryItems?.append(languageQuery)
        urlComponents.queryItems?.append(pageQuery)
        
        guard let requestURL = urlComponents.url else { return }
        
        session.dataTask(with: requestURL) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.hasSuccessStatusCode,
                  let data = data
            else {
                completion(Result.failure(DataResponseError.network))
                return
            }
            
            guard let decodedResponse = try? JSONDecoder().decode(PagedMoviesResponse.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            
            completion(Result.success(decodedResponse))
        }.resume()
    
    }
}
