//
//  InterfaceController.swift
//  RockPaperScissorsSwift WatchKit Extension
//
//  Created by Xiaoli Shen on 2019/04/28.
//  Copyright © 2019 furixturi. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var opponentLabel: WKInterfaceLabel!
    @IBOutlet weak var resultLabel: WKInterfaceLabel!
    @IBOutlet weak var counterLabel: WKInterfaceLabel!
    @IBOutlet weak var timer: WKInterfaceTimer!
    
    @IBOutlet weak var rockButton: WKInterfaceButton!
    @IBOutlet weak var paperButton: WKInterfaceButton!
    @IBOutlet weak var scissorsButton: WKInterfaceButton!
    
    enum Option: String {
        case rock
        case paper
        case scissors
        
        var image: UIImage? {
            return UIImage(named: rawValue)
        }
    }
    
    enum Result: String {
        case win = "WIN"
        case tie = "TIE"
        case lose = "LOSE"
        
        func update(label: WKInterfaceLabel) {
            label.setText(rawValue)
        }
    }
    
    let options: [Option] = [.rock, .paper, .scissors]
    var counter = 0
    
    func check(_ selection: Option) {
        let randomOptions = options.shuffled()
        let machineChoose = randomOptions[0]
        let result: Result
        
        switch (selection, machineChoose) {
        case (.rock, .scissors),
             (.paper, .rock),
             (.scissors, .paper):
             result = .win
        case (.rock, .paper),
             (.paper, .scissors),
            (.scissors, .rock):
            result = .lose
        default:
            result = .tie
        }
        
        if result == .win {
            counter += 1
        }
        
        result.update(label: resultLabel)
        counterLabel.setText("Wins: \(counter)")
        opponentLabel.setText("Opponent: \(machineChoose)")
    }
    

    
    @IBAction func rock() {
        check(.rock)
    }
    
    @IBAction func paper() {
        check(.paper)
    }
    
    @IBAction func scissors() {
        check(.scissors)
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        rockButton.setBackgroundImage(Option.rock.image)
        paperButton.setBackgroundImage(Option.paper.image)
        scissorsButton.setBackgroundImage(Option.scissors.image)
        
        timer.start()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
