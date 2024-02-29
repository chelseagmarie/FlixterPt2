//
//  PosterCell.swift
//  Flixster
//
//  Created by Chelsea Garcia on 2/12/24.
//

import UIKit
import Nuke

class PosterCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with movie: Movie){
        
        Nuke.loadImage(with: movie.fullPosterImageURL, into: posterImageView)
        
    }
}
