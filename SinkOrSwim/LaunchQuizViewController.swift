//
//  LaunchQuizViewController.swift
//  SinkOrSwim
//
//  Created by Alex Gregory on 9/17/22.
//

import UIKit

class LaunchQuizViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var sliderQuestions: UISlider!
    @IBOutlet weak var hintsSwitch: UISwitch!
    @IBOutlet weak var sliderNoOfQuestions: UILabel!
    @IBOutlet weak var sliderStepper: UIStepper!
    @IBOutlet weak var startQuizButton: UIButton!
    @IBOutlet weak var languageSelection: UIPickerView!
    
    lazy var quizSettingsModel: QuizSettingsModel = {
        return QuizSettingsModel.sharedInstance();
    }()
    
    lazy private var imageModel:ImageModel = {
        return ImageModel.sharedInstance()
    }()
    
    var languageOptions = ["English", "Spanish", "French"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Default Max/Min for questions
        sliderQuestions.minimumValue = 1
        sliderQuestions.maximumValue = Float(self.imageModel.imageNameDict().count)
        sliderQuestions.isContinuous = false
        sliderStepper.minimumValue = Double(sliderQuestions.minimumValue)
        sliderStepper.maximumValue = Double(sliderQuestions.maximumValue)
        
        self.languageSelection.delegate = self
        self.languageSelection.dataSource = self
        
        sliderQuestions.setValue(3, animated: false)
        sliderNoOfQuestions.text = Int(sliderQuestions.value).description
        quizSettingsModel.setLanguage("English")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languageOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languageOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        quizSettingsModel.setLanguage(languageOptions[row])
    }
    
    @IBAction func stepperFunction(_ sender: UIStepper) {
        sliderQuestions.value = Float(sender.value)
        sliderNoOfQuestions.text = Int(sender.value).description
    }
    
    @IBAction func sliderFunction(_ sender: UISlider) {
        sliderQuestions.value = Float(round(sender.value))
        sliderNoOfQuestions.text = Int(sender.value).description
    }
    
    @IBAction func startQuizButtonFunction(_ sender: UIButton) {
        quizSettingsModel.setNoOfQuestions(Int(sliderQuestions.value))
        quizSettingsModel.setHintsYesOrNo(hintsSwitch.isOn)
    }
}
