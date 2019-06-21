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
    
    var firstCheck : Bool = true
    var maps : Maps = Maps(mazes: [
        Maze(number: 1, start: (0,5), end: (9,5), walls:[(0,4),(1,4),(2,4),(3,4),(4,4),(5,4),(6,4),(7,4),(8,4),(9,4),(0,6),(1,6),(2,6),(3,6),(4,6),(5,6),(6,6),(7,6),(8,6),(9,6)]),
        Maze(number: 2, start: (4,0), end: (9,5), walls: [(3,0),(5,0),(3,1),(5,1),(3,2),(5,2),(3,3),(5,3),(3,4),(5,4),(6,4),(7,4),(8,4),(9,4),(3,5),(3,6),(4,6),(5,6),(6,6),(7,6),(8,6),(9,6)]),
        Maze(number: 3, start: (0,1), end: (8,9), walls: [(0,0),(1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(9,1),(9,2),(9,3),(9,4),(9,5),(9,6),(9,7),(9,8),(9,9),(0,2),(1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(7,3),(7,4),(7,5),(7,6),(7,7),(7,8),(7,9)]),
        Maze(number: 4, start: (0,3), end: (0,6), walls: [(0,2),(1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(8,2),(9,2),(9,3),(9,4),(9,5),(9,6),(8,6),(7,6),(6,6),(5,6),(4,6),(3,6),(2,6),(1,6),(0,4),(1,4),(2,4),(3,4),(4,4),(5,4),(6,4),(7,4)]),
        Maze(number: 5, start: (0,1), end: (6,9), walls: [(0,0),(1,0),(2,0),(3,0),(4,0),(4,1),(8,2),(7,2),(6,2),(5,2),(4,2),(2,2),(1,2),(0,2),(2,3),(2,4),(3,4),(4,4),(5,4),(6,4),(3,5),(3,6),(3,7),(3,8),(4,8),(5,8),(5,9),(7,9),(7,8),(7,7),(7,6),(6,6),(5,6),(8,6),(8,5),(8,4),(8,3)]),
        Maze(number: 6, start: (1,0), end: (5,3), walls: [(0,0),(0,1),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),(0,8),(0,9),(1,9),(2,9),(3,9),(4,9),(5,9),(6,9),(7,9),(8,9),(9,9),(9,8),(9,7),(9,6),(9,5),(9,4),(9,3),(9,2),(9,1),(9,0),(8,0),(7,0),(6,0),(5,0),(4,0),(3,0),(2,0),(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(3,7),(4,7),(5,7),(6,7),(7,7),(7,6),(7,5),(7,4),(7,3),(7,2),(6,2),(5,2),(4,2),(4,3),(4,4),(4,5),(5,5),(5,4)]),
        Maze(number: 7, start: (1,0), end: (9,1), walls: [(0,0),(0,1),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),(0,8),(0,9),(0,9),(0,9),(0,9),(0,9),(1,9),(2,9),(3,9),(4,9),(5,9),(6,9),(7,9),(8,9),(9,9),(9,9),(9,8),(9,7),(9,6),(9,5),(9,4),(9,3),(9,2),(8,2),(7,2),(6,2),(5,2),(9,0),(8,0),(7,0),(6,0),(5,0),(4,0),(3,0),(2,0),(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(3,7),(4,7),(5,7),(6,7),(7,7),(7,6),(7,5),(7,4),(6,4),(5,4),(4,4),(3,4),(4,2)]),
        
        Maze(number: 99999, start: (9,0), end: (3,4), walls: [])
        ])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
//        let screenWidth = screenSize.width
        
        changeSkinBottomConstraint.constant = screenHeight * 0.1
        
        
        
        // Do any additional setup after loading the view.
    }
    
//    func firstLaunch()->Bool{
//        let defaults = UserDefaults.standard
//        if let _ = defaults.string(forKey: "firstLaunch"){
//            print("App already launched")
//            return false
//        }else{
//            defaults.set(false, forKey: "firstLaunch")
//            print("App launched first time")
//            return true
//        }
//    }
    
//    static func initialMapGen() -> Maps{
//        let defaults = UserDefaults.standard
//        if let _ = defaults.string(forKey: "firstLaunch"){
//            let firstMap = Maze(number: 1, start: (9,9), end: (4,9), walls: [(2,0),(0,1),(2,1),(0,2),(2,2),(0,3),(2,3),(0,4),(2,4),(0,5),(2,5),(0,6),(2,6),(3,6),(4,6),(5,6),(0,7),(5,7),(0,8),(1,8),(2,8),(3,8),(5,8),(3,9),(5,9),(7,7)])
//            var maps = Maps(mazes: [firstMap])
//        }
//
//        return maps
//    }
    
    @IBAction func selectLevelButton(_ sender: Any) {
        performSegue(withIdentifier: "MainToLevel", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MainToLevel")
        {
            let levelVC = segue.destination as? LevelSelectViewController
            levelVC?.mazeLevel = maps
        }
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
