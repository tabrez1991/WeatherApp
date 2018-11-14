//
//  ViewController.swift
//  Weather_Application
//
//  Created by Tarvez on 09/11/18.
//  Copyright © 2018 Tabrez Ansari. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{

    let apiKey = "your api key"
    var lat = 28.541037
    var lng = 77.398905
    var i: Int = 0
    var s: String = ""
    var flag: Bool = false
    
    let locationManager = CLLocationManager()
    var temp: Array<String> = Array()
    var temp_min: Array<String> = Array()
    var temp_max: Array<String> = Array()
    var pressure: Array<String> = Array()
    var humidity: Array<String> = Array()
    var desc: Array<String> = Array()
    var wind: Array<String> = Array()
    var times: Array<String> = Array()
    var wicons: Array<String> = Array()
    
    @IBOutlet weak var city: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        lat = location.coordinate.latitude
        lng = location.coordinate.longitude
    }

    func calculate(){
        self.wicons.removeAll()
        self.temp.removeAll()
        self.temp_min.removeAll()
        self.temp_max.removeAll()
        self.pressure.removeAll()
        self.humidity.removeAll()
        self.desc.removeAll()
        self.wind.removeAll()
        self.times.removeAll()
        Alamofire.request("http://api.openweathermap.org/data/2.5/forecast?q=\(city.text!)&appid=\(apiKey)").responseJSON {
            response in
            if let responseStr = response.result.value{
                let jsonResponse = JSON(responseStr)
                let jsonWeather = jsonResponse["list"].array
                if let len = jsonWeather{
                    for i in 0..<len.count{
                        self.wicons.append(jsonWeather?[i]["weather"].array?[0]["icon"].stringValue ?? "")
                        self.temp.append(jsonWeather?[i]["main"]["temp"].stringValue ?? "")
                        self.temp_min.append(jsonWeather?[i]["main"]["temp_min"].stringValue ?? "")
                        self.temp_max.append(jsonWeather?[i]["main"]["temp_max"].stringValue ?? "")
                        self.pressure.append(jsonWeather?[i]["main"]["pressure"].stringValue ?? "")
                        self.humidity.append(jsonWeather?[i]["main"]["humidity"].stringValue ?? "")
                        self.desc.append(jsonWeather?[i]["weather"].array?[0]["description"].stringValue ?? "")
                        self.wind.append(jsonWeather?[i]["wind"]["speed"].stringValue ?? "")
                        self.s = jsonWeather?[i]["dt_txt"].stringValue ?? ""
                        let start = self.s.index(self.s.startIndex, offsetBy: 11)
                        self.times.append(self.s.substring(from: start))
                    }
                }
            }
            self.performSegue(withIdentifier: "weather", sender: self)
        }
    }
    
    @IBAction func searchWeather(_ sender: Any) {
        if city.text != "" && flag == false
        {
            calculate()
        }
        else if flag{
            self.flag = false
            performSegue(withIdentifier: "weather", sender: self)
            
        }
        else{
            let alert = UIAlertController(title: "Text box should not be Empty", message: "If you want to use your current location choose one.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondViewContoller = segue.destination as! SecondViewController
        print(wicons.count)
        secondViewContoller.swicons = self.wicons
        secondViewContoller.temp = self.temp
        secondViewContoller.temp_min = self.temp_min
        secondViewContoller.temp_max = self.temp_max
        secondViewContoller.pressure = self.pressure
        secondViewContoller.humidity = self.humidity
        secondViewContoller.desc = self.desc
        secondViewContoller.wind = self.wind
        secondViewContoller.times = self.times
    }
    
    @IBAction func locationWeather(_ sender: Any) {
        self.wicons.removeAll()
        self.temp.removeAll()
        self.temp_min.removeAll()
        self.temp_max.removeAll()
        self.pressure.removeAll()
        self.humidity.removeAll()
        self.desc.removeAll()
        self.wind.removeAll()
        self.times.removeAll()
        Alamofire.request("http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lng)&appid=\(apiKey)").responseJSON {
            response in
            //            self.activityIndicator.stopAnimating()
            if let responseStr = response.result.value{
                let jsonResponse = JSON(responseStr)
                let jsonWeather = jsonResponse["list"].array
                if let len = jsonWeather{
                    for i in 0..<len.count{
                        self.wicons.append(jsonWeather?[i]["weather"].array?[0]["icon"].stringValue ?? "")
                        self.temp.append(jsonWeather?[i]["main"]["temp"].stringValue ?? "")
                        self.temp_min.append(jsonWeather?[i]["main"]["temp_min"].stringValue ?? "")
                        self.temp_max.append(jsonWeather?[i]["main"]["temp_max"].stringValue ?? "")
                        self.pressure.append(jsonWeather?[i]["main"]["pressure"].stringValue ?? "")
                        self.humidity.append(jsonWeather?[i]["main"]["humidity"].stringValue ?? "")
                        self.desc.append(jsonWeather?[i]["weather"].array?[0]["description"].stringValue ?? "")
                        self.wind.append(jsonWeather?[i]["wind"]["speed"].stringValue ?? "")
                        self.s = jsonWeather?[i]["dt_txt"].stringValue ?? ""
                        let start = self.s.index(self.s.startIndex, offsetBy: 11)
                        self.times.append(self.s.substring(from: start))
                    }
                }
            }
            self.city.text = String(self.lat)+","+String(self.lng)
            self.flag = true
        }
    }
}
