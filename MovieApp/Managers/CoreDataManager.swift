//
//  CoreDataManager.swift
//  MovieApp
//
//  Created by Mohammad Azam on 2/23/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
  let persistentContainer: NSPersistentContainer
  
  static let shared = CoreDataManager()
  
  private init() {
    persistentContainer = NSPersistentContainer(name: "MovieAppModel")
    persistentContainer.loadPersistentStores { (description, error) in
      if let error = error {
        fatalError("Failed to initialize CoreData: \(error)")
      }
    }
  }
  
  func getMovieByID(id: NSManagedObjectID) -> Movie? {
    do {
      return try persistentContainer.viewContext.existingObject(with: id) as? Movie
    } catch {
      print(error)
      return nil
    }
  }
  
  func deleteMovie(_ movie: Movie) {
    persistentContainer.viewContext.delete(movie)
    do {
      try persistentContainer.viewContext.save()
    } catch {
      print("Failed to delete movie: \(error)")
      persistentContainer.viewContext.rollback()
    }
  }
  
  func getAllMovies() -> [Movie] {
    let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
    do {
      return try persistentContainer.viewContext.fetch(fetchRequest)
    } catch {
      print("Failed to fetch movies: \(error)")
      return []
    }
  }
  
  func save() {
    do {
      try persistentContainer.viewContext.save()
    } catch {
      print("Failed to save a movie: \(error)")
    }
  }
  
}
