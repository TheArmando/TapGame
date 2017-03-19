//
//  ViewController.swift
//  Tap Game
//
//  Created by Armando Silveira on 1/17/17.
//  Copyright © 2017 Armando Silveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var playerOneScore: UILabel!
    @IBOutlet weak var playerTwoScore: UILabel!
    @IBOutlet weak var timeLeft: UITextField!
    @IBOutlet weak var StartButton: UIButton!
    
    
    var alertController = UIAlertController(title: "Game Over", message: "This is my text", preferredStyle: UIAlertControllerStyle.alert)
    
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
    {
        (result : UIAlertAction) -> Void in
        print("You pressed OK")
    }
    
    var playerOneTapCount = 0
    var playerTwoTapCount = 0
    var time = 0
    
    var isGameStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            self.time -= 1
            self.updateUI()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func start(_ sender: Any) {
        //playerOneScore.text = "Player One Score: 0"
        //playerTwoScore.text = "Player Two Score: 0"
        playerOneTapCount = 0
        playerTwoTapCount = 0
        time = 10
        updateUI()
        
        isGameStarted = true
        let _ = Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { (_) in
                // Stop game
                self.isGameStarted = false
                self.endGame()
        }
        
    }

    @IBAction func PlayerOneTap(_ sender: Any) {
        playerOneTapCount += 1
        updateUI()
    }

    @IBAction func PlayerTwoTap(_ sender: Any) {
        playerTwoTapCount += 1
        updateUI()
    }
    
    func updateUI() {
        if isGameStarted {
            playerOneScore.text = "Player One Score: \(playerOneTapCount)"
            playerTwoScore.text = "Player Two Score: \(playerTwoTapCount)"
            timeLeft.text = "Time Left: \(time)"
        } else {
            //self.present(alertController, animated: true) {
                // ...
            //}
            time = 10
        }
    }
    
    func endGame() {
        if (playerOneTapCount > playerTwoTapCount) {
            alertController = UIAlertController(title: "Game Over", message: "Player 1 Won!", preferredStyle: UIAlertControllerStyle.alert)
        } else if (playerOneTapCount < playerTwoTapCount) {
            alertController = UIAlertController(title: "Game Over", message: "Player 2 Won!", preferredStyle: UIAlertControllerStyle.alert)
        } else {
            alertController = UIAlertController(title: "Game Over", message: "Draw!", preferredStyle: UIAlertControllerStyle.alert)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

