//
//  HomePageViewController.swift
//  CameraApp
//
//  Created by macuser on 11/22/19.
//  Copyright © 2019 WSU. All rights reserved.
//

import UIKit
import SQLite3

class HomePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Test")
        if DBManager.shared.createDatabase() {
            
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func fileReport(_ sender: UIButton) {
        performSegue(withIdentifier: "HomeToNewReport", sender: self)
        
    }
    
    @IBAction func openReport(_ sender: UIButton) {
        performSegue(withIdentifier: "HomeToDatabase", sender: self)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
