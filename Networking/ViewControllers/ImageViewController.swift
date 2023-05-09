//
//  ImageViewController.swift
//  Networking
//
//  Created by Vsevolod Lashin on 05.05.2023.
//

import UIKit

final class ImageViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }

    private func fetchImage() {
        networkManager.fetchImage(from: Link.imageURL.url) { [weak self] imageData in
            self?.imageView.image = UIImage(data: imageData)
            self?.activityIndicator.stopAnimating()
        }
    }
}
