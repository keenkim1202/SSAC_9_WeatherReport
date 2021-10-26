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

// TODO: APIKEY 파일 안에 apikey를 작성해주세요.

class WeatherViewController: UIViewController {
  
  // MARK: - Properties
  let locationManager = CLLocationManager()
  let locale = Locale(identifier: "Ko-kr")
  
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
    
    // 위치권한 확인하는 알c림창 뜨도록 체크.
    locationManager.requestWhenInUseAuthorization()
    
    setLabel([temperatureLabel, humidityLabel, windSpeedLabel, feelingLabel])
    getCurrentWeather(37.65469539112308, 127.0605780377212)
    
    getCoordinte(CLLocation(latitude: 37.65469539112308, longitude: 127.0605780377212))
  }
  
  // MARK: - Configure
  func setLabel(_ labels: [PaddingLabel]) {
    for l in labels {
      l.clipsToBounds = true
      l.layer.cornerRadius = CGFloat(8)
    }
  }
  
  func getCurrentWeather(_ latitude: Double, _ longitude: Double) {
    let apikey = Bundle.main.apiKey
    let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apikey)"
    
    AF.request(url, method: .get).validate().responseJSON { response in
      switch response.result {
      case .success(let value):
        let json = JSON(value)
        let humidity = json["main"]["humidity"].stringValue
        let temp = json["main"]["temp"].doubleValue - 273.15
        let windSpeed = json["wind"]["speed"].stringValue
        self.humidityLabel.text = "\(humidity) %"
        self.temperatureLabel.text = "\(temp) 도"
        self.windSpeedLabel.text = "\(windSpeed) m/s"
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func getCoordinte(_ coordinate: CLLocation) {
    let geoCoder = CLGeocoder()
    
    geoCoder.reverseGeocodeLocation(coordinate, preferredLocale: locale, completionHandler: {(placemarks, error) in
      if let address: [CLPlacemark] = placemarks {
        guard let city: String = address.last?.administrativeArea else { return }
        guard let gu: String = address.last?.locality else { return }
        guard let dong: String = address.last?.subLocality else { return }
        
        self.locationLabel.text = "\(city), \(gu) \(dong)"
      }
    })
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
