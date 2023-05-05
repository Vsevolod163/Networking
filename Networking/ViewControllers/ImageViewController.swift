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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }

    
    
}
