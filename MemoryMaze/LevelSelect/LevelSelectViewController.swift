//
//  LevelSelectViewController.swift
//  MemoryMaze
//
//  Created by Garry Fanata on 6/19/19.
//  Copyright © 2019 Garry Fanata. All rights reserved.
//

import UIKit

class LevelSelectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet var selectLevelLabel: UILabel!
    
    var selectedLevel : Maze = Maze()
    var levelFontSize : CGFloat = 40
    var selectLevelFontSize : CGFloat = 40
    var mazeLevel : Maps = Maps()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        dim = collectionView.bounds.width/12
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //no space between collectionview cells
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 20
        
        let screenSize = UIScreen.main.bounds
        
        selectLevelFontSize = (screenSize.width/8)
        selectLevelLabel.font = UIFont(name: selectLevelLabel.font.fontName, size: selectLevelFontSize)
        print(selectLevelFontSize)
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mazeLevel.mazes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LevelCell", for: indexPath) as! LevelSelectCollectionViewCell
        cell.levelLabel.text = String(mazeLevel.mazes[indexPath.row].number)
        cell.levelLabel.adjustsFontSizeToFitWidth = true
        
        levelFontSize = (collectionView.bounds.width/3 - 20)/3 + 5
        cell.levelLabel.font = UIFont(name: cell.levelLabel.font.fontName, size: levelFontSize)
        
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 20;
        
        
        return cell
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //collectionViewCell width = 1/3 the screen
        let yourWidth = collectionView.bounds.width/3 - 20
        //collectionViewCell is always square
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        print(CustomizationViewController.selected.name)
        selectedLevel = mazeLevel.mazes[indexPath.row]
        performSegue(withIdentifier: "LevelToGame", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "LevelToGame")
        {
            let gameVC = segue.destination as! GameViewController
            gameVC.currentLevel = selectedLevel
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
