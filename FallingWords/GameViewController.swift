//
//  GameViewController.swift
//  FallingWords
//
//  Created by Nataly Tatarintseva on 10/20/18.
//  Copyright © 2018 Nataly Tatarintseva. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    
    @IBAction func unwindToGameScreen(segue:UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 5.0) {
            self.labelTwo.center.y = self.labelOne.center.y
        }

    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
