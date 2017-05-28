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

  override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
    self.view.backgroundColor = intelllexYellow
    self.view.addSubview(logoutButton)
    _ = logoutButton.constraintCenterTo(centerX: self.view.centerXAnchor, xConstant: 0, centerY: self.view.centerYAnchor, yConstant: 150)
    _ = logoutButton.constraintSizeToConstant(widthConstant: 250, heightConstant: 50)
  }
  
  func handleLogout() {
    guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
    
    UserDefaults.standard.setIsLoggedIn(value: false)
    
    self.dismiss(animated: true) { 
      rootViewController.present(OnboardingViewController(), animated: false, completion: nil)
    }
  }
}
