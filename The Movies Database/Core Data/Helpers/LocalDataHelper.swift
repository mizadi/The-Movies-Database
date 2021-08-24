//
//  LocalDataHelper.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 15/07/2021.
//

import Foundation
import CoreData
class LocalDataHelper {
    static var shared = LocalDataHelper()
    
    func getLocalDataById(id: String) -> LocalData? {
        let request = NSFetchRequest<LocalData>(entityName: "LocalData")
        let predict: NSPredicate = NSPredicate(format: "id == %@", id)
        request.predicate = predict
        do {
            let localData = try DatabaseHelper.shared.container.viewContext.fetch(request)
            if !localData.isEmpty {
                return localData[0]
            }
            return nil
        } catch {
            print("fetch failed!")
            return nil
        }
    }
    
    func getLocalData() -> LocalData? {
        let request = NSFetchRequest<LocalData>(entityName: "LocalData")
        do {
            let localData = try DatabaseHelper.shared.container.viewContext.fetch(request)
            if !localData.isEmpty {
                return localData[0]
            }
            return nil
        } catch {
            print("fetch failed!")
            return nil
        }
    }
    
    func checkIfLocalDataExists() -> LocalData {
        if let localDataId = UserDefaultsHelper.shared.getString(prefsKeys.localDatabaseId) {
            if let localData = getLocalDataById(id: localDataId) {
                return localData
            }
        }
        return createNewLocalDataObject()
    }
    
    func createNewLocalDataObject() -> LocalData {
        let localData = LocalData(context: DatabaseHelper.shared.container.viewContext)
        localData.id = UUID().uuidString
        UserDefaultsHelper.shared.setString(forKey: prefsKeys.localDatabaseId, value: localData.id)
        return localData
    }
    
    func saveLocalDataMovie(_ movies: [MovieProtocol]) {
        let localData = checkIfLocalDataExists()
        for object in movies {
            let movie = MovieDatabaseHelper.shared.createMovieDatabaseObject(object)
            localData.addToMovies(movie)
        }
        DatabaseHelper.shared.saveContext()
    }
    
}
