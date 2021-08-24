//
//  MoviesContainer.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 11/07/2021.
//

import Foundation

protocol MovieContainerProtocol {
    var results: [MovieObject]? { get }
    var page: Int { get }
    var total_pages: Int { get }
    var total_results: Int { get }
}

class MoviesContainer: MovieContainerProtocol, Codable {
    var results: [MovieObject]?
    
    var page: Int
    
    var total_pages: Int
    
    var total_results: Int
    
    
}
