//
//  ViewController.swift
//  LoadingAnimation
//
//  Created by Antonis papantoniou on 9/16/17.
//  Copyright © 2017 Antonis papantoniou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var circleAnimationView: CircleAnimationView?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    circleAnimationView = CircleAnimationView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    circleAnimationView?.center = view.center
    guard let circleAnimationView = circleAnimationView else { return }
    view.addSubview(circleAnimationView)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

