//
//  QuizResultsViewController.swift
//  SinkOrSwim
//
//  Created by Alex Gregory on 9/17/22.
//

import UIKit

class QuizResultsViewController: UIViewController {

    @IBOutlet weak var correctGuesses: UILabel!
    @IBOutlet weak var incorrectGuesses: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = FileManager.default
        let currentPath = manager.currentDirectoryPath
        struct Correct: Codable {
            var correct: Int
            var incorrect: Int
        }
        //try! data.write(to: dataURL, options: [.completeFileProtection])
        // - Read
        let filepath = NSHomeDirectory()+"/myBin.bin"
        let currentPathURL = URL(fileURLWithPath: filepath)
        let readData = try! Data(contentsOf: currentPathURL)
        let correctGuessesText = try! JSONDecoder().decode(Correct.self, from: readData)
        // Do any additional setup after loading the view.
        
        correctGuesses.text = String(correctGuessesText.correct)
        incorrectGuesses.text = String(correctGuessesText.incorrect)
        
    }
    

}
