//
//  SearchPresenter.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 13/07/2021.
//

import Foundation
class SearchPresenter {
    func searchMovie(page: String = "1",query: String, completion: @escaping (_ movies: [MovieProtocol]?, _ error: Error?) -> Void) {
        NetworkEngine().request(endpoint: TheMoviesDBEndPoint.searchMovie(query: query,page: page)) { (result: Result < MoviesContainer, Error > ) in
            switch result {
            case.success(let response):
                completion(response.results, nil)
            case.failure(let error):
                completion(nil, error)
            }
        }
    }
}
