//
//  LevelSelectViewController.swift
//  MemoryMaze
//
//  Created by Garry Fanata on 6/19/19.
//  Copyright © 2019 Garry Fanata. All rights reserved.
//

import UIKit

//Extension to UIColor to allow RGB
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

class LevelSelectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet var selectLevelLabel: UILabel!
    
    var selectedLevel : Maze = Maze()
    var levelFontSize : CGFloat = 40
    var selectLevelFontSize : CGFloat = 40
    var mazeLevel : Maps = Maps()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Space between collectionview cells
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 20
        
        //Sets size for "Select Level" label
        selectLevelLabel.font = UIFont(name: selectLevelLabel.font.fontName, size: (UIScreen.main.bounds.width/8))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mazeLevel.mazes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LevelCell", for: indexPath) as! LevelSelectCollectionViewCell
        
        cell.levelLabel.text = String(mazeLevel.mazes[indexPath.row].number)
        cell.levelLabel.adjustsFontSizeToFitWidth = true
        cell.levelLabel.font = UIFont(name: cell.levelLabel.font.fontName, size: ((collectionView.bounds.width/3 - 20)/3 + 5))
        
        cell.layer.backgroundColor = UIColor(hexString: "#FBC531").cgColor
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 20;
        
        //x tracks user's unlocked levels
        let x = defaults.object(forKey:"unlocked") as? Int ?? 0
        //Makes locked levels gray
        if x+1 < mazeLevel.mazes[indexPath.row].number{
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.backgroundColor = UIColor.gray.cgColor
        }
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Sets size of each collection view cell
        let yourWidth = collectionView.bounds.width/3 - 20
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(MainMenuViewController.skins[defaults.object(forKey:"skin") as? Int ?? 0].name)
        selectedLevel = mazeLevel.mazes[indexPath.row]
        //Only segue if level is unlocked
        if selectedLevel.number - 1 <= defaults.object(forKey:"unlocked") as? Int ?? 0 {
            performSegue(withIdentifier: "LevelToGame", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "LevelToGame")
        {
            //Pushes data through the segue
            let gameVC = segue.destination as! GameViewController
            gameVC.currentLevel = selectedLevel
            gameVC.allMaps = mazeLevel
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


