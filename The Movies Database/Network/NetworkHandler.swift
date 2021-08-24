//
//  NetworkHandler.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 11/07/2021.
//

import Foundation

struct Constants {
    static let apiKey = "40ab4b29399a2e3f961acf68acc457e8"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500/"
    static let youtubeSearch = "https://www.youtube.com/results?search_query="
}

protocol Endpoint {
    /// HTTP or HTTPS
    var scheme: String {
        get
    }
    // Example: "api.flickr.com"
    var baseURL: String {
        get
    }
    // "/services/rest/"
    var path: String? {
        get
    }
    // [URLQueryItem(name: "api_key", value: API_KEY)]
    var parameters: [URLQueryItem] {
        get
    }
    // "GET"
    var method: String {
        get
    }
}

enum TheMoviesDBEndPoint: Endpoint {
    case pullPopularMovies(page: String)
    case searchMovie(query: String, page: String? = "1")
    var scheme: String {
        switch self {
        default: return "https"
        }
    }
    var baseURL: String {
        switch self {
        default: return "api.themoviedb.org"
        }
    }
    var path: String? {
        switch self {
        case.pullPopularMovies:
            return "/3/movie/popular"
        case.searchMovie:
            return "/3/search/movie"
        }
    }
    var parameters: [URLQueryItem] {
        switch self {
        case.pullPopularMovies(let page):
            var queriesArray = [URLQueryItem(name: "page", value: page),
                                URLQueryItem(name: "api_key", value: Constants.apiKey),
                                //URLQueryItem(name: "language", value: language)
            ]
            if let country = CountryHelper.getDeviceCountry() {
                queriesArray.append(URLQueryItem(name: "region", value: country))
            }
            return queriesArray
        case.searchMovie(let query, let page):
            return [URLQueryItem(name: "page", value: page),
                    URLQueryItem(name: "api_key", value: Constants.apiKey),
                    URLQueryItem(name: "query", value: query)]
        }
    }
    var method: String {
        switch self {
        case.pullPopularMovies:
            return "GET"
        case.searchMovie:
            return "GET"
        }
    }
}
