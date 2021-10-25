//
//  WeatherViewController.swift
//  SSAC_9_WeatherReport
//
//  Created by KEEN on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController {

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
  }

  // MARK: - Configure
  func setLabel(_ labels: [PaddingLabel]) {
    for l in labels {
      l.clipsToBounds = true
      l.layer.cornerRadius = CGFloat(8)
    }
  }

  // MARK: - Actions
  @IBAction func onShareButton(_ sender: UIButton) {
  }
  
  @IBAction func onRefreshButton(_ sender: UIButton) {
  }
  
}

