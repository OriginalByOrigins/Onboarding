//
//  OnboardingCollectionViewCell.swift
//  IntelllexOnboarding
//
//  Created by Harry Cao on 27/5/17.
//  Copyright © 2017 Harry Cao. All rights reserved.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
  var onboardingPage: OnboardingPage? {
    didSet {
      guard let onboardingPage = onboardingPage else { return }
      
      let isPortrait = UIDevice.current.orientation.isPortrait
      let imageName = onboardingPage.imageName + (isPortrait ? "" : "_landscape")
      backgroundImageView.image = UIImage(named: imageName)
      
      let textColor = UIColor(white: 0.4, alpha: 1)
      
      let attributedText = NSMutableAttributedString(string: onboardingPage.title, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold), NSForegroundColorAttributeName: textColor])
      
      attributedText.append(NSAttributedString(string: "\n\n\(onboardingPage.description)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: textColor]))
      
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .center
      
      let length = attributedText.string.characters.count
      attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: length))
      
      textView.attributedText = attributedText
    }
  }
  
  let backgroundImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let textView: UITextView = {
    let textView = UITextView()
    textView.backgroundColor = .white
    textView.textAlignment = .center
    textView.isScrollEnabled = false
    textView.isUserInteractionEnabled = false
    return textView
  }()
  
  let separatorLine: UIView = {
    let line = UIView()
    line.backgroundColor = .lightGray
    return line
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    
    self.addSubview(backgroundImageView)
    self.addSubview(textView)
    self.addSubview(separatorLine)
    
    _ = backgroundImageView.constraintAnchorTo(top: self.topAnchor, topConstant: 0, bottom: separatorLine.topAnchor, bottomConstant: 0, left: self.leftAnchor, leftConstant: 0, right: self.rightAnchor, rightConstant: 0)
    
    _ = textView.constraintAnchorTo(top: nil, topConstant: nil, bottom: self.bottomAnchor, bottomConstant: 0, left: self.leftAnchor, leftConstant: 10, right: self.rightAnchor, rightConstant: -10)
    let textViewHeightMultiplier = CGFloat(0.3)
    _ = textView.constraintSizeToMultipler(widthAnchor: nil, widthMultiplier: nil, heightAnchor: self.heightAnchor, heightMultiplier: textViewHeightMultiplier)
    
    let textViewTopPadding = self.bounds.height*textViewHeightMultiplier / 2 - 80
    textView.textContainerInset = UIEdgeInsets(top: textViewTopPadding > 10 ? textViewTopPadding : 10, left: 0, bottom: 0, right: 0)
    
    _ = separatorLine.constraintAnchorTo(top: nil, topConstant: nil, bottom: textView.topAnchor, bottomConstant: 0, left: self.leftAnchor, leftConstant: 0, right: self.rightAnchor, rightConstant: 0)
    _ = separatorLine.constraintSizeToConstant(widthConstant: nil, heightConstant: 1)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
