//
//  Result.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 16.06.2023.
//

import Foundation

// MARK: - Structs for Updating UI

struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let fullImageURL: String
    let isLiked: Bool
}

struct Liked: Codable {
    let photo: PhotoResult
}
