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
    
    var answerKeyModel = AnswerKeyModel();
    
    lazy private var imageView: UIImageView? = {
        return UIImageView.init(image: self.imageModel.getImageWithName(self.imageModel.getImageNames(forValue: activeId)[0] as! String))
    }()
    
    private var timer: Timer!
    
    var activeId: String!;
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var guessInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.guessInput.delegate = self
        
        if let size = self.imageView?.image?.size{
            self.scrollView.addSubview(self.imageView!)
            self.scrollView.contentSize = size
            self.scrollView.minimumZoomScale = 1.0
            self.scrollView.maximumZoomScale = 1.6
            self.scrollView.delegate = self
        }
        
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
        self.timer.invalidate();
        self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateSegmentedControl), userInfo: nil, repeats: false)
        
        if let size = self.imageView?.image?.size{
            self.scrollView.contentSize = size
        }
    }
    
    @IBAction func makeAGuess(_ sender: Any) {
        if let guess = self.guessInput.text,
           !guess.isEmpty {
            
            let answer = self.answerKeyModel.checkAnswer(activeId, withValue: guess)
            
            let manager = FileManager.default
            let currentPath = manager.currentDirectoryPath
            struct Correct: Codable {
                var correct: Int
                var incorrect: Int
            }
            
            let filepath = NSHomeDirectory()+"/myBin.bin"
            
            let currentPathURL = URL(fileURLWithPath: filepath)
            var correctAnswers = Correct(correct: 0, incorrect: 0)
            
            if manager.fileExists(atPath: filepath){
                let readData = try! Data(contentsOf: currentPathURL)
                let correctGuessesText = try! JSONDecoder().decode(Correct.self, from: readData)
            
                if answer {
                    correctAnswers = Correct(correct: correctGuessesText.correct+1, incorrect: correctGuessesText.incorrect)
                } else {
                    correctAnswers = Correct(correct: correctGuessesText.correct, incorrect: correctGuessesText.incorrect+1)
                }
            }
            
            try! manager.removeItem(atPath: filepath)
            let data2 = try! JSONEncoder().encode(correctAnswers)
            try! data2.write(to: currentPathURL)
            manager.createFile(atPath: filepath, contents: data2)
            
        }
    }
    
    @IBAction func presentSecondViewController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondVC = storyboard.instantiateViewController(identifier: "ResultsHistoryViewController")
            
            secondVC.modalPresentationStyle = .fullScreen
            secondVC.modalTransitionStyle = .crossDissolve
            
            present(secondVC, animated: true, completion: nil)
        }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }

    }
    
    @IBAction func tapBackground(_ sender: Any) {
        self.guessInput.resignFirstResponder()
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}

