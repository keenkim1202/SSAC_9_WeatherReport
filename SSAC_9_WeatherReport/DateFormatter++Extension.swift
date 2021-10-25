//
//  DateFormatter++Extension.swift
//  SSAC_9_WeatherReport
//
//  Created by KEEN on 2021/10/25.
//

import Foundation

extension DateFormatter {
  func toDate(date: String) -> Date {
    self.dateFormat = "yyyy년 MM월 dd일 hh시 mm분"
    return self.date(from: date)!
  }
  
  func toString(date: Date) -> String {
    self.dateFormat = "yyyy년 MM월 dd일 hh시 mm분"
    return self.string(from: date)
  }
}
