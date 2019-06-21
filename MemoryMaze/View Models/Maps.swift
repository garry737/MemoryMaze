//
//  Maps.swift
//  MemoryMaze
//
//  Created by Garry Fanata on 6/21/19.
//  Copyright © 2019 Garry Fanata. All rights reserved.
//

import Foundation

class Maps{
    var mazes : [Maze]
    var progress : Int
    
    init(){
        self.mazes = []
        self.progress = 0
    }
    
    init(mazes : [Maze]){
        self.mazes = mazes
        self.progress = 0
    }
    
    func addMaze(m : Maze){
        self.mazes.append(m)
    }
    
    func completeMaze(m : Maze){
        self.progress = self.mazes.firstIndex(of: m)!
    }
}
