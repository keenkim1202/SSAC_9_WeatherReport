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

// TODO: 현재 위치 정보 가져오기
// TODO: 권한에 따른 분기


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
    
    locationManager.requestWhenInUseAuthorization()
    
    setCurrentDate()
    setLabel([temperatureLabel, humidityLabel, windSpeedLabel, feelingLabel])
    
    getCurrentWeather(37.65469539112308, 127.0605780377212)
    getCoordinte(CLLocation(latitude: 37.65469539112308, longitude: 127.0605780377212))
  }
  
  // MARK: - Configure
  func setCurrentDate() {
    let df = DateFormatter()
    df.locale = locale
    dateLabel.text = df.toString(date: Date())
  }
  
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
        
        let temp = json["main"]["temp"].doubleValue - 273.15
        let humidity = json["main"]["humidity"].stringValue
        let windSpeed = json["wind"]["speed"].stringValue
        
        self.temperatureLabel.text = "지금은 \(round(temp)) 'C 에요"
        self.humidityLabel.text = "\(humidity) % 만큼 습해요"
        self.windSpeedLabel.text = "\(windSpeed) m/s의 바람이 불어요"
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
