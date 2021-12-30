//
//  AddMovieViewModel.swift
//  MovieApp
//
//  Created by Nic Deane on 30/12/2021.
//

import Foundation

class AddMovieViewModel: ObservableObject {
  
  @Published var title: String = ""
  @Published var director: String = ""
  @Published var rating: Int? = nil
  @Published var releaseDate: Date = Date()
  
  func save() {
    let manager = CoreDataManager.shared
    let movie = Movie(context: manager.persistentContainer.viewContext)
    movie.title = title
    movie.director = director
    movie.rating = Double(rating ?? 0)
    movie.releaseDate = releaseDate
    
    manager.save()
  }
  
}
