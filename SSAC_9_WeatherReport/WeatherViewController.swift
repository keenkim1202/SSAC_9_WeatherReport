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

// TODO: 권한에 따른 분기..?

class WeatherViewController: UIViewController {
  
  // MARK: - Properties
  let locationManager = CLLocationManager()
  let locale = Locale(identifier: "Ko-kr")
  
  var currentLocation: CLLocation?
  
    // for test.
//  var latitude: Double = 37.65469539112308
//  var longitude: Double = 127.0605780377212
  
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
    textBeforeGetLocationAuthorization()
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    
    if CLLocationManager.locationServicesEnabled() {
      print("위치 서비스 On 상태")
      locationManager.startUpdatingLocation() //위치 정보 받아오기 시작
    } else {
      print("위치 서비스 Off 상태")
    }
    
    setCurrentDate()
    setLabel([temperatureLabel, humidityLabel, windSpeedLabel, feelingLabel])
  }
  
  // MARK: - Configure
  func textBeforeGetLocationAuthorization() {
    locationLabel.text = "위치 권한 대기중"
    temperatureLabel.text = "지금 몇도일까..?"
    humidityLabel.text = "습도는 얼마일까..?"
    windSpeedLabel.text = "풍속은 얼마일까..?"
    feelingLabel.text = "위치 권한이 없어서 슬퍼요 :("
  }
  
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
  
  func getAddress(_ coordinate: CLLocation) {
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
  
  fileprivate func showAlert(_ message: String) {
    UIAlertController.show(self, contentType: .error, message: message)
  }
  
  // MARK: - Actions
  @IBAction func onShareButton(_ sender: UIButton) {
  }
  
  @IBAction func onRefreshButton(_ sender: UIButton) {
    if let location = currentLocation {
      let coor = location.coordinate
      getCurrentWeather(coor.latitude, coor.longitude)
    } else {
     showAlert("현재 위치 정보 불러오기 실패")
    }
  }
}

// MARK: Extension - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print(#function)
    // 사용자의 위치 정보를 위도 경도 변수에 저장.
    if let location = locations.first {
      currentLocation = location
      
      if let current = currentLocation {
        let coor = current.coordinate
        getCurrentWeather(coor.latitude, coor.longitude)
        getAddress(CLLocation(latitude: coor.latitude, longitude: coor.longitude))
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(#function)
    print(error)
  }
}
