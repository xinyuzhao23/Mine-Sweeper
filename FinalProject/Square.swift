//
//  Square.swift
//  FinalProject
//
//  Created by Xinyu Zhao and Molly Zhang on 11/22/15.
//  Copyright © 2015 Xinyu Zhao and Molly Zhang. All rights reserved.
//

import Foundation

class Square {
    let row:Int
    let col:Int
    // give these default values that we will re-assign later with each new game
    var numNeighboringMines = 0
    var isMineLocation = false
    var isRevealed = false
    var title = ""
    var button: SquareButton?
    
    init(row:Int, col:Int) {
        //store the row and column of the square in the grid
        self.row = row
        self.col = col
    }
}
