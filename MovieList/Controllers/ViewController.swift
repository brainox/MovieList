//
//  ViewController.swift
//  MovieList
//
//  Created by Decagon on 20/08/2021.
//

import UIKit

class ViewController: UIViewController, AlertDisplayer {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    private enum CellIdentifers {
        static let cell = "cell"
    }
    
    private var viewModel: MoviesViewModel!
    
    private var shouldShowLoadingCell = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.isHidden = true
        moviesTableView.dataSource = self
        moviesTableView.prefetchDataSource = self
        
        viewModel = MoviesViewModel(delegate: self)
        
        viewModel.fetchMovies()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifers.cell, for: indexPath) as! MoviesTableViewCell
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none)
        } else {
            cell.configure(with: viewModel.movie(at: indexPath.row))
        }
        return cell
    }
}

extension ViewController: MoviesViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
      // 1
      guard let newIndexPathsToReload = newIndexPathsToReload else {
        moviesTableView.isHidden = false
        moviesTableView.reloadData()
        return
      }
      // 2
      let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        moviesTableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
    func onFetchFailed(with reason: String) {
      let title = "Warning".localizedString
      let action = UIAlertAction(title: "OK".localizedString, style: .default)
      displayAlert(with: title , message: reason, actions: [action])
    }
    
    
}

extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchMovies()
        }
    }
}

private extension ViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = moviesTableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}

