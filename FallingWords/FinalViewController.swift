//
//  FinalViewController.swift
//  FallingWords
//
//  Created by Nataly Tatarintseva on 10/20/18.
//  Copyright © 2018 Nataly Tatarintseva. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func playAgain(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToGameScreen", sender: self)
    }
    
    var amountOfWords: Int?
    var correctAnswers: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let answers = correctAnswers, let words = amountOfWords {
            resultLabel.text = "Result\n\(String(answers)) / \(String(words))"
        }
    }
    
}
