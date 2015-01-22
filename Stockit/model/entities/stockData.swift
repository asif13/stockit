//
//  stockData.swift
//  Stockit
//
//  Created by Nitesh Agarwal on 04/01/15.
//  Copyright (c) 2015 erudite. All rights reserved.
//

import Foundation

class stockData{
    var name:String
    var exch:String
    var symbol:String
    
    init(name:String, exch:String, symbol:String){
        self.name = name
        self.exch = exch
        self.symbol = symbol
    }
}