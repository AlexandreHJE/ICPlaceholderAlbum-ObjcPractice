//
//  Cell.swift
//  ICPlaceholderAlbum
//
//  Created by Alex Hu on 2020/8/5.
//  Copyright © 2020 alexHu. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {

    lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.numberOfLines = 0
        
        
        return label
    }()
    
    let loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var task: URLSessionTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(image)
        contentView.addSubview(idLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(loadingIndicator)
        
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            idLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height/4),
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            idLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            idLabel.heightAnchor.constraint(equalToConstant: 20.0),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: contentView.frame.height/5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20.0),
            loadingIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage(with url: URL) {
        loadingIndicator.startAnimating()
        image.image = nil
        if let task: URLSessionTask = task {
            task.cancel()
        }
        task = nil
        task = DataManager.shared.fetchImage(with: url) { [weak self] (data, response, error) in
            guard let `self` = self, let data: Data = data else {
                return
            }
            let image: UIImage? = UIImage(data: data)
            DispatchQueue.main.async {
                self.image.image = image
                self.loadingIndicator.stopAnimating()
            }
        }
        task?.resume()
    }
    
}
