//
//  MovieCell.swift
//  Flixster
//
//  Created by Chelsea Garcia on 2/3/24.
//

import UIKit
import Nuke

class MovieCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with movie: Movie){
        nameLabel.text = movie.title
        descriptionLabel.text = movie.description
        
        Nuke.loadImage(with: movie.fullPosterImageURL, into: movieImage)
        
    }

}
