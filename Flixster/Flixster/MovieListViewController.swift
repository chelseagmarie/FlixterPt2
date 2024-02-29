//
//  MovieListViewController.swift
//  Flixster
//
//  Created by Chelsea Garcia on 2/3/24.
//
import UIKit
import Nuke
import Foundation
 
class MovieListViewController: UIViewController, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // configures each cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        
        cell.configure(with: movie)
        
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    
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
                
                // Execute UI updates on the main thread when calling from a background callback
                DispatchQueue.main.async {
                    
                    self?.movies = movies
                    
                    // Make the table view reload now that we have new data
                    self?.tableView.reloadData()
                    
                }
            } catch {
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }
        }

        // Initiate the network request
        task.resume()
        print("👋 Below the closure")
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // cell that triggered the segue
        if segue.identifier == "ListToDetails",
        let cell = sender as? UITableViewCell,
        // index path of the cell from the table
        let indexPath = tableView.indexPath(for: cell),
        // destination = movieDetailsViewController
        let movieDetailsViewController = segue.destination as? MovieDetailsViewController {
            
            let movie = movies[indexPath.row]
            
            movieDetailsViewController.movie = movie
        }
           
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get the index path for the current selected table view row (if exists)
        if let indexPath = tableView.indexPathForSelectedRow {
            // Deselect the row at the corresponding index path
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}
