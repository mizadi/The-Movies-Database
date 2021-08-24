//
//  The_Movies_Database_NetworkTests.swift
//  The Movies Database NetworkTests
//
//  Created by Adi Mizrahi on 14/07/2021.
//

import XCTest
@testable import The_Movies_Database
class The_Movies_Database_NetworkTests: XCTestCase {
    
    override func setUpWithError() throws {
        print("starting test")
    }
    
    override func tearDownWithError() throws {
        print("teardown")
    }
    
    func testBuildBadURLRequest() throws {
        let badSchemeEndPoint = TheMoviesDBEndPointTests.badSchemeEndPoint

        XCTAssertNil(URLSession(configuration: .default).buildURLRequest(badSchemeEndPoint))
    }
    
    func testBuildGoodURLRequest() throws {
        let goodEndPoint = TheMoviesDBEndPointTests.goodEndPoint
        
        XCTAssertNotNil(URLSession(configuration: .default).buildURLRequest(goodEndPoint))
    }
    
    func testBadNetworkRequest() throws {
        NetworkSessionMockError().request(endpoint: TheMoviesDBEndPointTests.goodEndPoint) { (result: Result < MovieContainerMockup, Error > ) in
            switch result {
            case .success(let object):
                print(object)
               // XCTAssertNotNil(object)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            
        }
    }
    
    func testSuccessNetworkRequest() throws {
        NetworkSessionMockSuccess().request(endpoint: TheMoviesDBEndPointTests.goodEndPoint) { (result: Result < MovieContainerMockup, Error > ) in
            switch result {
            case .success(let object):
                XCTAssertNotNil(object)
               // XCTAssertNotNil(object)
            case .failure(let error):
               print(error)
            }
        }
    }
}

enum TheMoviesDBEndPointTests: Endpoint {
    case goodEndPoint
    case badSchemeEndPoint
    case badBaseURLEndPoint
    case badPathEndPoint
    case badMethodEndPoint
    var scheme: String {
        switch self {
        case .badSchemeEndPoint:
            return "g"
        case .badBaseURLEndPoint, .badPathEndPoint, .badMethodEndPoint, .goodEndPoint:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        case .badBaseURLEndPoint:
            return "."
        case .badSchemeEndPoint, .badPathEndPoint, .badMethodEndPoint, .goodEndPoint:
            return "api.themoviedb.org"
        }
    }
    
    var path: String? {
        switch self {
        case .badPathEndPoint:
            return nil
        case .badSchemeEndPoint, .badBaseURLEndPoint, .badMethodEndPoint, .goodEndPoint:
            return "/3/movie/popular/"
        }
    }
    
    var parameters: [URLQueryItem] {
        return []
    }
    
    var method: String {
        switch self {
        case .badMethodEndPoint:
            return "///"
        case .badSchemeEndPoint, .badBaseURLEndPoint, .badPathEndPoint, .goodEndPoint:
            return "GET"
        }
    }
}

class NetworkSessionMockError: NetworkSession {
    
    func request<T>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> ()) where T : Decodable, T : Encodable {
        //let result = Result.success(object)
        let error = Result<T, Error>.failure(NSError(domain: "Error", code: 404, userInfo: nil))
        completion(error)
    }
}

class NetworkSessionMockSuccess: NetworkSession {
    
    
    
    func request<T>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> ()) where T : Decodable, T : Encodable {
        //let result = Result.success(object)
        let response = MovieContainerMockup()
        let result = Result<T, Error>.success(response as! T)
        completion(result)
    }
}

class MovieContainerMockup: MovieContainerProtocol, Codable {
    var results: [MovieObject]?
    
    var page: Int = 1
    
    var total_pages: Int = 1
    
    var total_results: Int = 1 
    
}

class MovieMockup: MovieProtocol, Codable {
    var adult: Bool = false
    
    var id: Int32 = 0
    
    var original_language: String = ""
    
    var original_title: String = ""
    
    var overview: String = ""
    
    var popularity: Float = 0.0
    
    var poster_path: String?
    
    var release_date: String = ""
    
    var title: String = ""
    
    var video: Bool = false
    
    var vote_average: Float = 0.0
    
    var vote_count: Int32 = 0
    
    
}
