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
    
    var blockImage : UIImageView = UIImageView(image: UIImage(named: "Red"))
    var maze : [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameLevelLabel.text = "Level \(currentLevel.number)"
        
        mazeScreen.layoutIfNeeded()
        
        self.drawMaze()
        self.drawEndPoints()
        
        let defaults = UserDefaults.standard
        
        let inc = Double(mazeScreen.frame.height/10)
        blockImage = UIImageView(image: MainMenuViewController.skins[defaults.object(forKey:"skin") as? Int ?? 0].image)
        blockImage.frame = CGRect(x: round(1000.0 * (Double(currentLevel.start.0) * inc)) / 1000.0, y: round(1000.0 * (Double(currentLevel.start.1) * inc)) / 1000.0, width: inc, height: inc)
        print(blockImage.frame.height)
        print("blockImage frame origin x = \(blockImage.frame.origin.x)")
        print("blockImage frame origin y = \(blockImage.frame.origin.y)")
        
        mazeScreen.addSubview(blockImage)
        
        upButton.setImage(UIImage(named: "U_Arrow_0"), for: .normal)
        upButton.contentMode = .center
        upButton.autoresizesSubviews = true
        upButton.imageRect(forContentRect: CGRect(x: 0, y: 0, width: 25, height: 25))
        upButton.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        upButton.imageView?.contentMode = .scaleAspectFill
        upButton.imageEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        upButton.layer.masksToBounds = true
        
        rightButton.setImage(UIImage(named: "R_Arrow_0"), for: UIControl.State.normal)
        rightButton.contentMode = .center
        rightButton.imageView?.contentMode = .scaleAspectFit
        rightButton.imageView?.contentMode = .scaleAspectFill
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        rightButton.layer.masksToBounds = true
        
        leftButton.setImage(UIImage(named: "L_Arrow_0"), for: UIControl.State.normal)
        leftButton.contentMode = .center
        leftButton.imageView?.contentMode = .scaleAspectFit
        
        downButton.setImage(UIImage(named: "D_Arrow_0"), for: UIControl.State.normal)
        downButton.contentMode = .center
        downButton.imageView?.contentMode = .scaleAspectFit
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.resetMaze()
    }
    
    @IBAction func upButtonPressed(_ sender: Any) {
        print("up")
        if (blockImage.frame.origin.y >= blockImage.frame.height - 0.1 && moveFlag){
            blockImage.frame.origin.y -= blockImage.frame.height
        } else {
            print("WALLED")
        }
//        print("blockImage frame origin x = \(round(blockImage.frame.origin.x/blockImage.frame.width))")
//        print("blockImage frame origin y = \(round(blockImage.frame.origin.y/blockImage.frame.width))")
        
        let x = String(Int(round(blockImage.frame.origin.x/blockImage.frame.width)))
        let y = String(Int(round(blockImage.frame.origin.y/blockImage.frame.width)))
        
        path += "("
        path += x
        path += ","
        path += y
        path += "),"
        
        
        checkCollision(x: Double(round(blockImage.frame.origin.x/blockImage.frame.width)), y: Double(round(blockImage.frame.origin.y/blockImage.frame.width)))
//        print("blockImage frame height = \(blockImage.frame.height)")
    }
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        print("right")
        if (blockImage.frame.origin.x <= mazeScreen.frame.width - blockImage.frame.width-0.1 && moveFlag){
            blockImage.frame.origin.x += blockImage.frame.width
        } else {
            print("WALLED")
        }
//        print("blockImage frame origin x = \(round(blockImage.frame.origin.x/blockImage.frame.width))")
//        print("blockImage frame origin y = \(round(blockImage.frame.origin.y/blockImage.frame.width))")
        checkCollision(x: Double(round(blockImage.frame.origin.x/blockImage.frame.width)), y: Double(round(blockImage.frame.origin.y/blockImage.frame.width)))
        
        let x = String(Int(round(blockImage.frame.origin.x/blockImage.frame.width)))
        let y = String(Int(round(blockImage.frame.origin.y/blockImage.frame.width)))
        
        path += "("
        path += x
        path += ","
        path += y
        path += "),"
