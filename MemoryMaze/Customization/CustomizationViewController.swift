//
//  CustomizationViewController.swift
//  MemoryMaze
//
//  Created by Garry Fanata on 6/18/19.
//  Copyright © 2019 Garry Fanata. All rights reserved.
//

import UIKit

class CustomizationViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet var collectionView: CustomizationCollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet var selectSkinLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.allowsMultipleSelection = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //no space between collectionview cells
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        selectSkinLabel.font = UIFont(name: selectSkinLabel.font.fontName, size: (UIScreen.main.bounds.width/8))
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainMenuViewController.skins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customizationCell", for: indexPath) as! CustomizationCollectionViewCell
        
        //Fills cell with skin image and name
        cell.skinLabel.text = MainMenuViewController.skins[indexPath.row].name
        cell.skinLabel.textAlignment = .center
        cell.skinLabel.adjustsFontSizeToFitWidth = true
        cell.skinImage.image = MainMenuViewController.skins[indexPath.row].image
        cell.skinImage.layer.borderWidth = 2.5
        cell.skinImage.layer.borderColor = UIColor.black.cgColor
        
        //draws the selected border if skin is the selected skin
        cell.layer.borderWidth = indexPath.row == UserDefaults.standard.object(forKey:"skin") as? Int ?? 0 ? 5.0 : 0.5
        cell.layer.borderColor = indexPath.row == UserDefaults.standard.object(forKey:"skin") as? Int ?? 0 ? UIColor.yellow.cgColor : UIColor.black.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //collectionViewCell width = half the screen and always square
        let yourWidth = collectionView.bounds.width/2
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //removes selected border around if another skin is selected
        let defaults = UserDefaults.standard
        let cell2 = collectionView.cellForItem(at: IndexPath(row: defaults.object(forKey:"skin") as? Int ?? 0, section: 0))
        cell2?.layer.borderColor = UIColor.black.cgColor
        cell2?.layer.borderWidth = 0.5
        
        //draws select border around selected skin
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 5.0
        cell?.layer.borderColor = UIColor.yellow.cgColor
        
        //sets selected skin to the skin in selected cell
        defaults.set(indexPath.row, forKey: "skin")
    }

}
