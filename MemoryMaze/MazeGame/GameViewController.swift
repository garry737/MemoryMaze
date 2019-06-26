//
//  GameViewController.swift
//  MemoryMaze
//
//  Created by Garry Fanata on 6/19/19.
//  Copyright © 2019 Garry Fanata. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var currentLevel : Maze = Maze()
    var moveFlag = true
    var path = ""

    @IBOutlet var gameLevelLabel: UILabel!
    @IBOutlet var mazeScreen: UIView!
    @IBOutlet var upButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var downButton: UIButton!
    @IBOutlet var warningLabel: UILabel!
    
    var blockImage : UIImageView = UIImageView(image: UIImage(named: "Red"))
    var maze : [UIImageView] = []
    var allMaps : Maps = Maps()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sets up "Level XX" label on top of view
        gameLevelLabel.text = "Level \(currentLevel.number)"
        gameLevelLabel.font = UIFont(name: gameLevelLabel.font.fontName, size: UIScreen.main.bounds.width/11)
        
        mazeScreen.layoutIfNeeded()
        
        self.drawMaze()
        self.drawEndPoints()
        
        //Width of a grid block
        let inc = Double(mazeScreen.frame.height/10)
        
        //Initializes the block image and positions it with the right skin and position
        blockImage = UIImageView(image: MainMenuViewController.skins[UserDefaults.standard.object(forKey:"skin") as? Int ?? 0].image)
        blockImage.frame = CGRect(x: round(1000.0 * (Double(currentLevel.start.0) * inc)) / 1000.0, y: round(1000.0 * (Double(currentLevel.start.1) * inc)) / 1000.0, width: inc, height: inc)
        
        //Displays the block
        mazeScreen.addSubview(blockImage)
        
        //Sets up the d-pad buttons
        upButton.setImage(UIImage(named: "U_Arrow_0"), for: .normal)
        rightButton.setImage(UIImage(named: "R_Arrow_0"), for: .normal)
        leftButton.setImage(UIImage(named: "L_Arrow_0"), for: .normal)
        downButton.setImage(UIImage(named: "D_Arrow_0"), for: .normal)
        
        //Sets up "WAIT!" warning label
        warningLabel.adjustsFontSizeToFitWidth = true
        warningLabel.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.resetMaze()
    }
    
    @IBAction func leftButtonPressed(_ sender: Any) {
        self.moveBlock(direction: 1)
    }
    
    @IBAction func upButtonPressed(_ sender: Any) {
        self.moveBlock(direction: 2)
    }
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        self.moveBlock(direction: 3)
    }
    
    @IBAction func downButtonPressed(_ sender: Any) {
        self.moveBlock(direction: 4)
    }
    
    func moveBlock(direction : Int){
        //Checks if theres a need to show "WAIT!" warning
        self.showWarning()
        
        //Moves block the direction depending on button pressed
        switch direction {
        case 1: //left
            if (blockImage.frame.origin.x >= blockImage.frame.width - 0.1 && moveFlag) {
                blockImage.frame.origin.x -= blockImage.frame.width
            }
        case 2: //up
            if (blockImage.frame.origin.y >= blockImage.frame.height - 0.1 && moveFlag){
                blockImage.frame.origin.y -= blockImage.frame.height
            }
        case 3: //right
            if (blockImage.frame.origin.x <= mazeScreen.frame.width - blockImage.frame.width-0.1 && moveFlag){
                blockImage.frame.origin.x += blockImage.frame.width
            }
        case 4: //down
            if (blockImage.frame.origin.y <= mazeScreen.frame.height - blockImage.frame.height-0.1 && moveFlag){
                blockImage.frame.origin.y += blockImage.frame.height
            }
        default:
            print("error") //should never reach here
        }
        
        //For ease of map making
        let x = String(Int(round(blockImage.frame.origin.x/blockImage.frame.width)))
        let y = String(Int(round(blockImage.frame.origin.y/blockImage.frame.width)))
        
        path += "(\(x),\(y)),"
        
        //Checks if block hit a wall
        checkCollision(x: Double(round(blockImage.frame.origin.x/blockImage.frame.width)), y: Double(round(blockImage.frame.origin.y/blockImage.frame.width)))
        
    }
    
    //Function to draw the walls of the maze
    func drawMaze(){
        //Resets moveFlag and maze array
        moveFlag = false
        maze = []
        
        //Sets each block of the maze's image and size
        var mazeImage = UIImageView(image: UIImage(named: "MazeYellow"))
        let inc = Double(mazeScreen.frame.height/10)
        
        //Draws walls of the maze
        for coords in currentLevel.walls {
            mazeImage = UIImageView(image: UIImage(named: "MazeYellow"))
            mazeImage.frame = CGRect(x: round(1000.0 * (Double(coords.0) * inc)) / 1000.0, y: round(1000.0 * (Double(coords.1) * inc)) / 1000.0, width: inc, height: inc)
            maze.append(mazeImage)
        }
        for mazeBlock in maze {
            mazeScreen.addSubview(mazeBlock)
        }
    }

    //Function that draws the start and end of the maze
    func drawEndPoints(){
        let inc = Double(mazeScreen.frame.height/10)
        let startPoint = UIImageView(image: UIImage(named: "StartYellow"))
        startPoint.frame = CGRect(x: round(1000.0 * (Double(currentLevel.start.0) * inc)) / 1000.0, y: round(1000.0 * (Double(currentLevel.start.1) * inc)) / 1000.0, width: inc, height: inc)
        let endPoint = UIImageView(image: UIImage(named: "FlagYellow"))
        endPoint.frame = CGRect(x: round(1000.0 * (Double(currentLevel.end.0) * inc)) / 1000.0, y: round(1000.0 * (Double(currentLevel.end.1) * inc)) / 1000.0, width: inc, height: inc)
        mazeScreen.addSubview(startPoint)
        mazeScreen.addSubview(endPoint)
    }
    
    //Function that checks if block has hit a wall
    @discardableResult func checkCollision(x : Double, y : Double) -> Bool{
        let currentCoord = (Int(x),Int(y))
        
        if currentCoord == currentLevel.end{
            currentLevel.completed = true
            
            //Updates UserDefaults on user's progress
            let x = UserDefaults.standard.object(forKey:"unlocked") as? Int ?? 0
            if x < currentLevel.number { UserDefaults.standard.set(currentLevel.number, forKey: "unlocked") }
            
            //Win Alert
            let alert = UIAlertController(title: "Congratulations, You Won!", message: "You have completed this level", preferredStyle: .alert)
            
            //Win Alert (Next Level Button)
            alert.addAction(UIAlertAction(title: "Next Level", style: .default, handler: { action in
                //Changes current level to the next one
                self.currentLevel = self.allMaps.nextMap(map: self.currentLevel)
                self.gameLevelLabel.text = "Level \(self.currentLevel.number)"
                
                //Clears mazeScreen
                for v in self.mazeScreen.subviews{
                    v.removeFromSuperview()
                }
                
                //Redraws maze for reuse of view
                self.drawMaze()
                self.drawEndPoints()
                self.resetMaze()
                
            }))
            
            //Win Alert (All Levels Button)
            alert.addAction(UIAlertAction(title: "All Levels", style: .cancel, handler: { action in
                //Navigates back to level select screen
                self.navigationController?.popViewController(animated: true)
                
            }))
            
            //Show the alert
            self.present(alert, animated: true, completion: nil)
            print(path)
            return true
        }
        
        //Reveals the walls
            for coords in currentLevel.walls {
                if currentCoord == coords{
                    for walls in self.maze{
                        walls.isHidden = false
                        self.mazeScreen.addSubview(walls)
                    }
                    moveFlag = false
                    
                    //Lose Alert
                    let alert = UIAlertController(title: "You Lost!", message: "You have failed", preferredStyle: UIAlertController.Style.alert)
                    
                    //Lose Alert (Try Again Button)
                    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.destructive, handler: { action in
                        //Resets the maze for user to try again
                        self.resetMaze()
                        
                    }))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    return true
                }
            }
        return false
    }
    
    //Function that resets the state of the maze
    func resetMaze(){
        //Moves blockImage to starting positions
        let inc = Double(self.mazeScreen.frame.height/10)
        self.blockImage.frame.origin.x = CGFloat(round(1000.0 * (Double(self.currentLevel.start.0) * inc))/1000)
        self.blockImage.frame.origin.y = CGFloat(round(1000.0 * (Double(self.currentLevel.start.1) * inc))/1000)
        self.mazeScreen.addSubview(blockImage)
        
        //Delay 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            for walls in self.maze{
                //Hides the walls of the maze
                walls.isHidden = true
                self.mazeScreen.addSubview(walls)
            }
            self.moveFlag = true
        }
    }
    
    //Function that shows the "WAIT!" warning if maze is still on screen
    func showWarning(){
        if !moveFlag {
            warningLabel.isHidden = false
            //Fades away the "WAIT!" label after 2 seconds
            UIView.animate(withDuration: 2, animations: {
                self.warningLabel.alpha = 0
            })
            //Resets "WAIT!" label after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.warningLabel.isHidden = true
                self.warningLabel.alpha = 1
            }
        }
    }
}


