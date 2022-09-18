//
//  TableViewController.swift
//  SinkOrSwim
//
//  Created by Ethan Olree on 9/11/22.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    lazy private var imageModel:ImageModel = {
        return ImageModel.sharedInstance()
    }()
    
    lazy var quizSettingsModel: QuizSettingsModel = {
        return QuizSettingsModel.sharedInstance();
    }()

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.quizSettingsModel.getNoOfQuestions()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var dynamicCellId = "MovieIdCell"
        
        if indexPath.row == 1 {
            dynamicCellId = "IncorrectCell"
        }
        
        if indexPath.row == 2 {
            dynamicCellId = "CorrectCell"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: dynamicCellId, for: indexPath)

        cell.textLabel!.text = "Movie " + String(indexPath.row + 1)

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let viewController = segue.destination as? ViewController,
           let cell = sender as? UITableViewCell,
           let name = cell.textLabel?.text {
                viewController.activeId = name
            }
    }

}
