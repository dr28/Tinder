//
//  ProfileViewController.swift
//  Tinder
//
//  Created by Deepthy on 10/11/17.
//  Copyright © 2017 Deepthy. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.image = image
        
    }
    
    @IBAction func onTap(_ sender: Any) {
        self.dismiss(animated: true) { }
    }
}
