//
//  MoviesViewModel.swift
//  MovieList
//
//  Created by Decagon on 21/08/2021.
//

import Foundation

protocol MoviesViewModelDelegate: AnyObject {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

final class MoviesViewModel {
    private weak var delegate: MoviesViewModelDelegate?
    private var movies: [Movies] = []
    private var currentPage = 1
    private var total = 0
    private var isFetchInProgress = false
    
    let client = MoviesClient()
    
    init( delegate: MoviesViewModelDelegate) {
      self.delegate = delegate
    }
    
    var totalCount: Int {
        return total
    }
    
    var currentCount: Int {
        return movies.count
    }
    
    func movie(at index: Int) -> Movies {
        return movies[index]
    }
    
    func fetchMovies() {
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        client.fetchMovies(at: currentPage) { result in
            switch result {
            
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.onFetchFailed(with: error.reason)
                }
            case .success(let response):
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    self.total = response.totalResults
                    self.movies.append(contentsOf: response.results)
                    
                    if response.page > 1 {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: response.results)
                        self.delegate?.onFetchCompleted(with: indexPathsToReload)
                    } else {
                        self.delegate?.onFetchCompleted(with: .none)
                    }
                }
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newMovies: [Movies]) -> [IndexPath] {
        let startIndex = movies.count - newMovies.count
        let endIndex = startIndex + newMovies.count
        return (startIndex..<endIndex).map {
            IndexPath(row: $0, section: 0)
        }
    }
}
