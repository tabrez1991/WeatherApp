//
//  SecondViewController.swift
//  Weather_Application
//
//  Created by Tarvez on 09/11/18.
//  Copyright © 2018 Tabrez Ansari. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var i:Int = 0
    
    var temp: Array<String> = Array()
    var temp_min: Array<String> = Array()
    var temp_max: Array<String> = Array()
    var pressure: Array<String> = Array()
    var humidity: Array<String> = Array()
    var desc: Array<String> = Array()
    var wind: Array<String> = Array()
    var times: Array<String> = Array()
    var swicons: Array<String> = Array()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (swicons.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherTableViewCell
        cell.icon_w.image = UIImage(named: swicons[indexPath.row]+".png")
        cell.title.text = desc[indexPath.row]
        cell.subtitle.text = "Time: "+times[indexPath.row]+", Temprature: "+temp[indexPath.row]+", Minimum: "+temp_min[indexPath.row]+", Maximum: "+temp_max[indexPath.row]+", Pressure: "+pressure[indexPath.row]+",Humidity: "+humidity[indexPath.row]+", Wind: "+wind[indexPath.row]
        return (cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
