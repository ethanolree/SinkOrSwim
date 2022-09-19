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
    
    lazy var answerKeyModel: AnswerKeyModel = {
        return AnswerKeyModel.sharedInstance();
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        correctGuesses.text = String(self.answerKeyModel.getTotalCorrectGuessCount())
        incorrectGuesses.text = String(self.answerKeyModel.getTotalIncorrectGuessCount())
        
    }

    @IBAction func resetScore(_ sender: Any) {
        
        self.answerKeyModel.resetAnswers()
            
        correctGuesses.text = String(self.answerKeyModel.getTotalCorrectGuessCount())
        incorrectGuesses.text = String(self.answerKeyModel.getTotalIncorrectGuessCount())
        
    }
    
}
