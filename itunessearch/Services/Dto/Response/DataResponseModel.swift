//
//  DataResponseModel.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/11/22.
//

import Foundation

// MARK: - DataResponseModel
struct DataResponseModel: Codable {
    var resultCount: Int?
    var results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    var wrapperType: String?
    var artistName, collectionName: String?
    var artworkUrl100: String?
    var collectionPrice: Double?
    var country: String?
    var kind: String?
    var trackName: String?
    var releaseDate: String?
    var shortDescription: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType
        case artistName, collectionName
        case artworkUrl100
        case collectionPrice
        case country
        case kind
        case trackName
        case releaseDate
        case shortDescription
    }
}
