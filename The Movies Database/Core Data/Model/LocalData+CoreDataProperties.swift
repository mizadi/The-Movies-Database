//
//  LocalData+CoreDataProperties.swift
//  
//
//  Created by Adi Mizrahi on 12/07/2021.
//
//

import Foundation
import CoreData


extension LocalData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalData> {
        return NSFetchRequest<LocalData>(entityName: "LocalData")
    }

    @NSManaged public var movies: Set<Movie>?
    @NSManaged public var id: String

}

// MARK: Generated accessors for movies
extension LocalData {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}
