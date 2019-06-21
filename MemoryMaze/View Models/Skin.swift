//
//  Skin.swift
//  MemoryMaze
//
//  Created by Garry Fanata on 6/19/19.
//  Copyright © 2019 Garry Fanata. All rights reserved.
//

import Foundation
import UIKit

class Skin: Equatable {
    var name : String
    var image : UIImage
    
    init(name: String) {
        self.name = name
        self.image = UIImage(named: name) ?? UIImage(named: "default")!
    }
    
    //function to check if skins are equal
    static func == (lhs: Skin, rhs: Skin) -> Bool {
        return lhs.name == rhs.name
    }

}
