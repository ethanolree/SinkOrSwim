//
//  CollectionViewController.swift
//  SinkOrSwim
//
//  Created by Ethan Olree on 9/18/22.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    lazy private var imageModel:ImageModel = {
        return ImageModel.sharedInstance()
    }()
    
    lazy var quizSettingsModel: QuizSettingsModel = {
        return QuizSettingsModel.sharedInstance();
    }()
    
    lazy var answerKeyModel: AnswerKeyModel = {
        return AnswerKeyModel.sharedInstance();
    }();

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.quizSettingsModel.getNoOfQuestions()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var dynamicCellId = "PlayCell"
        let id = "Movie " + String(indexPath.row + 1)
        
        if self.answerKeyModel.getCorrectGuessCount(id) > 0 {
            dynamicCellId = "CorrectCell"
        } else if self.answerKeyModel.getIncorrectGuessCount(id) > 0 {
            dynamicCellId = "IncorrectCell"
        }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dynamicCellId, for: indexPath) as? CollectionViewCell {
            cell.title.text = "Movie " + String(indexPath.row + 1)
            
            if dynamicCellId == "CorrectCell" {
                cell.detail.text = self.answerKeyModel.getCorrectAnswer(id)
            }
            
            return cell
        } else {
            fatalError("Could not dequeue cell")
        }
    }

    // MARK: UICollectionViewDelegate
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let viewController = segue.destination as? ViewController,
           let cell = sender as? CollectionViewCell,
           let name = cell.title.text {
                viewController.activeId = name
            }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
        super.viewWillAppear(animated)
    }

}
