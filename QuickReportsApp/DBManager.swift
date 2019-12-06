//
//  DBManager.swift
//  QuickReportsApp
//
//  Created by Ryan DeVilbiss on 12/1/19.
//  Copyright © 2019 WSU. All rights reserved.
//

import UIKit

class DBManager: NSObject {

    
    static let shared: DBManager = DBManager()
    
    let databaseFileName = "database.sqlite"
     
    var pathToDatabase: String!
     
    var database: FMDatabase!
        
    let field_ReportID = "reportID"
    let field_ReportDesc = "desc"
    let field_ReportWeather = "weather"
    let field_ReportTemp = "temp"
    let field_ReportImage = "image"


    func createDatabase() -> Bool {
        var created = false
     print("got here1")
        print(pathToDatabase)
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
            print("got here")
            if database != nil {
                // Open the database.
                if database.open() {
                    let createReportsTableQuery = "create table reports (\(field_ReportID) integer primary key autoincrement not null, \(field_ReportDesc) text, \(field_ReportTemp) integer, \(field_ReportWeather) text, \(field_ReportImage) text)"
     
                    do {
                        try database.executeUpdate(createReportsTableQuery, values: nil)
                        created = true
                        print("Could create table.")
                    }
                    catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
     
                    // At the end close the database.
                    database.close()
                }
                else {
                    print("Could not open the database.")
                }
            }
        }
     
        return created
    }
    

    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
     
        if database != nil {
            if database.open() {
                return true
            }
        }
     
        return false
    }
    
  
    func insertReportData(reportDesc: String, reportTemp: Int, reportWeather: String, reportImage: String) {
        // Open the database.
        if openDatabase() {
            do{
                print("inserting data")
            var query = ""
            query += "insert into reports (\(field_ReportID), \(field_ReportDesc), \(field_ReportTemp), \(field_ReportWeather), \(field_ReportImage)) values (null, '\(reportDesc)', '\(reportTemp)', '\(reportWeather)', '\(reportImage)')"
                
            if !database.executeStatements(query) {
                print("Failed to insert initial data into the database.")
                print(database.lastError(), database.lastErrorMessage())
                }
            }
            catch{
                print(error.localizedDescription)
            
            }
        }
    }
    
    func getDesc(reportID: Int) -> String {
        var returnValue = ""
        do {
        let query = "select * from reports where \(field_ReportID)=?"
            let results =  try database.executeQuery(query, values: [reportID])
            while results.next() {
                returnValue = results.string(forColumn: field_ReportDesc)!
            }
    } catch {
            print(error.localizedDescription)
        }
        return returnValue
    }
    func getTemp(reportID: Int) -> Int32 {
        var returnValue = Int32()
        do {
        let query = "select * from reports where \(field_ReportID)=?"
            let results =  try database.executeQuery(query, values: [reportID])
            while results.next() {
                returnValue = results.int(forColumn: field_ReportTemp)
            }
    } catch {
            print(error.localizedDescription)
        }
        return returnValue
    }
    func getWeather(reportID: Int) -> String {
        var returnValue = ""
        do {
        let query = "select * from reports where \(field_ReportID)=?"
            let results =  try database.executeQuery(query, values: [reportID])
            while results.next() {
                returnValue = results.string(forColumn: field_ReportWeather)!
            }
    } catch {
            print(error.localizedDescription)
        }
        return returnValue
    }
    func getImage(reportID: Int) -> String {
        var returnValue = ""
        do {
        let query = "select * from reports where \(field_ReportID)=?"
            let results =  try database.executeQuery(query, values: [reportID])
            while results.next() {
                returnValue = results.string(forColumn: field_ReportImage)!
            }
    } catch {
            print(error.localizedDescription)
        }
        return returnValue
    }
    
    override init() {
        super.init()
     
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
}
