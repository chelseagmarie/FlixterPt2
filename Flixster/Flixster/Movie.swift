//
//  Movie.swift
//  Flixster
//
//  Created by Chelsea Garcia on 2/3/24.
//

import Foundation

struct Movie: Decodable {
    let title: String
    var posterImage: URL
    let description: String
    let backdropImage: URL
    let voteAverage : Double
    let voteCount: Int
    let popularity: Double
    
    private enum CodingKeys: String, CodingKey {
        case title
        case posterImage = "poster_path"
        case description = "overview"
        case backdropImage = "backdrop_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity
    }
    
    var fullPosterImageURL: URL {
        if !posterImage.absoluteString.hasPrefix("http"){
            return URL(string: "https://image.tmdb.org/t/p/original/\(posterImage)")!
        } else {
            return posterImage
        }
    }
    
    var fullBackdropImageURL: URL {
        if !backdropImage.absoluteString.hasPrefix("http"){
            return URL(string: "https://image.tmdb.org/t/p/original/\(backdropImage)")!
        } else {
            return backdropImage
        }
    }
}

struct MoviesResponse: Decodable {
    let results: [Movie]
}

extension Movie {
    static var mockMovies: [Movie] = [
        Movie(title: "Justice League: Crisis on Infinite Earths Part One", posterImage: URL(string: "https://image.tmdb.org/t/p/original/zR6C66EDklgTPLHRSmmMt5878MR.jpg")!, description: "Death is coming. Worse than death: oblivion. Not just for our Earth, but for everyone, everywhere, in every universe! Against this ultimate destruction, the mysterious Monitor has gathered the greatest team of Super Heroes ever assembled. But what can the combined might of Superman, Wonder Woman, Batman, The Flash, Green Lantern and hundreds of Super Heroes from multiple Earths even do to save all of reality from an unstoppable antimatter armageddon?!", backdropImage: URL(string: "https://image.tmdb.org/t/p/original/rVJfabCz1ViynQCEz54MRqdZig1.jpg")!, voteAverage: 7.71, voteCount: 143, popularity: 275.658),
        Movie(title: "Aquaman and the Lost Kingdom", posterImage: URL(string: "https://image.tmdb.org/t/p/original/7lTnXOy0iNtBAdRP3TZvaKJ77F6.jpg")!, description: "Black Manta, still driven by the need to avenge his father's death and wielding the power of the mythic Black Trident, will stop at nothing to take Aquaman down once and for all. To defeat him, Aquaman must turn to his imprisoned brother Orm, the former King of Atlantis, to forge an unlikely alliance in order to save the world from irreversible destruction.", backdropImage: URL(string: "https://image.tmdb.org/t/p/original/cnqwv5Uz3UW5f086IWbQKr3ksJr.jpg")!, voteAverage: 6.976, voteCount: 1291, popularity: 1870.622),
        Movie(title: "Oppenheimer", posterImage: URL(string: "https://image.tmdb.org/t/p/original/ptpr0kGAckfQkJeJIt8st5dglvd.jpg")!, description: "The story of J. Robert Oppenheimer's role in the development of the atomic bomb during World War II.", backdropImage: URL(string: "https://image.tmdb.org/t/p/original/fm6KqXpk3M2HVveHwCrBSSBaO0V.jpg")!, voteAverage: 8.118, voteCount: 6513, popularity: 406.348),
        Movie(title: "The Painter", posterImage: URL(string: "https://image.tmdb.org/t/p/original/UZ0ydgbXtnrq8xZCI5lHVXVcH9.jpg")!, description: "An ex-CIA operative is thrown back into a dangerous world when a mysterious woman from his past resurfaces. Now exposed and targeted by a relentless killer and a rogue black ops program, he must rely on skills he thought he left behind in a high-stakes game of survival.", backdropImage: URL(string: "https://image.tmdb.org/t/p/original/6OnoMgGFuZ921eV8v8yEyXoag19.jpg")!, voteAverage: 7.196, voteCount: 46, popularity: 334.811),
        Movie(title: "The Bricklayer", posterImage: URL(string: "https://image.tmdb.org/t/p/original/36pYugctLa70NmwMEgXTR1G31Kq.jpg")!, description: "Someone is blackmailing the CIA by assassinating foreign journalists and making it look like the agency is responsible. As the world begins to unite against the U.S., the CIA must lure its most brilliant – and rebellious – operative out of retirement, forcing him to confront his checkered past while unraveling an international conspiracy.", backdropImage: URL(string: "https://image.tmdb.org/t/p/original/47SVqaO02doJ06tOmrjiWDkwU3T.jpg")!, voteAverage: 6.167, voteCount: 75, popularity: 272.84)
    ]
}
