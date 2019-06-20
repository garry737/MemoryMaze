//
//  GameViewController.swift
//  MemoryMaze
//
//  Created by Garry Fanata on 6/19/19.
//  Copyright © 2019 Garry Fanata. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var currentLevel : Int = -1
    var moveFlag = true

    @IBOutlet var gameLevelLabel: UILabel!
    @IBOutlet var mazeScreen: UIView!
    @IBOutlet var mazeScreenWidthConstraint: NSLayoutConstraint!
    @IBOutlet var upButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var downButton: UIButton!
    
    var blockImage : UIImageView = UIImageView(image: UIImage(named: "Red"))
    var maze : [UIImageView] = []
    var currentCoords : (Float,Float) = (0.0,0.0)
    var mazecoords : [(Int,Int)] = [(2,0),(0,1),(2,1),(0,2),(2,2),(0,3),(2,3),(0,4),(2,4),(0,5),(2,5),(0,6),(2,6),(3,6),(4,6),(5,6),(0,7),(5,7),(0,8),(1,8),(2,8),(3,8),(5,8),(3,9),(5,9)]
    var endPoints : [(Int,Int)] = [(0,0),(4,9)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameLevelLabel.text = "Level \(currentLevel)"
        
        let screenSize = UIScreen.main.bounds
        
        mazeScreen.layoutIfNeeded()
        
        self.drawMaze()
        self.drawEndPoints()
        
        let inc = Double(mazeScreen.frame.height/10)
        blockImage = UIImageView(image: CustomizationViewController.selected.image)
        blockImage.frame = CGRect(x: round(1000.0 * (Double(endPoints[0].0) * inc)) / 1000.0, y: round(1000.0 * (Double(endPoints[0].1) * inc)) / 1000.0, width: inc, height: inc)
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
        print("blockImage frame origin x = \(round(blockImage.frame.origin.x/blockImage.frame.width))")
        print("blockImage frame origin y = \(round(blockImage.frame.origin.y/blockImage.frame.width))")
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
        print("blockImage frame origin x = \(round(blockImage.frame.origin.x/blockImage.frame.width))")
        print("blockImage frame origin y = \(round(blockImage.frame.origin.y/blockImage.frame.width))")
        checkCollision(x: Double(round(blockImage.frame.origin.x/blockImage.frame.width)), y: Double(round(blockImage.frame.origin.y/blockImage.frame.width)))
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
        
        print("blockImage frame origin x = \(round(blockImage.frame.origin.x/blockImage.frame.width))")
        print("blockImage frame origin y = \(round(blockImage.frame.origin.y/blockImage.frame.width))")
        checkCollision(x: Double(round(blockImage.frame.origin.x/blockImage.frame.width)), y: Double(round(blockImage.frame.origin.y/blockImage.frame.width)))
        
    }
    
    @IBAction func leftButtonPressed(_ sender: Any) {
        print("left")
        if (blockImage.frame.origin.x >= blockImage.frame.width - 0.1 && moveFlag) {
            blockImage.frame.origin.x -= blockImage.frame.width
        } else {
            print("WALLED")
        }
        print("blockImage frame origin x = \(round(blockImage.frame.origin.x/blockImage.frame.width))")
        print("blockImage frame origin y = \(round(blockImage.frame.origin.y/blockImage.frame.width))")
        checkCollision(x: Double(round(blockImage.frame.origin.x/blockImage.frame.width)), y: Double(round(blockImage.frame.origin.y/blockImage.frame.width)))
    }
    
    func drawMaze(){
        moveFlag = false
        var mazeImage = UIImageView(image: UIImage(named: "MazeYellow"))
        let inc = Double(mazeScreen.frame.height/10)
        
        for coords in mazecoords {
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
        startPoint.frame = CGRect(x: round(1000.0 * (Double(endPoints[0].0) * inc)) / 1000.0, y: round(1000.0 * (Double(endPoints[0].1) * inc)) / 1000.0, width: inc, height: inc)
        let endPoint = UIImageView(image: UIImage(named: "FlagYellow"))
        endPoint.frame = CGRect(x: round(1000.0 * (Double(endPoints[1].0) * inc)) / 1000.0, y: round(1000.0 * (Double(endPoints[1].1) * inc)) / 1000.0, width: inc, height: inc)
        mazeScreen.addSubview(startPoint)
        mazeScreen.addSubview(endPoint)
    }
    
    @discardableResult func checkCollision(x : Double, y : Double) -> Bool{
        let currentCoord = (Int(x),Int(y))
        
        if currentCoord == endPoints[1]{
                print("WINNERRR")
            let alert = UIAlertController(title: "Congratulations, You Won!", message: "You have completed this level", preferredStyle: UIAlertController.Style.alert)
            
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

        for coords in mazecoords {
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
        self.blockImage.frame.origin.x = CGFloat(round(1000.0 * (Double(self.endPoints[0].0) * inc))/1000)
        self.blockImage.frame.origin.y = CGFloat(round(1000.0 * (Double(self.endPoints[0].1) * inc))/1000)
        
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


