//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 13.06.2023.
//

import UIKit


final class ImagesListService {
    
    var photos: [Photo] = []
    private var lastLoadedPage: Int?
    static let DidChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    static let shared = ImagesListService()
    private init() {}
    private let dateFormatter = ISO8601DateFormatter()
    private let oAuth2TokenStorage = OAuth2TokenStorage.shared
    
    func preparePhoto(_ photoResult: [PhotoResult]) {
        let newPhotos = photoResult.map { item in
            return Photo(id: item.id, size: CGSize(width: item.width, height: item.height), createdAt: dateFormatter.date(from: item.createdAt), welcomeDescription: item.description, thumbImageURL: item.urls.thumb, fullImageURL: item.urls.full, isLiked: item.likedByUser)
        }
        self.photos.append(contentsOf: newPhotos)
        print("Number of photos being appended - \(photoResult.count)")
        print("Number of photos in array - \(photos.count)")
    }
    
    // MARK: - Load next 10 images
    
    func fetchPhotosNextPage(){
        assert(Thread.isMainThread)
        if task != nil {return}
        
        let nextPage = lastLoadedPage == nil ? 0 : lastLoadedPage! + 1
        lastLoadedPage = nextPage
        
        let request = makeRequest(path: "/photos?page=\(nextPage)&&per_page=5")
        let task = urlSession.objectTask(for: request) {[weak self] (result: Result<[PhotoResult], Error>) in
            guard let self = self else {return}
            switch result {
            case .success(let photoResult):
                self.preparePhoto(photoResult)
                NotificationCenter.default.post(name: ImagesListService.DidChangeNotification, object: self, userInfo: ["photos" : self.photos] )
                self.task = nil
            case .failure(let error):
                self.task = nil
                print(error)
            }
        }
        self.task = task
        task.resume()
    }
    
    // MARK: - Likes
    
    func changeLikes(photoID: String, isLike: Bool, _ completion: @escaping(Result<Void, Error>) -> Void){
        
        guard let token = oAuth2TokenStorage.token  else {fatalError("Failed to create Token")}
        let method = isLike ?  "DELETE" : "POST"
        var request = URLRequest.makeHTTPRequest(
            path: "/photos/\(photoID)/like",
            httpMethod: method,
            baseURL: DefaultBaseURL)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<Liked, Error>)in
            guard let self = self else {return}
            switch result {
            case .success(_):
                if let index = self.photos.firstIndex(where: {$0.id == photoID}) {
                    let photo = self.photos[index]
                    let newPhoto = Photo(id: photo.id, size: photo.size, createdAt: photo.createdAt, welcomeDescription: photo.welcomeDescription, thumbImageURL: photo.thumbImageURL, fullImageURL: photo.fullImageURL, isLiked: !photo.isLiked)
                    self.photos[index] = newPhoto
                }
                completion (.success(()))
            case .failure(let error):
                completion (.failure(error))
            }
        }
        task.resume()
    }
    
    
    private func makeRequest(path: String) -> URLRequest {
        
        guard let url = URL(string: path, relativeTo: DefaultBaseURL) else {fatalError("Failed to create URL for ImagesList")}
        guard let token = oAuth2TokenStorage.token else {fatalError("Failed to create Token")}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}

