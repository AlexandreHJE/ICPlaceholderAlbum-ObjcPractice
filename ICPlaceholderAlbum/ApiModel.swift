//
//  ApiModel.swift
//  ICPlaceholderAlbum
//
//  Created by 胡仁恩 on 2019/9/23.
//  Copyright © 2019 alexHu. All rights reserved.
//

import Foundation

struct PhotoContent: Codable {
    
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
    
    enum TypeOfImage {
        case thumbnail
        case originalImage
    }
    
    func transfromUrlString(with type: TypeOfImage) -> URL? {
        let urlString: String
        
        switch type {
        case .thumbnail:
            urlString = thumbnailUrl
        case .originalImage:
            urlString = url
        }
        
        guard let url: URL = URL(string: urlString) else { return nil }
        return url
    }
}

extension PhotoContent {
    
    func toICPPhotoContent() -> ICPPhotoContent {
        return ICPPhotoContent(albumID: albumId, id: id, title: title, url: url, thumbnailUrl: thumbnailUrl)
    }
}

@objcMembers
class ICPPhotoContent: NSObject {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
    
    init(albumID: Int, id: Int, title: String, url: String, thumbnailUrl: String) {
        self.albumId = albumID
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
}
