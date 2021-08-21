//
//  MoviesTableViewCell.swift
//  MovieList
//
//  Created by Decagon on 21/08/2021.
//

import UIKit
import SDWebImage

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        activityIndicator.hidesWhenStopped = true
    }
    
    func configure(with movies: Movies?) {
        if let movie = movies {
            guard movie.originalTitle != nil else { return }
            movieNameLabel.text = movie.originalTitle
            guard let posterPath = movie.posterPath else {return}
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            movieImageView.sd_setImage(with: imageUrl)
            movieNameLabel.alpha = 1
            movieImageView.alpha = 1
            activityIndicator.stopAnimating()
        } else {
            movieNameLabel.alpha = 0
            activityIndicator.startAnimating()
        }
    }
}
