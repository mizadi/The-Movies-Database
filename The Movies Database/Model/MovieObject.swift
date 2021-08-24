//
//  Movie.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 11/07/2021.
//

import Foundation

protocol MovieProtocol: AnyObject {
    var adult: Bool {get}
    var id: Int32 {get}
    var original_language: String {get}
    var original_title: String {get}
    var overview: String {get}
    var popularity: Float {get}
    var poster_path: String? {get}
    var release_date: String {get}
    var title: String {get}
    var video: Bool {get}
    var vote_average: Float {get}
    var vote_count: Int32 {get}
}

class MovieObject: MovieProtocol, Codable {
    let adult: Bool
    let id: Int32
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Float
    let poster_path: String?
    let release_date: String
    let title: String
    let video: Bool
    let vote_average: Float
    let vote_count: Int32
}
