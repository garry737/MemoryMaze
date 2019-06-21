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
        Maze(number: 2, start: (5,0), end: (5, 9), walls: [(4,0),(6,0),(4,1),(6,1),(4,2),(6,2),(4,3),(6,3),(4,4),(6,4),(4,5),(6,5),(4,6),(6,6),(4,7),(6,7),(4,8),(6,8),(4,9),(6,9)]),
        Maze(number: 3, start: (4,0), end: (9,5), walls: [(3,0),(5,0),(3,1),(5,1),(3,2),(5,2),(3,3),(5,3),(3,4),(5,4),(6,4),(7,4),(8,4),(9,4),(3,5),(3,6),(4,6),(5,6),(6,6),(7,6),(8,6),(9,6)]),
        Maze(number: 4, start: (1,0), end: (4,9), walls: [(0,0),(2,0),(0,1),(2,1),(0,2),(2,2),(0,3),(2,3),(0,4),(2,4),(0,5),(2,5),(0,6),(2,6),(3,6),(4,6),(5,6),(0,7),(5,7),(0,8),(1,8),(2,8),(3,8),(5,8),(3,9),(5,9)]),
        Maze(number: 99999, start: (0,0), end: (9,9), walls: [])
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
