//
//  ViewController.swift
//  Project2
//
//  Created by Prathamesh Pawar on 3/27/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    
    
    // Loading the 1st view on the screen
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
    
        countries += ["estonia", "france", "germany", "ireland","italy","monaco", "nigeria", "poland", "russia", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        
        let alert = UIAlertController(title: "WELCOME", message: "GUESS THE FLAG..!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func showScore() {
        let vc = UIAlertController(title: "Score", message: "Your Current Score is:\(score)", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(vc, animated: true)
    }
    
    // Every time a new question will be asked by calling this method
    ///shuffle the array and select first 3 images to show on the screen and then one of them will be the correct answer which we have stored in the variable called carrectAnswer by using the random method, and at the end we have increased the questionAsked flag by 1 to keep the count of the total asked questions
    func askQuestion(action: UIAlertAction! = nil) {
        
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)

        title = countries[correctAnswer].uppercased()
        
        questionsAsked += 1
    }
    
    // function to start a new game
    func startANewGame(action: UIAlertAction! = nil){
            score = 0
            questionsAsked = 0
            askQuestion()
    }
    
    // Everytime a button is tapped in the storyboad/screen, this method will be called
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 20
        } else {
            title = "Wrong! That's a flag of \(countries[sender.tag].uppercased())"
            score -= 10
        }
        
        //After 10 Q's --> New Game
        if questionsAsked ==  10 {
            score = 0
            let ac2 = UIAlertController(title: "Alert", message: "You have answered 10 Q's", preferredStyle: .alert)
            ac2.addAction(UIAlertAction(title: "Start A New Game", style: .cancel, handler: startANewGame))
            self.present(ac2, animated: true, completion: nil)
        } else {
            // using the title as the title of Alert
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            self.present(ac, animated: true,completion: nil)
        }
        
        // Label --> View ---> button --> Place it in Navigation Bar
        let scoreView = UILabel()
        scoreView.text = "Score: \(score)"
        let scoreButton = UIBarButtonItem(customView: scoreView)
        navigationItem.leftBarButtonItem = scoreButton
        
        
        // You win the game if score is equal or more than 150
        if score >= 150 {
            
            score = 0
            let statusView = UILabel()
            statusView.text = "You Won"
            let statusButton = UIBarButtonItem(customView: statusView)
            navigationItem.rightBarButtonItem = statusButton
            
            let ac1 = UIAlertController(title: "Congrats", message: "You Won The Game", preferredStyle: .alert)
            ac1.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            self.present(ac1, animated: true, completion: nil)
            
        }
        
                
    }
    
}



