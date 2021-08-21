//
//  MoviesTableViewCell.swift
//  MovieList
//
//  Created by Decagon on 21/08/2021.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        activityIndicator.hidesWhenStopped = true
    }
}
