//
//  DummyRootViewController.swift
//  IntelllexOnboarding
//
//  Created by Harry Cao on 28/5/17.
//  Copyright © 2017 Harry Cao. All rights reserved.
//

import UIKit

class DummyRootViewController: UIViewController {

  override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
    self.view.backgroundColor = .white
    perform(#selector(presentChildViewController), with: nil, afterDelay: 0.01)
  }

  func presentChildViewController() {
    let isLoggedIn = UserDefaults.standard.isLoggedIn()
    let childViewController = isLoggedIn ? MainViewController() : OnboardingViewController()
    self.present(childViewController, animated: false) { 
      // May do something later
    }
  }
}
