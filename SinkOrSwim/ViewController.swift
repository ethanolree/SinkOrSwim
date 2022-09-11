//
//  ViewController.swift
//  SinkOrSwim
//
//  Created by Ethan Olree on 9/6/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController, UIScrollViewDelegate {

    lazy var imageModel: ImageModel = {
        return ImageModel.sharedInstance();
    }()
    
    lazy private var imageView: UIImageView? = {
        return UIImageView.init(image: self.imageModel.getImageWithName(self.imageModel.getImageNames(forValue: activeId)[0] as! String))
    }()
    
    private var timer: Timer!
    
    var activeId: String!;
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let size = self.imageView?.image?.size{
            self.scrollView.addSubview(self.imageView!)
            self.scrollView.contentSize = size
            self.scrollView.minimumZoomScale = 0.5
            self.scrollView.delegate = self
        }
        
        self.segmentedControl.removeAllSegments()

        for val in 0...self.imageModel.getImageNames(forValue: activeId).count - 1 {
            self.segmentedControl.insertSegment(withTitle: "Image " + String(val + 1), at: val, animated: true)
        }
        self.segmentedControl.selectedSegmentIndex = 0
        
        self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateSegmentedControl), userInfo: nil, repeats: false)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
                                    
    @objc func updateSegmentedControl() {
        self.segmentedControl.selectedSegmentIndex = (self.segmentedControl.selectedSegmentIndex + 1) % self.imageModel.getImageNames(forValue: activeId).count
        
        self.segmentedControlChange(self.segmentedControl)
    }

    @IBAction func segmentedControlChange(_ sender: UISegmentedControl) {
        self.imageView?.image = self.imageModel.getImageWithName(self.imageModel.getImageNames(forValue: activeId)[sender.selectedSegmentIndex] as! String)
        self.timer.invalidate();
        self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateSegmentedControl), userInfo: nil, repeats: false)
        
        if let size = self.imageView?.image?.size{
            self.scrollView.addSubview(self.imageView!)
            self.scrollView.contentSize = size
            self.imageView?.sizeToFit()
            self.scrollView.minimumZoomScale = 0.5
            self.scrollView.delegate = self
        }
    }
    
}

