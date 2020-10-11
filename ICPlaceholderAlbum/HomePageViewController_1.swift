//
//  HomePageViewController.swift
//  ICPlaceholderAlbum
//
//  Created by 胡仁恩 on 2019/9/23.
//  Copyright © 2019 alexHu. All rights reserved.
//

import UIKit

class HomePageViewController_1: UIViewController {
    
    private let requestApiButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Request Photo Api", for: .normal)
        button.addTarget(self, action: #selector(pushAlbumView(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeToFit()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(requestApiButton)
        requestApiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        requestApiButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc
    private
    func pushAlbumView(_ button: UIButton) {
        
        let albumViewController = AlbumViewController()
        navigationController?.pushViewController(albumViewController, animated: true)
    }
}
