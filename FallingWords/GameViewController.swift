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
    
    @IBOutlet weak var fixedWord: UILabel!
    @IBOutlet weak var wrongButton: UIButton!
    @IBOutlet weak var correctButton: UIButton!
    
    @IBAction func tapWrongButton(_ sender: Any) {
        updateUIView(correctAnswer: !self.isCorrectAnswer(currentWord: self.wordToShow!))
    }
    
    @IBAction func tapCorrectButton(_ sender: Any) {
        updateUIView(correctAnswer: self.isCorrectAnswer(currentWord: self.wordToShow!))
    }
    
    @IBAction func unwindToGameScreen(segue:UIStoryboardSegue) {
    }
    
    var wordsArrayFromJSON = [Word]()
    var wordToShow: WordToShow?
    let amountOfWords: Int = 3
    var amountOfShownWords: Int = 0
    var correctAnswers: Int = 0
    
    var fallingWord: UILabel?
    let fallingWordDefaultFrame = CGRect(x: 225, y: 36, width: 150, height: 27)
    let fallingWordFontSize: CGFloat = 22
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let w = Word.fetchJson() {
            wordsArrayFromJSON = w
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        amountOfShownWords = 0
        correctAnswers = 0
        
        fallingWord = initFallingWord()
        self.view.addSubview(fallingWord!)
        
        getWordToShow()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.fallingWord?.removeFromSuperview()
    }
    
    func initFallingWord() -> UILabel {
        let word = UILabel(frame: fallingWordDefaultFrame)
        word.textAlignment = .right
        word.backgroundColor = .clear
        word.font = UIFont.systemFont(ofSize: fallingWordFontSize)
        word.numberOfLines = 0
        word.lineBreakMode = .byWordWrapping
        word.sizeToFit()
        return word
    }
    
    func updateUIView(correctAnswer: Bool) {
        disableButtons()
        
        if correctAnswer {
            setWordsColor(.green)
            self.correctAnswers += 1
        } else {
            setWordsColor(.red)
        }
    }
    
    private func setWordsColor(_ color: UIColor) {
        fixedWord.textColor = color
        fallingWord?.textColor = color
    }

    func getWordToShow() {
        enableButtons()
        setWordsColor(.gray)
        
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
            print(wordToShow?.wordInLanguageOne as Any, "   ", wordToShow?.wordInLanguageTwo as Any, "   ", wordToShow?.wordToDisplay as Any)
            
            fixedWord.text = wordToShow?.wordInLanguageOne
            fallingWord?.text = wordToShow?.wordToDisplay
            fallingWord?.frame = fallingWordDefaultFrame
            self.view.layoutIfNeeded()
            addAnimation()
        } else {
            performSegue(withIdentifier: "segueToFinalScene", sender: self)
        }
    }
    
    func addAnimation() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 4.0, delay: 0.0, options: [], animations: {
                self.fallingWord?.center.y = self.fixedWord.center.y
                self.view.layoutIfNeeded()
            }, completion: { (finished: Bool) in
                self.getWordToShow()
            })
        }
    }
    
    func isCorrectAnswer(currentWord: WordToShow?) -> Bool {
        guard let word = currentWord else {
            return false
        }
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
    
    
    fileprivate func enableButtons() {
        wrongButton.isEnabled = true
        wrongButton.backgroundColor = .red
        
        correctButton.isEnabled = true
        correctButton.backgroundColor = .green
    }
    
    fileprivate func disableButtons() {
        wrongButton.isEnabled = false
        wrongButton.backgroundColor = .gray
        
        correctButton.isEnabled = false
        correctButton.backgroundColor = .gray
    }
    
}
