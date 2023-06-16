//
//  Result.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 16.06.2023.
//

import Foundation

// MARK: - Structs for Decoding

struct PhotoResult: Codable {
    let id: String
    let createdAt: String
    let width, height: Int
    let likes: Int
    let likedByUser: Bool
    let description: String?
    let urls: UrlsResult
    
    struct UrlsResult: Codable {
        let raw, full, regular, small: String
        let thumb: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width, height
        case likes
        case likedByUser = "liked_by_user"
        case description
        case urls
    }
}
