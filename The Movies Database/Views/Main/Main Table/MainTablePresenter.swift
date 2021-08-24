//
//  MainPresenter.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 11/07/2021.
//

import Foundation

protocol MainTablePresenterDelegate {
    func finishedPullingMovies(_ movies: MoviesContainer)
    func failedToPullMovies()
}

class MainTablePresenter {
    let delegate: MainTablePresenterDelegate
    
    init(delegate: MainTablePresenterDelegate) {
        self.delegate = delegate
    }
    
    func pullMovies(_ page: String = "1") {
        NetworkEngine().request(endpoint: TheMoviesDBEndPoint.pullPopularMovies(page: page))  { [weak self]
            (result: Result < MoviesContainer, Error > ) in
            guard let self = self else {
                return
            }
            switch result {
            case.success(let response):
                self.saveLocaldatbase(response.results)
                self.delegate.finishedPullingMovies(response)
            //completion(result.frontDefault)
            case.failure(_):
                self.delegate.failedToPullMovies()
            }
        }
    }
    
    func saveLocaldatbase(_ movies: [MovieProtocol]?) {
        guard let movies = movies else {
            return
        }
        LocalDataHelper.shared.saveLocalDataMovie(movies)
        
    }
    
    func shouldLoadLocalData() -> [MovieProtocol]? {
        guard let localDataId = UserDefaultsHelper.shared.getString(prefsKeys.localDatabaseId) else {
            return nil
        }
        guard let data = LocalDataHelper.shared.getLocalDataById(id: localDataId) else {
            return nil 
        }
        guard let movies = data.movies else {
            return nil
            
        }
        return Array(movies)
    }
}
