//
//  ViewController.swift
//  SinkOrSwim
//
//  Created by Ethan Olree on 9/6/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {

    lazy var imageModel: ImageModel = {
        return ImageModel.sharedInstance();
    }()
    
    lazy var answerKeyModel: AnswerKeyModel = {
        return AnswerKeyModel.sharedInstance();
    }();
    
    lazy var quizSettingsModel: QuizSettingsModel = {
        return QuizSettingsModel.sharedInstance();
    }()
    
    lazy private var imageView: UIImageView? = {
        return UIImageView.init(image: self.imageModel.getImageWithName(self.imageModel.getImageNames(forValue: activeId)[0] as! String))
    }()
    
    private var timer: Timer!
    
    var activeId: String!;
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var guessInput: UITextField!
    @IBOutlet weak var hintText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.guessInput.delegate = self
        
        if (self.quizSettingsModel.getHintsYesOrNo()) {
            self.hintText.text = self.answerKeyModel.getHintForKey(activeId, withLanguage: self.quizSettingsModel.getLanguage())
        } else {
            self.hintText.text = ""
        }
        
        if let size = self.imageView?.image?.size{
            self.scrollView.addSubview(self.imageView!)
            self.scrollView.contentSize = size
            self.scrollView.minimumZoomScale = 1.0
            self.scrollView.maximumZoomScale = 1.6
            self.scrollView.delegate = self
        }
        self.resizeImage()
        
        self.segmentedControl.removeAllSegments()

        for val in 0...self.imageModel.getImageNames(forValue: activeId).count - 1 {
            self.segmentedControl.insertSegment(withTitle: "Image " + String(val + 1), at: val, animated: true)
        }
        self.segmentedControl.selectedSegmentIndex = 0
        
        self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateSegmentedControl), userInfo: nil, repeats: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.guessInput.resignFirstResponder()
    }
                                    
    @objc func updateSegmentedControl() {
        self.segmentedControl.selectedSegmentIndex = (self.segmentedControl.selectedSegmentIndex + 1) % self.imageModel.getImageNames(forValue: activeId).count
        
        self.segmentedControlChange(self.segmentedControl)
    }

    @IBAction func segmentedControlChange(_ sender: UISegmentedControl) {
        self.imageView?.image = self.imageModel.getImageWithName(self.imageModel.getImageNames(forValue: activeId)[sender.selectedSegmentIndex] as! String)
        
        self.resizeImage()
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateSegmentedControl), userInfo: nil, repeats: false)
    }
    
    @IBAction func makeAGuess(_ sender: Any) {
        if let guess = self.guessInput.text,
           !guess.isEmpty {
            
            self.answerKeyModel.checkAnswer(activeId, withValue: guess)
        }
    }
    
    @IBAction func tapBackground(_ sender: Any) {
        self.guessInput.resignFirstResponder()
    }
    
    // source: https://stackoverflow.com/questions/41718520/nsnotificationcenter-swift-3-0-on-keyboard-show-and-hide
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }

    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    // MARK: Utility
    // source: https://stackoverflow.com/questions/31314412/how-to-resize-image-in-swift
    func resizeImage() {
        let targetSize = CGSize(width: 2000, height: 2000)
        self.scrollView.setZoomScale(1.0, animated: false)
        
        if let size = self.imageView?.image?.size{
                
            let widthRatio  = targetSize.width  / size.width
            let heightRatio = targetSize.height / size.height
            
            var newSize: CGSize
            if(widthRatio > heightRatio) {
                newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
            } else {
                newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
            }
            
            let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
            
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            self.imageView?.image?.draw(in: rect)
            self.imageView?.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            self.scrollView.contentSize = newSize
            self.imageView?.sizeToFit()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let viewController = segue.destination as? QuizResultsViewController,
           let name = self.activeId {
                viewController.activeId = name
            }
    }
}

