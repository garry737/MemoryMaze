//
//  Maze.swift
//  MemoryMaze
//
//  Created by Garry Fanata on 6/21/19.
//  Copyright © 2019 Garry Fanata. All rights reserved.
//

import Foundation
import UIKit

class Maze : Equatable{
    
    var number : Int
    var start : (Int,Int)
    var end : (Int,Int)
    var walls : [(Int,Int)]
    var completed : Bool
    
    init(){
        self.number = 0
        self.start = (0,0)
        self.end = (0,0)
        self.walls = []
        self.completed = false
    }
    
    init(number : Int, start : (Int,Int), end : (Int,Int), walls : [(Int,Int)]) {
        self.number = number
        self.start = start
        self.end = end
        self.walls = walls
        self.completed = false
    }
    
    func complete() -> Void {
        completed = true
    }
    
    static func == (lhs: Maze, rhs: Maze) -> Bool {
        if (lhs.walls.count != rhs.walls.count) || (lhs.start != rhs.start && lhs.end != rhs.end ){
            return false
        }
        for x in 0..<lhs.walls.count{
            if (lhs.walls[x].0 != rhs.walls[x].0) || (lhs.walls[x].1 != rhs.walls[x].1) {
                return false
            }
        }
        return true
    }
    
    
}
