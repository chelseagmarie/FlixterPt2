//
//  PostersViewController.swift
//  Flixster
//
//  Created by Chelsea Garcia on 2/12/24.
//

import UIKit
import Nuke

class PostersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // the number of items shown should be the number of albums we have.
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        
        let movie = movies[indexPath.item]
        
        // Get the artwork image url
        let imageUrl = movie.fullPosterImageURL
        
        // Set the image on the image view of the cell
        Nuke.loadImage(with: imageUrl, into: cell.posterImageView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedMovie = movies[indexPath.item]
            // print("here")
            // print(selectedMovie)
            performSegue(withIdentifier: "ShowMovieDetails", sender: selectedMovie)
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=150bfbe2cf4484a805b9afcd27fb5a16")!
        
        // Use the URL to instantiate a request
        let request = URLRequest(url: url)
        
        // Create a URLSession using a shared instance and call its dataTask method
        // The data task method attempts to retrieve the contents of a URL based on the specified URL.
        // When finished, it calls it's completion handler (closure) passing in optional values for data (the data we want to fetch), response (info about the response like status code) and error (if the request was unsuccessful)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            // Handle any errors
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }

            // Make sure we have data
            guard let data = data else {
                print("❌ Data is nil")
                return
            }
         
            do {
                // Create a JSON Decoder
                let decoder = JSONDecoder()
                
                // Use the JSON decoder to try and map the data to our custom model.
                let response = try decoder.decode(MoviesResponse.self, from: data)
                
                // Access the array of movies from the 'results' property
                let movies = response.results
                print("✅ \(movies)")
                
                // Execute UI updates on the main thread when calling from a background callback
                DispatchQueue.main.async {
                    
                    self?.movies = movies
                    
                    // Make the table view reload now that we have new data
                    self?.collectionView.reloadData()
                    
                }
            } catch {
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }
        }

        // Initiate the network request
        task.resume()
        
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.dataSource = self
        
        // Get a reference to the collection view's layout
        // We want to dynamically size the cells for the available space and desired number of columns.
        // NOTE: This collection view scrolls vertically, but collection views can alternatively scroll horizontally.
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        // The minimum spacing between adjacent cells (left / right, in vertical scrolling collection)
        // Set this to taste.
        layout.minimumInteritemSpacing = 4

        // The minimum spacing between adjacent cells (top / bottom, in vertical scrolling collection)
        // Set this to taste.
        layout.minimumLineSpacing = 4

        // Set this to however many columns you want to show in the collection.
        let numberOfColumns: CGFloat = 3

        // Calculate the width each cell need to be to fit the number of columns, taking into account the spacing between cells.
        let width = (collectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns

        // Set the size that each tem/cell should display at
        layout.itemSize = CGSize(width: width, height: width)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMovieDetails",
           let selectedMovie = sender as? Movie,
           let movieDetailsViewController = segue.destination as? MovieDetailsViewController {
                //print(selectedMovie.fullPosterImageURL)
                movieDetailsViewController.movie = selectedMovie
        }
    }


}
