//
//  ViewController.swift
//  SinkOrSwim
//
//  Created by Ethan Olree on 9/6/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.ImageView.image = UIImage.init(named: "breakfastClub")
    }


}

