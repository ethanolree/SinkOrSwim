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
    
    var activeId: String!;
    
    lazy var answerKeyModel: AnswerKeyModel = {
        return AnswerKeyModel.sharedInstance();
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        correctGuesses.text = String(self.answerKeyModel.getCorrectGuessCount(self.activeId))
        incorrectGuesses.text = String(self.answerKeyModel.getIncorrectGuessCount(self.activeId))
    }
    

}
