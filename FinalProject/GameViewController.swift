//
//  ViewController.swift
//  FinalProject
//
//  Created by Xinyu Zhao and Molly Zhang on 11/22/15.
//  Copyright © 2015 Xinyu Zhao and Molly Zhang. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var boardView: UIView!
    
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var toolBar: UIView!
    @IBOutlet var name: UINavigationBar!
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var flagButton: UIButton!
    
    let BOARD_SIZE:Int = 8
    var board:Board
    var squareButtons:[SquareButton] = []
    var moves:Int = 0 {
        didSet {
            self.movesLabel.text = "Moves: \(moves)"
            self.movesLabel.sizeToFit()
        }
    }
    var timeTaken:Int = 0  {
        didSet {
            self.timeLabel.text = "Time: \(timeTaken)"
            self.timeLabel.sizeToFit()
        }
    }
    var oneSecondTimer:NSTimer?
    
    var gameEnded = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeBoard()
        let viewFrame = view.frame;
        let widthCenter = viewFrame.width/2.0
        self.boardView.center = CGPoint(x: widthCenter, y: boardView.center.y)
        movesLabel.center = CGPoint(x: widthCenter/2, y: movesLabel.center.y)
        timeLabel.center = CGPoint(x: 3*(widthCenter/2), y: timeLabel.center.y)
        name.center = CGPoint(x: widthCenter, y: name.center.y)
        toolBar.center = CGPoint(x: widthCenter, y: toolBar.center.y)
        pauseButton.hidden = true
        toolBar.layer.borderColor = UIColor(red:0.93, green:0.78, blue:0.78, alpha:1.0).CGColor
        toolBar.layer.borderWidth = 2
        flagButton.center = CGPoint(x: widthCenter, y: flagButton.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func newGamePressed() {
        self.endCurrentGame()
        pauseButton.hidden = false
        self.startNewGame()
        gameEnded = false
        
    }
    
    required init(coder aDecoder: NSCoder){
        self.board = Board(size: BOARD_SIZE)
        super.init(coder: aDecoder)!
    }
    
    func initializeBoard() {
        for row in 0 ..< board.size {
            for col in 0 ..< board.size {
                let square = board.squares[row][col]
                let squareSize:CGFloat = self.boardView.frame.width / CGFloat(BOARD_SIZE)
                let squareButton = SquareButton(squareModel: square, squareSize: squareSize)
                squareButton.addTarget(self, action: "squareButtonPressed:", forControlEvents: .TouchUpInside)
                self.boardView.addSubview(squareButton)
                self.squareButtons.append(squareButton)
                square.button = squareButton
            }
        }
    }
    
    
    func squareButtonPressed(sender: SquareButton) {
        if(flagButton.selected == false && gameEnded == false){
            if(!sender.square.isRevealed) {
                sender.square.isRevealed = true
                sender.setImage(nil, forState: UIControlState.Normal)
                sender.setTitle("\(sender.getLabelText())", forState: .Normal)
                self.moves++
            }
            
            
            if (sender.square.isMineLocation) {
                self.minePressed()
            }
        }
        
        if(flagButton.selected == true)
        {
            let image = sender.imageView?.image
            if(image == UIImage(named: "Tile"))
            {
                let flagged = UIImage(named: "flaggedButton")
                sender.setImage(flagged, forState: UIControlState.Normal)
            }
            else
            {
                let unflagged = UIImage(named: "Tile")
                sender.setImage(unflagged, forState: UIControlState.Normal)
            }
        }
        
        if(self.checkMines())
        {
            self.wonGame()
        }
    }
    
    func checkMines() -> Bool
    {
        
        var flagged = 0
        var squaresLeft = 0
        for subviews in boardView.subviews
        {
            if(subviews is SquareButton)
            {
                let image = (subviews as! SquareButton).imageView?.image
                if(image == UIImage(named: "flaggedButton"))
                {
                    flagged = flagged + 1
                }
                if(!(subviews as! SquareButton).square.isRevealed)
                {
                    squaresLeft = squaresLeft + 1
                }
            }
        }
        return flagged == squaresLeft
    }
    
    @IBAction func selectFlag(sender: UIButton) {
        if(!gameEnded)
        {
            flagButton.selected = !flagButton.selected
        }
    }
    
    
    func resetBoard() {
        // resets the board with new mine locations & sets isRevealed to false for each square
        self.board.resetBoard()
        // iterates through each button and resets the text to the default value
        for squareButton in self.squareButtons {
            squareButton.setImage(UIImage(named: "Tile"), forState: UIControlState.Normal)
        }
    }
    
    func minePressed() {
        // show an alert when you tap on a mine
        for subview in boardView.subviews
        {
            if(subview is SquareButton)
            {
                if((subview as! SquareButton).square.isMineLocation)
                {
                    (subview as! SquareButton).square.isRevealed = true
                    (subview as! SquareButton).setImage(nil, forState: UIControlState.Normal)
                    (subview as! SquareButton).setTitle("M", forState: .Normal)
                    if((subview as! SquareButton).currentTitle == "M"){
                        (subview as! SquareButton).setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
                    }
                }
            }
        }
        self.endCurrentGame()
    }
    
    @IBAction func mainMenuButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
        gameEnded = true
    }

    @IBAction func gamePaused(sender: UIButton) {
        self.oneSecondTimer?.invalidate()
        
        let pauseAlert = UIAlertController(title: "Paused", message: "Your Game is paused", preferredStyle: .Alert)
        
        let resumeButton = UIAlertAction(title: "Resume", style: UIAlertActionStyle.Default, handler: {
            (alertController: UIAlertAction!) in
            self.resume()
        })
        
        let quitButton = UIAlertAction(title: "Quit Game", style: UIAlertActionStyle.Default, handler: {
            (alertController: UIAlertAction!) in
            self.quitGame()
        })
        
        pauseAlert.addAction(resumeButton)
        pauseAlert.addAction(quitButton)
        presentViewController(pauseAlert, animated: true, completion: nil)
    }
    
    func resume()
    {
        self.oneSecondTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("oneSecond"), userInfo: nil, repeats: true)
    }
    
    
    func wonGame()
    {
        self.endCurrentGame()
        let alertController = UIAlertController(title: "CONGRATULATIONS", message: "You won the game! What would you like to do?", preferredStyle: .Alert)
        
        let newGameButton = UIAlertAction(title: "New Game", style: UIAlertActionStyle.Default, handler: {
            (alertController: UIAlertAction!) in
            self.startNewGame()
        })
        
        let quiteGameButton = UIAlertAction(title: "Quit Game", style: UIAlertActionStyle.Default, handler: {
            (alertController: UIAlertAction!) in
            self.quitGame()
        })
        
        alertController.addAction(newGameButton)
        alertController.addAction(quiteGameButton)
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func startNewGame() {
        //start new game
        gameEnded = false
        startButton.setTitle("New Game", forState: UIControlState.Normal)
        self.resetBoard()
        self.timeTaken = 0
        self.moves = 0
        self.oneSecondTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("oneSecond"), userInfo: nil, repeats: true)
    }
    
    func quitGame(){
            dismissViewControllerAnimated(true, completion: nil)
            gameEnded = true

    }
    
    func oneSecond() {
        self.timeTaken++
    }
    
    func endCurrentGame() {
        if(oneSecondTimer != nil)
        {
        
            self.oneSecondTimer!.invalidate()
            self.oneSecondTimer = nil
        }
        gameEnded = true
    }
}

