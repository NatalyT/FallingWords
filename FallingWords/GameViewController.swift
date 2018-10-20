//
//  GameViewController.swift
//  FallingWords
//
//  Created by Nataly Tatarintseva on 10/20/18.
//  Copyright © 2018 Nataly Tatarintseva. All rights reserved.
//

import UIKit

struct WordToShow {
    var wordInLanguageOne: String
    var wordInLanguageTwo: String
    var wordToDisplay: String
}

class GameViewController: UIViewController {
    
    @IBOutlet weak var labelOne: UILabel!
    
    @IBAction func tapWrongButton(_ sender: Any) {
        if let w = self.wordToShow {
            if !self.isCorrectAnswer(word: w) {
                self.correctAnswers += 1
            }
        }
    }
    
    @IBAction func tapCorrectButton(_ sender: Any) {
        if let w = self.wordToShow {
            if self.isCorrectAnswer(word: w) {
                self.correctAnswers += 1
            }
        }
    }
    
    @IBAction func unwindToGameScreen(segue:UIStoryboardSegue) {
    }
    
    var wordsArrayFromJSON = [Word]()
    var wordToShow: WordToShow?
    let amountOfWords: Int = 10
    var amountOfShownWords: Int = 0
    var correctAnswers: Int = 0
    
    var labelTwo: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let w = Word.fetchJson() {
            wordsArrayFromJSON = w
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        amountOfShownWords = 0
        correctAnswers = 0
        
        labelTwo = UILabel(frame: CGRect(x: 275, y: 36, width: 92, height: 27))
        labelTwo?.textAlignment = .center
        labelTwo?.backgroundColor = .clear
        labelTwo?.font = UIFont.systemFont(ofSize: 22)
        labelTwo?.numberOfLines = 0
        labelTwo?.lineBreakMode = .byWordWrapping
        labelTwo?.sizeToFit()
        self.view.addSubview(labelTwo!)
        
        getWordToShow()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.labelTwo?.removeFromSuperview()
    }
    
    func addLabelTwo() {
        
    }
    
    func getWordToShow() {
        
        if amountOfShownWords < amountOfWords {
            amountOfShownWords += 1
            var wordsArray = [Word]()
            var randomNumber = 0
            for _ in 0 ... 2 {
                randomNumber = Int.random(in: 0 ..< wordsArrayFromJSON.count)
                wordsArray.append(wordsArrayFromJSON[randomNumber])
            }
            randomNumber = Int.random(in: 0 ... 2)
            wordToShow = WordToShow(wordInLanguageOne: wordsArray[0].text_eng ?? "", wordInLanguageTwo: wordsArray[0].text_spa ?? "", wordToDisplay: wordsArray[randomNumber].text_spa ?? "")
            //            print(wordToShow?.wordInLanguageOne as Any, "   ", wordToShow?.wordInLanguageTwo as Any, "   ", wordToShow?.wordToDisplay as Any)
            
            labelOne.text = wordToShow?.wordInLanguageOne
            labelTwo?.text = wordToShow?.wordToDisplay
            labelTwo?.frame = CGRect(x: 275, y: 36, width: 100, height: 27)
            self.view.layoutIfNeeded()
            addAnimation()
        } else {
            performSegue(withIdentifier: "segueToFinalScene", sender: self)
        }
        
    }
    
    func addAnimation() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 5.0, delay: 0.0, options: [], animations: {
                self.labelTwo?.center.y = self.labelOne.center.y
                // print(self.labelTwo?.center.y as Any, "    ", self.labelOne.center.y)
                self.view.layoutIfNeeded()
            }, completion: { (finished: Bool) in
                self.getWordToShow()
            })
        }
    }
    
    func isCorrectAnswer(word: WordToShow) -> Bool {
        return word.wordInLanguageTwo == word.wordToDisplay
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToFinalScene" {
            if let destinationVC = segue.destination as? FinalViewController {
                destinationVC.correctAnswers = correctAnswers
                destinationVC.amountOfWords = amountOfWords
            }
        }
    }
    
}
