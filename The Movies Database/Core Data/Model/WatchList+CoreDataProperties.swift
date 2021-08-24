//
//  WatchList+CoreDataProperties.swift
//  
//
//  Created by Adi Mizrahi on 12/07/2021.
//
//

import Foundation
import CoreData


extension WatchList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchList> {
        return NSFetchRequest<WatchList>(entityName: "WatchList")
    }

    @NSManaged public var movies: Set<Movie>
    @NSManaged public var id: String
    @NSManaged public var name: String
}

// MARK: Generated accessors for movies
extension WatchList {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}
