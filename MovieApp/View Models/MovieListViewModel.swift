//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Nic Deane on 30/12/2021.
//

import Foundation
import CoreData

class MovieListViewModel: ObservableObject {
  
  @Published var movies = [MovieViewModel]()
  
  func deleteMovie(movie: MovieViewModel) {
    let movie = CoreDataManager.shared.getMovieByID(id: movie.id)
    if let movie = movie {
      CoreDataManager.shared.deleteMovie(movie)
    }
  }
  
  
  
  func getAllMovies() {
    let movies = CoreDataManager.shared.getAllMovies()
    DispatchQueue.main.async {
      self.movies = movies.map(MovieViewModel.init)
    }
  }
  
}

struct MovieViewModel {
  
  let movie: Movie
  
  var id: NSManagedObjectID {
    return movie.objectID
  }
  
  var title: String {
    return movie.title ?? "Unknown"
  }
  
  var director: String {
    return movie.director ?? "Unknown"
  }
  
  var releaseDate: String? {
    return movie.releaseDate?.asFormattedString()
  }
  
  var rating: Int? {
    return Int(movie.rating)
  }
  
}
