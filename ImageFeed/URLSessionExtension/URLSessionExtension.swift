//
//  URLSessionExtension.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 02.06.2023.
//

import UIKit

extension UIColor {
    static let  ypBlack = UIColor(named: "YP Black")
    static let  ypGrey = UIColor(named: "YP Grey")
    static let  ypRed =  UIColor(named: "YP Red")
    static let  ypBackground = UIColor(named: "YP Background")
    static let  ypWhite = UIColor(named: "YP White")
}

extension URLSession {
    
    func objectTask<T: Decodable>(for request: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
    -> URLSessionTask {
        
        let fulfillCompletion: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let task = dataTask(with: request) { data, response, error in
            if let data = data,
               let response = response,
               let statusCode = (response as? HTTPURLResponse)?.statusCode {
                
                if 200 ..< 300 ~= statusCode {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(T.self, from: data)
                        fulfillCompletion(.success(result))
                    } catch {
                        fulfillCompletion(.failure(NetworkError.urlRequestError(error)))
                    }
                } else {
                    fulfillCompletion(.failure(NetworkError.httpStatusCode(statusCode)))
                }
            } else if let error = error {
                fulfillCompletion(.failure(NetworkError.urlRequestError(error)))
            } else {
                fulfillCompletion(.failure(NetworkError.urlSessionError))
            }
        }
        return task
    }
}

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
}
