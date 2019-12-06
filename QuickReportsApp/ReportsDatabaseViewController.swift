//
//  ReportsDatabaseViewController.swift
//  CameraApp
//
//  Created by macuser on 11/22/19.
//  Copyright © 2019 WSU. All rights reserved.
//

import UIKit
import SQLite3

class ReportsDatabaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    
    @IBOutlet weak var reportDesc: UILabel!
    @IBOutlet weak var lookupID: UITextField!
    @IBOutlet weak var WeatherReturn: UILabel!
    @IBOutlet weak var tempReturn: UILabel!
    @IBOutlet weak var ImageReturn: UIImageView!
    
    
    @IBAction func openReport(_ sender: UIButton) {
        //Enter code to open report form database here
        //performSegue(withIdentifier: "DatabaseToReport", sender: self)
        let lookupIDInt :Int? = Int(lookupID.text!)
        reportDesc.text = DBManager.shared.getDesc(reportID: lookupIDInt ?? 0)
        WeatherReturn.text = DBManager.shared.getWeather(reportID: lookupIDInt ?? 0)
        let tempConvert = DBManager.shared.getTemp(reportID: lookupIDInt ?? 0)
        tempReturn.text = "\(tempConvert) °F"
        let ImgString = DBManager.shared.getImage(reportID: lookupIDInt ?? 0) //image
        print("Now getting image")
        
        let Decodedimage = base64ToImage(ImgString)
        
        ImageReturn.image = Decodedimage
        
        print("Image should display now")
        
        
    }
    
    func base64ToImage(_ base64String: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64String) else { return nil }
        print(imageData)
        return UIImage(data: imageData)
    }
    
    
}
