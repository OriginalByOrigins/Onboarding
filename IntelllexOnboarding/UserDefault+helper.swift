//
//  UserDefault+helper.swift
//  IntelllexOnboarding
//
//  Created by Harry Cao on 28/5/17.
//  Copyright © 2017 Harry Cao. All rights reserved.
//

import Foundation


extension UserDefaults {
  enum UserDefaultsKeys: String {
    case isLoggedIn = "isLoggedIn"
  }
  
  func setIsLoggedIn(value: Bool) {
    self.set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    self.synchronize()
  }
  
  func isLoggedIn() -> Bool {
    return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
  }
}
