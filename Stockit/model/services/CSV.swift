//
//  CSV.swift
//  Stockit
//
//  Created by Nitesh Agarwal on 22/01/15.
//  Copyright (c) 2015 erudite. All rights reserved.
//

import Foundation

class CSV {
    let headers: [String] = []
    let rows: [Dictionary<String, String>] = []
    let columns = Dictionary<String, [String]>()
    let delimiter = NSCharacterSet(charactersInString: ",")

    init?(csvData data: String, delimiter: NSCharacterSet, error: NSErrorPointer) {
        
        self.delimiter = delimiter
        
        let newline = NSCharacterSet.newlineCharacterSet()
        var lines: [String] = []
        data.stringByTrimmingCharactersInSet(newline).enumerateLines{ line, stop in lines.append(line) }
        
        self.headers = self.parseHeaders(fromLines: lines)
        self.rows = self.parseRows(fromLines: lines)
        self.columns = self.parseColumns(fromLines: lines)
    }
    
    convenience init?(csvData data:String, error:NSErrorPointer) {
        let comma = NSCharacterSet(charactersInString: ",")
        self.init(csvData: data, delimiter: comma, error: error)
    }


    func parseHeaders(fromLines lines: [String]) -> [String] {
        return lines[0].componentsSeparatedByCharactersInSet(self.delimiter)
    }

    func parseRows(fromLines lines: [String]) -> [Dictionary<String, String>] {
        var rows: [Dictionary<String, String>] = []
        
        for (lineNumber, line) in enumerate(lines) {
            if lineNumber == 0 {
                continue
            }
            
            var row = Dictionary<String, String>()
            let values = line.componentsSeparatedByCharactersInSet(self.delimiter)
            for (index, header) in enumerate(self.headers) {
                let value = values[index]
                row[header] = value
            }
            rows.append(row)
        }
        
        return rows
    }

    func parseColumns(fromLines lines: [String]) -> Dictionary<String, [String]> {
        var columns = Dictionary<String, [String]>()
        
        for header in self.headers {
            let column = self.rows.map { row in row[header]! }
            columns[header] = column
        }
        return columns
    }
}
