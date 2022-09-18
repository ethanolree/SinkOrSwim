//
//  LaunchQuizViewController.swift
//  SinkOrSwim
//
//  Created by Alex Gregory on 9/17/22.
//

import UIKit

class LaunchQuizViewController: UIViewController {
    
    @IBOutlet weak var sliderQuestions: UISlider!
    @IBOutlet weak var hintsSwitch: UISwitch!
    @IBOutlet weak var sliderNoOfQuestions: UILabel!
    @IBOutlet weak var sliderStepper: UIStepper!
    @IBOutlet weak var startQuizButton: UIButton!
    
    lazy var quizSettingsModel: QuizSettingsModel = {
        return QuizSettingsModel.sharedInstance();
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Default Max/Min for questions
        sliderQuestions.minimumValue = 1
        sliderQuestions.maximumValue = 10
        sliderQuestions.isContinuous = false
        sliderStepper.minimumValue = Double(sliderQuestions.minimumValue)
        sliderStepper.maximumValue = Double(sliderQuestions.maximumValue)
        
        sliderQuestions.setValue(sliderQuestions.minimumValue, animated: false)
        sliderNoOfQuestions.text = Int(sliderQuestions.value).description
        
    }
    
    @IBAction func stepperFunction(_ sender: UIStepper) {
        sliderQuestions.value = Float(sender.value)
        sliderNoOfQuestions.text = Int(sender.value).description
    }
    
    @IBAction func sliderFunction(_ sender: UISlider) {
        sliderNoOfQuestions.text = Int(sender.value).description
    }
    
    @IBAction func startQuizButtonFunction(_ sender: UIButton) {
        quizSettingsModel.setNoOfQuestions(Int(sliderQuestions.value))
        quizSettingsModel.setHintsYesOrNo(hintsSwitch.isOn)
        
    }
}
