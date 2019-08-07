//
//  Climate.swift
//  Weather
//
//  Created by Humaxvina on 8/8/19.
//  Copyright © 2019 Humaxvina. All rights reserved.
//

import UIKit

class Climate: Codable {
    var id: Int?
    var name: String?
    var cod: Int?
    var message: String?
    var weather: [Weather]?
    var main: Main?
}

class Weather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

class Main: Codable {
    var temp: Float?
    var pressure: Float?
    var humidity: Float?
    var temp_min: Float?
    var temp_max: Float?
}
