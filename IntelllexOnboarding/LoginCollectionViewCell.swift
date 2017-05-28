//
//  LoginCollectionViewCell.swift
//  IntelllexOnboarding
//
//  Created by Harry Cao on 28/5/17.
//  Copyright © 2017 Harry Cao. All rights reserved.
//

import UIKit

class LoginCollectionViewCell: UICollectionViewCell {
  weak var delegate: UserLoggedInDelegate?
  
  let intelllexLogoImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "intelllex"))
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  let emailTextField: LeftPaddedTextField = {
    let textField = LeftPaddedTextField()
    textField.placeholder = "Email"
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.keyboardType = .emailAddress
    return textField
  }()
  
  let passwordTextField: LeftPaddedTextField = {
    let textField = LeftPaddedTextField()
    textField.placeholder = "Password"
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.isSecureTextEntry = true
    return textField
  }()
  
  lazy var loginButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Login", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = intelllexYellow
    button.layer.cornerRadius = 5
    button.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(intelllexLogoImageView)
    self.addSubview(emailTextField)
    self.addSubview(passwordTextField)
    self.addSubview(loginButton)
    
//    _ = intelllexLogoImageView.constraintAnchorTo(top: nil, topConstant: nil, bottom: self.centerYAnchor, bottomConstant: -80, left: nil, leftConstant: nil, right: nil, rightConstant: nil)
    _ = intelllexLogoImageView.constraintSizeToConstant(widthConstant: 280, heightConstant: 70)
    _ = intelllexLogoImageView.constraintCenterTo(centerX: self.centerXAnchor, xConstant: 0, centerY: self.centerYAnchor, yConstant: -80)
    
    _ = emailTextField.constraintAnchorTo(top: intelllexLogoImageView.bottomAnchor, topConstant: 8, bottom: nil, bottomConstant: nil, left: self.leftAnchor, leftConstant: 40, right: self.rightAnchor, rightConstant: -40)
    _ = emailTextField.constraintSizeToConstant(widthConstant: nil, heightConstant: 40)
    
    _ = passwordTextField.constraintAnchorTo(top: emailTextField.bottomAnchor, topConstant: 16, bottom: nil, bottomConstant: nil, left: self.leftAnchor, leftConstant: 40, right: self.rightAnchor, rightConstant: -40)
    _ = passwordTextField.constraintSizeToConstant(widthConstant: nil, heightConstant: 40)
    
    _ = loginButton.constraintAnchorTo(top: passwordTextField.bottomAnchor, topConstant: 16, bottom: nil, bottomConstant: nil, left: self.leftAnchor, leftConstant: 40, right: self.rightAnchor, rightConstant: -40)
    _ = loginButton.constraintSizeToConstant(widthConstant: nil, heightConstant: 50)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension LoginCollectionViewCell {
  func handleLogIn() {
    delegate?.finishLoggingIn()
  }
}
