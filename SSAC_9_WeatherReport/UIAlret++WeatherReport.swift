//
//  UIAlret++WeatherReport.swift
//  SSAC_9_WeatherReport
//
//  Created by KEEN on 2021/10/26.
//

import UIKit

extension UIAlertController {
  enum ContentType: String {
    case error = "⚠️ 오류 🤯"
  }
  
  static func show(_ presentedHost: UIViewController,
                   contentType: ContentType,
                   message: String) {
    let alert = UIAlertController(
      title: contentType.rawValue,
      message: message,
      preferredStyle: .alert)
    let okAction = UIAlertAction(
      title: "확인", style: .default, handler: nil)
    alert.addAction(okAction)
    presentedHost.present(alert, animated: true, completion: nil)
  }
}
