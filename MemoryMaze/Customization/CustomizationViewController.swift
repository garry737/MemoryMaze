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
    
    var skins : [Skin] = []
    //Singleton - selected skin to use throughout the app
    static var selected : Skin = Skin(name: "Red")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.allowsMultipleSelection = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //no space between collectionview cells
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        //initialize the skins
        skins = [Skin(name: "Blue"),Skin(name: "Green"),Skin(name: "Red"),Skin(name: "Pink"),Skin(name: "Purple"),Skin(name: "Brown"),Skin(name: "Grey"),Skin(name: "White")]
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customizationCell", for: indexPath) as! CustomizationCollectionViewCell
        
        cell.skinLabel.text = skins[indexPath.row].name
        cell.skinLabel.textAlignment = .center
        
        //resizes skinLabel font size if it doesnt fit in label
        cell.skinLabel.adjustsFontSizeToFitWidth = true
        cell.skinImage.image = skins[indexPath.row].image
        cell.skinImage.layer.borderWidth = 2.5
        cell.skinImage.layer.borderColor = UIColor.black.cgColor
        
        //draws the selected border if skin is the selected skin
        cell.layer.borderWidth = skins[indexPath.row].name == CustomizationViewController.selected.name ? 5.0 : 0.5
        cell.layer.borderColor = skins[indexPath.row].name == CustomizationViewController.selected.name ? UIColor.yellow.cgColor : UIColor.black.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //collectionViewCell width = hald the screen
        let yourWidth = collectionView.bounds.width/2
        //collectionViewCell is always square
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
        let cell2 = collectionView.cellForItem(at: IndexPath(row: skins.firstIndex(of: CustomizationViewController.selected)!, section: 0))
        cell2?.layer.borderColor = UIColor.black.cgColor
        cell2?.layer.borderWidth = 0.5
        
        //draws select border around selected skin
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 5.0
        cell?.layer.borderColor = UIColor.yellow.cgColor
        
        //sets selected skin to the skin in selected cell
        CustomizationViewController.selected = skins[indexPath.row]
        print(CustomizationViewController.selected.name)
    }

}
