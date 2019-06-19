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
    
    var levels : [Int] = []
    var selectedLevel : Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        dim = collectionView.bounds.width/12
        
        levels = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //no space between collectionview cells
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 20

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LevelCell", for: indexPath) as! LevelSelectCollectionViewCell
        cell.levelLabel.text = String(levels[indexPath.row])
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 20;
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //collectionViewCell width = 1/3 the screen
        let yourWidth = collectionView.bounds.width/3 - 20
        //collectionViewCell is always square
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(String(levels[indexPath.row]))
        print(CustomizationViewController.selected.name)
        selectedLevel = levels[indexPath.row]
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
