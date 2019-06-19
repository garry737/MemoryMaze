//
//  MainMenuViewController.swift
//  MemoryMaze
//
//  Created by Garry Fanata on 6/19/19.
//  Copyright © 2019 Garry Fanata. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet var changeSkinBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var selectLevelButton: UIButton!
    @IBOutlet var changeSkinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
//        let screenWidth = screenSize.width
        
        changeSkinBottomConstraint.constant = screenHeight * 0.1

        
        // Do any additional setup after loading the view.
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
