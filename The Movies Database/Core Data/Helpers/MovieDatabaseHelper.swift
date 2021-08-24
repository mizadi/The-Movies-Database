//
//  MovieDatabaseHelper.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 15/07/2021.
//

import Foundation
import CoreData
class MovieDatabaseHelper {
    static let shared = MovieDatabaseHelper()
    
    func getMovies() -> [MovieProtocol]? {
        let request = NSFetchRequest<Movie>(entityName: "Movie")
        do {
            let movies = try DatabaseHelper.shared.container.viewContext.fetch(request)
            return movies
        } catch {
            print("fetch failed!")
            return nil
        }
    }
    
    func createMovieDatabaseObject(_ object: MovieProtocol) -> Movie {
        let movie = Movie(context: DatabaseHelper.shared.container.viewContext)
        movie.adult = object.adult
        movie.title = object.title
        movie.id = Int32(object.id)
        movie.original_language = object.original_language
        movie.original_title = object.original_title
        movie.overview = object.overview
        movie.popularity = object.popularity
        movie.poster_path = object.poster_path
        movie.video = object.video
        movie.vote_count = object.vote_count
        movie.vote_average = object.vote_average
        movie.release_date = object.release_date
        return movie
    }
}
