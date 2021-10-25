//
//  WeatherViewController.swift
//  SSAC_9_WeatherReport
//
//  Created by KEEN on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

// TODO: APIKEY 파일안에 apikey를 작성해주세요.

class WeatherViewController: UIViewController {
  
  // MARK: - Properties
  let locationManager = CLLocationManager()
  
  var latitude: Double?
  var longitude: Double?
  
  // MARK: - UI
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  
  @IBOutlet weak var temperatureLabel: PaddingLabel!
  @IBOutlet weak var humidityLabel: PaddingLabel!
  
  @IBOutlet weak var windSpeedLabel: PaddingLabel!
  @IBOutlet weak var feelingLabel: PaddingLabel!
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setLabel([temperatureLabel, humidityLabel, windSpeedLabel, feelingLabel])
    getCurrentWeather(37.65469539112308, 127.0605780377212)
  }
  
  // MARK: - Configure
  func setLabel(_ labels: [PaddingLabel]) {
    for l in labels {
      l.clipsToBounds = true
      l.layer.cornerRadius = CGFloat(8)
    }
  }
  
  func getCurrentWeather(_ latitude: Double, _ longitude: Double) {
    let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(APIKEY.apikey)"
    AF.request(url, method: .get).validate().responseJSON { response in
      switch response.result {
      case .success(let value):
        let json = JSON(value)
        print("JSON: \(json)")
      case .failure(let error):
        print(error)
      }
    }
  }
  
  // MARK: - Actions
  @IBAction func onShareButton(_ sender: UIButton) {
  }
  
  @IBAction func onRefreshButton(_ sender: UIButton) {
  }
  
}

// MARK: Extension - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
  
}
