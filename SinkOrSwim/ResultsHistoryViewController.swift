//
//  ResultsHistoryViewController.swift
//  SinkOrSwim
//
//  Created by Alex Gregory on 9/15/22.
//

import UIKit

class ResultsHistoryViewController: UIViewController {
    @IBOutlet weak var correctGuesses: UILabel!
    @IBOutlet weak var incorrectGuesses: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        let manager = FileManager.default
        struct Correct: Codable {
            var correct: Int
            var incorrect: Int
        }
        let filepath = NSHomeDirectory()+"/myBin.bin"
        
        if !manager.fileExists(atPath: filepath){
            var correctAnswers = Correct(correct: 0, incorrect: 0)
            let data = try! JSONEncoder().encode(correctAnswers)
            manager.createFile(atPath: filepath, contents: data)
        }
        let currentPathURL = URL(fileURLWithPath: filepath)
        let readData = try! Data(contentsOf: currentPathURL)
        let correctGuessesText = try! JSONDecoder().decode(Correct.self, from: readData)
        
        correctGuesses.text = String(correctGuessesText.correct)
        incorrectGuesses.text = String(correctGuessesText.incorrect)
        
    }

    @IBAction func resetScore(_ sender: Any) {
        
            let manager = FileManager.default
            struct Correct: Codable {
                var correct: Int
                var incorrect: Int
            }
            
            let filepath = NSHomeDirectory()+"/myBin.bin"
            
            let currentPathURL = URL(fileURLWithPath: filepath)
            var correctAnswers = Correct(correct: 0, incorrect: 0)
            
            try! manager.removeItem(atPath: filepath)
            let data = try! JSONEncoder().encode(correctAnswers)
            try! data.write(to: currentPathURL)
            manager.createFile(atPath: filepath, contents: data)
        let readData = try! Data(contentsOf: currentPathURL)
        let correctGuessesText = try! JSONDecoder().decode(Correct.self, from: readData)
            
        correctGuesses.text = String(correctGuessesText.correct)
        incorrectGuesses.text = String(correctGuessesText.incorrect)
        
    }
    
}
