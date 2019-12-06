//
//  NewReportViewController.swift
//  CameraApp
//
//  Created by macuser on 11/22/19.
//  Copyright © 2019 WSU. All rights reserved.
//

import UIKit
import SQLite3
import MapKit
import DarkSkyKit

class NewReportViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    let forecastClient = DarkSkyKit(apiToken: "434903c7059ad4d055599b2fd86b52de")
    @IBOutlet weak var Weather_Label: UILabel!
    @IBOutlet weak var Temp_Label: UILabel!
    var locationManager = CLLocationManager()
    var long = Double()
    var lat = Double()
    var control = 0
    var weather = String()
    var temp = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Weather API
               self.locationManager.requestWhenInUseAuthorization()
                      
                      //If Authorized then it moves on to the locationManager function
                      if CLLocationManager.locationServicesEnabled() {
                          
                          locationManager.delegate = self
                          locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                          locationManager.startUpdatingLocation()
                      }
        //Weather API
    }
    
    //Weather API
    func getWeather(){
        //Based upon the DarkSkyKit podfile usage instructions, passes in the coordinates
        forecastClient.current(latitude: lat, longitude: long) { result in
          switch result {
            case .success(let forecast):
              //Gets the current forcats
              if let current = forecast.currently {
                self.temp = current.temperature!
                self.weather = current.summary! //This is the weather condition (Ex: Cloudy)
                //location = current.city
                //print("\(location)")
                self.Weather_Label.text = self.weather //Updating the UI Labels...
                self.Temp_Label.text = "\(self.temp) °F"
                //self.Lat_Label.text = "\(self.lat)"
                //self.Long_Label.text = "\(self.long)"
              }
          case .failure(let error): break
              // Manage error case
              //Didnt know what to put here for the moment
          }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Gets location of the person/phone
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        //Testing coordinates print statement
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        //Setting the global variables
        lat = locValue.latitude
        long = locValue.longitude
        //Calls the getWeather function to update the weather based off of the coordinates
        if (control == 0){
            getWeather()
            control = control + 1 //It was updating too much so I did this for a one time update
        }
    }
    //Weather API
    
    
    
    @IBAction func toCamera(_ sender: Any) {
        performSegue(withIdentifier: "NewReportToCamera", sender: self)
    }
    
    
    
    
    
    //Camera
    @IBOutlet weak var ImageDisplay: UIImageView!
    @IBAction func PhotoLibraryAction(_ sender: UIButton) {
           let picker = UIImagePickerController()
           
           picker.delegate = self
           picker.sourceType = .photoLibrary
           
           present(picker, animated: true, completion: nil)
       }
       
       
       @IBAction func CameraAction(_ sender: UIButton) {
           let picker = UIImagePickerController()
           
           picker.delegate = self
           picker.sourceType = .camera
           
           present(picker, animated: true, completion: nil)
       }
       
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           ImageDisplay.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage; dismiss(animated: true, completion: nil)

       }
    //Camera
    
    
    
    

    @IBOutlet weak var descriptionEntry: UITextField!
    @IBAction func save(_ sender: Any) {
        
        let imageFile = ImageDisplay.image
       // mYourImageViewOutlet.image = yourImage
       // let image : UIImage = UIImage(named:"ImageDisplay.image")!
        //let imageData:NSData = (ImageDisplay.image ?? imageFile).pngData()! as NSData
        let strBase64 = imageToBase64(imageFile!)
       // print(strBase64)
        let descString = descriptionEntry.text
        let tempInt = Int(temp)
        let weathCond = weather
        DBManager.shared.insertReportData(reportDesc: descString!, reportTemp: tempInt, reportWeather: weathCond, reportImage: strBase64!)
        print("data has been inserted")
    }
    
    func imageToBase64(_ image: UIImage) -> String? {
        return image.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
    
    //Back Button NEEDS SET UP???
    
    @IBOutlet weak var goBack: NSLayoutConstraint!
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
