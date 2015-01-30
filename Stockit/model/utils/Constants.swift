//
//  Constants.swift
//  NewApp
//
//  Created by Nitesh Agarwal on 02/01/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import Foundation

class Constants:NSObject
{
    
    class var STOCK_SEARCH_URL:String {return "http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=goog&callback=YAHOO.Finance.SymbolSuggest.ssCallback"}
    
    class var STOCK_DATA_URL:String {return "http://ichart.finance.yahoo.com/table.csv?s=GOOG&d=0&e=28&f=2015&g=d&a=3&b=12&c=2006&ignore=.csv"}
    
}