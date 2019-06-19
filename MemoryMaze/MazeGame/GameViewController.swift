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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameLevelLabel.text = "Level \(currentLevel)"

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
