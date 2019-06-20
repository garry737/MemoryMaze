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

    @IBOutlet var gameLevelLabel: UILabel!
    @IBOutlet var mazeScreen: UIView!
    @IBOutlet var mazeScreenWidthConstraint: NSLayoutConstraint!
    @IBOutlet var upButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var downButton: UIButton!
    
    var blockImage : UIImageView = UIImageView(image: UIImage(named: "Red"))
    var currentCoords : (Float,Float) = (0.0,0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameLevelLabel.text = "Level \(currentLevel)"
        
        let screenSize = UIScreen.main.bounds
        
        mazeScreenWidthConstraint.constant = screenSize.width - (screenSize.width/4)
        mazeScreen.layoutIfNeeded()
        
        let image = CustomizationViewController.selected.image
        blockImage = UIImageView(image: image)
        blockImage.frame = CGRect(x: 0, y: 0, width: mazeScreen.frame.height/10, height: mazeScreen.frame.height/10)
        print(blockImage.frame.height)
        mazeScreen.addSubview(blockImage)
        
        upButton.frame.size = CGSize(width: 25, height: 25)
        upButton.setImage(UIImage(named: "U_Arrow_0"), for: UIControl.State.normal)
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
    
    @IBAction func upButtonPressed(_ sender: Any) {
        print("up")
        blockImage.frame.origin.y -= blockImage.frame.height
    }
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        print("right")
        blockImage.frame.origin.x += blockImage.frame.height
    }
    
    @IBAction func downButtonPressed(_ sender: Any) {
        print("down")
        blockImage.frame.origin.y += blockImage.frame.height
    }
    
    @IBAction func leftButtonPressed(_ sender: Any) {
        print("left")
        blockImage.frame.origin.x -= blockImage.frame.height
    }
    
    
}


