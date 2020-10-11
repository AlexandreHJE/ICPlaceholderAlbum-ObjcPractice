//
//  DataManager.swift
//  ICPlaceholderAlbum
//
//  Created by 胡仁恩 on 2019/9/23.
//  Copyright © 2019 alexHu. All rights reserved.
//

import Foundation

@objc
class DataManager: NSObject {
    let apiUrlString = "https://jsonplaceholder.typicode.com/photos"
    
    @objc
    static let shared  = DataManager()
}

enum DataError: Error {
    case notFound
}

extension DataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFound:
            return "Http(Page) Not Found. code 404."
        }
    }
}

extension DataManager {
    
    func getAlbumJSON(_ completion: @escaping (Result<[PhotoContent], Error>) -> Void) {
        guard let url: URL = URL(string: apiUrlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (jsonData, response, error) in
            ////TODO: 1.檢查error有沒有值 2.檢查Response的status 3.檢查JSON Data
            if let response = response as? HTTPURLResponse, response.statusCode == 404 {
                completion(.failure(DataError.notFound))
                return
            }
            if let jsonData = jsonData {
                do {
                    let decoder = JSONDecoder()
                    let apiResponse = try decoder.decode([PhotoContent].self, from: jsonData)
                    completion(.success(apiResponse))
                    return
                } catch let parseError {
                    completion(.failure(parseError))
                    return
                }
            } else if let error = error {
                completion(.failure(error))
                return
            }
        }
        task.resume()
    }
    
    @objc
    func getAlbumJSON(success: @escaping ([ICPPhotoContent]) -> Void, failure: @escaping (Error) -> Void) {
        getAlbumJSON { (result) in
            switch result {
            case .success(let contents):
                success(contents.map{ $0.toICPPhotoContent() })
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func fetchImage(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTask {
        
        let session: URLSession = URLSession(configuration: .default)
        return session.dataTask(with: url, completionHandler: completionHandler)
    }
}

