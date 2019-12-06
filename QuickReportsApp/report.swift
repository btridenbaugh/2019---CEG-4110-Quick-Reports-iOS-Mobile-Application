//
//  report.swift
//  QuickReportsApp
//
//  Created by Ryan DeVilbiss on 11/26/19.
//  Copyright © 2019 WSU. All rights reserved.
//

import Foundation

class Report {
    let id: Int64?
    var desc: String
    var weather: String
    var temp: Int
   // var image
    
    init(id: Int64) {
        self.id = id
        desc = ""
        weather = ""
        temp = 0
        
    }
    init(id: Int64, desc: String, weather: String, temp: Int){
        self.id = id
        self.desc = desc
        self.weather = weather
        self.temp = temp
    }
}
