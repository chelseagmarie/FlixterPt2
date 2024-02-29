//
//  MovieDetailsViewController.swift
//  Flixster
//
//  Created by Chelsea Garcia on 2/3/24.
//

import Foundation
import UIKit
import Nuke

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var movieNameLabel: UILabel!
    
    @IBOutlet weak var voteAverageLabel: UILabel!
    
    @IBOutlet weak var voteCountLabel: UILabel!
    
    @IBOutlet weak var popularityLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print("Im in the view did load!")
        // print(movie ?? "oopsies")
        
        Nuke.loadImage(with: movie.fullBackdropImageURL, into: movieImageView)
        
        movieNameLabel.text = movie.title
        voteAverageLabel.text = "Vote Average: " + String(movie.voteAverage)
        voteCountLabel.text = "Vote Count: " + String(movie.voteCount)
        popularityLabel.text = "Popularity: " + String(movie.popularity)
        descriptionLabel.text = movie.description
        
    }
}
