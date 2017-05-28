//
//  ViewController.swift
//  IntelllexOnboarding
//
//  Created by Harry Cao on 27/5/17.
//  Copyright © 2017 Harry Cao. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
  
  let cellId = "cellId"
  let lastCellId = "lastCellId"
  
  lazy var onboardingCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.isPagingEnabled = true
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.delegate = self
    collectionView.dataSource = self
    return collectionView
  }()
  
  let onboardingPages: [OnboardingPage] = {
    let helloPage = OnboardingPage(imageName: "hello", title: "INTELLLEX", description: "Your Legal Research and Knowledge Management Platform.")
    let sourcePage = OnboardingPage(imageName: "source", title: "SOURCE", description: "Search externally across 800,000 legal cases, commentaries and legislation.")
    let stacksPage = OnboardingPage(imageName: "stacks", title: "STACKS", description: "Harness the cumulative know-how of your firm.")
    let adminPage = OnboardingPage(imageName: "admin", title: "ADMIN", description: "Manage the knowledge of your firm. Only designated admins have access.")
    return [helloPage, sourcePage, stacksPage, adminPage]
  }()
  
  // Declare pageControll as lazy var so we can access self inside
  lazy var pageControl: UIPageControl = {
    let pageControl = UIPageControl()
    pageControl.currentPageIndicatorTintColor = intelllexYellow
    pageControl.pageIndicatorTintColor = .lightGray
    pageControl.numberOfPages = self.onboardingPages.count + 1
    return pageControl
  }()
  var pageControlConstraints: [NSLayoutConstraint]?
  
  lazy var skipButton: UIButton = {
    let button = UIButton(type: .system)
    let attributedTitle = NSAttributedString(string: "Skip", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold), NSForegroundColorAttributeName: intelllexYellow])
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
    return button
  }()
  var skipButtonConstraints: [NSLayoutConstraint]?
  
  let nextButton: UIButton = {
    let button = UIButton(type: .system)
    let attributedTitle = NSAttributedString(string: "Next", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold), NSForegroundColorAttributeName: intelllexYellow])
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    return button
  }()
  var nextButtonConstraints: [NSLayoutConstraint]?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    addComponents()
    
    observeKeyboardNotificaton()
    
    onboardingCollectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    onboardingCollectionView.register(LoginCollectionViewCell.self, forCellWithReuseIdentifier: lastCellId)
  }
  
  fileprivate func addComponents() {
    self.view.addSubview(onboardingCollectionView)
    self.view.addSubview(pageControl)
    self.view.addSubview(skipButton)
    self.view.addSubview(nextButton)
    
    _ = onboardingCollectionView.constraintAnchorTo(top: self.view.topAnchor, topConstant: 0, bottom: self.view.bottomAnchor, bottomConstant: 0, left: self.view.leftAnchor, leftConstant: 0, right: self.view.rightAnchor, rightConstant: 0)
    
    pageControlConstraints = pageControl.constraintAnchorTo(top: nil, topConstant: nil, bottom: self.view.bottomAnchor, bottomConstant: -10, left: self.view.leftAnchor, leftConstant: 0, right: self.view.rightAnchor, rightConstant: 0)
    _ = pageControl.constraintSizeToConstant(widthConstant: 0, heightConstant: 20)
    
    skipButtonConstraints = skipButton.constraintAnchorTo(top: self.view.topAnchor, topConstant: 15, bottom: nil, bottomConstant: nil, left: self.view.leftAnchor, leftConstant: 0, right: nil, rightConstant: nil)
    _ = skipButton.constraintSizeToConstant(widthConstant: 70, heightConstant: 50)
    
    nextButtonConstraints = nextButton.constraintAnchorTo(top: self.view.topAnchor, topConstant: 15, bottom: nil, bottomConstant: nil, left: nil, leftConstant: nil, right: self.view.rightAnchor, rightConstant: 0)
    _ = nextButton.constraintSizeToConstant(widthConstant: 70, heightConstant: 50)
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    onboardingCollectionView.collectionViewLayout.invalidateLayout()
    
    DispatchQueue.main.async {
      let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
      self.onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      self.onboardingCollectionView.reloadData()
    }
  }
}


extension OnboardingViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return onboardingPages.count + 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if (indexPath.item == onboardingPages.count) {
      let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: lastCellId, for: indexPath) as? LoginCollectionViewCell
      loginCell?.delegate = self
      return loginCell!
    }
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? OnboardingCollectionViewCell
    cell?.onboardingPage = onboardingPages[indexPath.item]
    return cell!
  }
}


extension OnboardingViewController: UICollectionViewDelegate {
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let currentPage = Int(targetContentOffset.pointee.x / onboardingCollectionView.frame.width)
    pageControl.currentPage = currentPage
    hideShowControls(currentPage)
  }
  
  fileprivate func hideShowControls(_ currentPage: Int) {
    if (currentPage == onboardingPages.count) {
      pageControlConstraints?[0].constant = 30
      skipButtonConstraints?[0].constant = -50
      nextButtonConstraints?[0].constant = -50
    } else {
      pageControlConstraints?[0].constant = -10
      skipButtonConstraints?[0].constant = 15
      nextButtonConstraints?[0].constant = 15
    }
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
}


extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
  }
}


extension OnboardingViewController {
  // Setting up the keyboard
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    self.view.endEditing(true)
  }
  
  fileprivate func observeKeyboardNotificaton() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
  }
  
  func keyboardShow(notification: Notification) {
    let distanceLoginButtonAndBottom = self.view.bounds.height/2 - 125
    
    let userInfo: NSDictionary = notification.userInfo! as NSDictionary
    let keyboardFrame: NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
    let keyboardRectangle = keyboardFrame.cgRectValue
    let keyboardHeight = keyboardRectangle.height
    
    let offset = keyboardHeight - distanceLoginButtonAndBottom
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
      self.view.frame = CGRect(x: 0, y: offset > 0 ? -offset - 10 : offset < 10 ? -10 : 0, width: self.view.frame.width, height: self.view.frame.height)
    }, completion: nil)
  }
  
  func keyboardHide() {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    }, completion: nil)
  }
}


extension OnboardingViewController {
  func nextTapped() {
    let destinationPage = pageControl.currentPage + 1
    if (destinationPage == onboardingPages.count + 1) { return }
    else if (destinationPage == onboardingPages.count) {
      hideShowControls(destinationPage)
    }
    
    // Go to the next page (current page indicated by pageControl
    let destinationIndexPath = IndexPath(item: destinationPage, section: 0)
    onboardingCollectionView.scrollToItem(at: destinationIndexPath, at: .centeredHorizontally, animated: true)
    // Manually update pageControll. Tht scrollToItem is not call scrollViewWillEndDragging, so we need to update ourself
    pageControl.currentPage += 1
  }
  
  func skipTapped() {
    pageControl.currentPage = onboardingPages.count - 1
    nextTapped()
  }
}

extension OnboardingViewController: UserLoggedInDelegate {
  func finishLoggingIn() {
    guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
    
    UserDefaults.standard.setIsLoggedIn(value: true)
    
    self.dismiss(animated: false) {
      rootViewController.present(MainViewController(), animated: true, completion: nil)
    }
  }
}
