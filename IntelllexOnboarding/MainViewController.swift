//
//  MainViewController.swift
//  IntelllexOnboarding
//
//  Created by Harry Cao on 28/5/17.
//  Copyright © 2017 Harry Cao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  lazy var logoutButton: UIButton = {
    let button = UIButton()
    let attributedTitle = NSAttributedString(string: "Logout", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 24, weight: UIFontWeightBold), NSForegroundColorAttributeName: UIColor.gray])
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.backgroundColor = .white
    button.layer.cornerRadius = 10
    button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
    return button
  }()
  
  lazy var clock: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.text = self.currentTime()
    label.textAlignment = .center
    label.font = UIFont.init(name: "HelveticaNeue", size: 80)
    return label
  }()
  
  var timer = Timer()

  override func viewDidLoad() {
    super.viewDidLoad()

      // Do any additional setup after loading the view.
    self.view.backgroundColor = intelllexYellow
    self.view.addSubview(clock)
    self.view.addSubview(logoutButton)
    
    _ = clock.constraintAnchorTo(top: nil, topConstant: nil, bottom: self.view.centerYAnchor, bottomConstant: -100, left: self.view.leftAnchor, leftConstant: 0, right: self.view.rightAnchor, rightConstant: 0)
    _ = clock.constraintSizeToConstant(widthConstant: nil, heightConstant: 100)
    _ = logoutButton.constraintCenterTo(centerX: self.view.centerXAnchor, xConstant: 0, centerY: nil, yConstant: nil)
    _ = logoutButton.constraintAnchorTo(top: nil, topConstant: nil, bottom: self.view.bottomAnchor, bottomConstant: -150, left: nil, leftConstant: nil, right: nil, rightConstant: nil)
    _ = logoutButton.constraintSizeToConstant(widthConstant: 250, heightConstant: 50)
    
    scheduledUpdateClock()
  }
  
  func handleLogout() {
    guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
    
    UserDefaults.standard.setIsLoggedIn(value: false)
    
    self.dismiss(animated: true) { 
      rootViewController.present(OnboardingViewController(), animated: false, completion: nil)
    }
  }
}

extension MainViewController {
  func currentTime() -> String {
    let date = Date()
    let calendar = Calendar.current
    
    let hour = calendar.component(.hour, from: date)
    let minutes = calendar.component(.minute, from: date)
    let seconds = calendar.component(.second, from: date)
    
    let twoDigitsHour = self.getTwoDigits(hour)
    let twoDigitsMinutes = self.getTwoDigits(minutes)
    let twoDigitsSeconds = self.getTwoDigits(seconds)
    
    return "\(twoDigitsHour):\(twoDigitsMinutes):\(twoDigitsSeconds)"
  }
  
  func scheduledUpdateClock() {
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
      self.clock.text = self.currentTime()
    }
  }
  
  func getTwoDigits(_ number: Int) -> String {
    return number > 9 ? String(number) : "0" + String(number)
  }
}