//        print("mazeScreen frame width = \(mazeScreen.frame.width)")
//        print("blockImage frame width = \(blockImage.frame.height)")
    }
    
    @IBAction func downButtonPressed(_ sender: Any) {
        print("down")
        if (blockImage.frame.origin.y <= mazeScreen.frame.height - blockImage.frame.height-0.1 && moveFlag){
            blockImage.frame.origin.y += blockImage.frame.height
        } else {
            print("WALLED")
        }
        
//        print("blockImage frame origin x = \(round(blockImage.frame.origin.x/blockImage.frame.width))")
//        print("blockImage frame origin y = \(round(blockImage.frame.origin.y/blockImage.frame.width))")
        checkCollision(x: Double(round(blockImage.frame.origin.x/blockImage.frame.width)), y: Double(round(blockImage.frame.origin.y/blockImage.frame.width)))
        
        let x = String(Int(round(blockImage.frame.origin.x/blockImage.frame.width)))
        let y = String(Int(round(blockImage.frame.origin.y/blockImage.frame.width)))
        
        path += "("
        path += x
        path += ","
        path += y
        path += "),"
    }
    
    @IBAction func leftButtonPressed(_ sender: Any) {
        print("left")
        if (blockImage.frame.origin.x >= blockImage.frame.width - 0.1 && moveFlag) {
            blockImage.frame.origin.x -= blockImage.frame.width
        } else {
            print("WALLED")
        }
//        print("blockImage frame origin x = \(round(blockImage.frame.origin.x/blockImage.frame.width))")
//        print("blockImage frame origin y = \(round(blockImage.frame.origin.y/blockImage.frame.width))")
        checkCollision(x: Double(round(blockImage.frame.origin.x/blockImage.frame.width)), y: Double(round(blockImage.frame.origin.y/blockImage.frame.width)))
        
        let x = String(Int(round(blockImage.frame.origin.x/blockImage.frame.width)))
        let y = String(Int(round(blockImage.frame.origin.y/blockImage.frame.width)))
        
        path += "("
        path += x
        path += ","
        path += y
        path += "),"
    }
    
    func drawMaze(){
        moveFlag = false
        var mazeImage = UIImageView(image: UIImage(named: "MazeYellow"))
        let inc = Double(mazeScreen.frame.height/10)
        
        for coords in currentLevel.walls {
            mazeImage = UIImageView(image: UIImage(named: "MazeYellow"))
            mazeImage.frame = CGRect(x: round(1000.0 * (Double(coords.0) * inc)) / 1000.0, y: round(1000.0 * (Double(coords.1) * inc)) / 1000.0, width: inc, height: inc)
            maze.append(mazeImage)
            
        for mazeBlock in maze {
            mazeScreen.addSubview(mazeBlock)
        }
        }
    }

    func drawEndPoints(){
        let inc = Double(mazeScreen.frame.height/10)
        let startPoint = UIImageView(image: UIImage(named: "StartYellow"))
        startPoint.frame = CGRect(x: round(1000.0 * (Double(currentLevel.start.0) * inc)) / 1000.0, y: round(1000.0 * (Double(currentLevel.start.1) * inc)) / 1000.0, width: inc, height: inc)
        let endPoint = UIImageView(image: UIImage(named: "FlagYellow"))
        endPoint.frame = CGRect(x: round(1000.0 * (Double(currentLevel.end.0) * inc)) / 1000.0, y: round(1000.0 * (Double(currentLevel.end.1) * inc)) / 1000.0, width: inc, height: inc)
        mazeScreen.addSubview(startPoint)
        mazeScreen.addSubview(endPoint)
    }
    
    @discardableResult func checkCollision(x : Double, y : Double) -> Bool{
        let currentCoord = (Int(x),Int(y))
        
        if currentCoord == currentLevel.end{
                print("WINNERRR")
            let alert = UIAlertController(title: "Congratulations, You Won!", message: "You have completed this level", preferredStyle: UIAlertController.Style.alert)
            let defaults = UserDefaults.standard
            let x = defaults.object(forKey:"unlocked") as? Int ?? 0
            if x < currentLevel.number {defaults.set(currentLevel.number, forKey: "unlocked")}
            print(path)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "Back To Level Selection", style: UIAlertAction.Style.default, handler: { action in
                
                // do something like...
                print("Won")
//                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
                
            }))
            
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            print("ALERT")
            
            return true
        }

        for coords in currentLevel.walls {
            if currentCoord == coords{
                print("LOSERRR")
                
                for walls in self.maze{
                    walls.isHidden = false
                    self.mazeScreen.addSubview(walls)
                }
                moveFlag = false
                
                let alert = UIAlertController(title: "You Lost!", message: "You have failed", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.destructive, handler: { action in
                    
                    // do something like...
                    print("RESET")
                    self.resetMaze()
                    
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                return true
            }
        }
        return false
    }
    
    func resetMaze(){
        let inc = Double(self.mazeScreen.frame.height/10)
        self.blockImage.frame.origin.x = CGFloat(round(1000.0 * (Double(self.currentLevel.start.0) * inc))/1000)
        self.blockImage.frame.origin.y = CGFloat(round(1000.0 * (Double(self.currentLevel.start.1) * inc))/1000)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            print("Bye now")
            for walls in self.maze{
                walls.isHidden = true
                self.mazeScreen.addSubview(walls)
            }
            self.moveFlag = true
        }
    }
}


