//
//  ViewController.swift
//  TinkoffChat
//
//  Created by Konstantin on 16/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit
import SnapKit

// i like write user interface in code) here used this way
class ZoomUserImageViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    lazy var singleTapGestureRecognizer = UITapGestureRecognizer()
    lazy var doubleTapGestureRecognizer = UITapGestureRecognizer()
    lazy var hadlePinchDouble = UIPinchGestureRecognizer()
    var userImage = UIImageView()
    var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        scrollView.zoomScale = 1
        
        userImage.backgroundColor = UIColor(white: 0.2, alpha: 0.2)
        userImage.contentMode = .scaleAspectFit
        userImage.clipsToBounds = true
        
        scrollView.addSubview(userImage)
        view.addSubview(scrollView)
        
        setGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        // SnapKit library for set constraints
        scrollView.snp.makeConstraints { (make) in
            
            make.top.lessThanOrEqualTo(view)
            make.bottom.equalTo(view)
            make.right.left.equalTo(view)
            make.width.equalTo(view)
        }
        
        userImage.snp.makeConstraints { (make) in
            
            make.bottom.equalTo(scrollView)
            make.top.equalTo(scrollView.snp.top)
            make.left.equalTo(scrollView.snp.left)
            make.right.equalTo(scrollView.snp.right)
            make.height.equalTo(scrollView.snp.height)
            make.width.equalTo(scrollView)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return gestureRecognizer === singleTapGestureRecognizer && otherGestureRecognizer === doubleTapGestureRecognizer
    }
    
    // set tap gesture on one, two and swipe taps.
    func setGestureRecognizer() {
        singleTapGestureRecognizer.addTarget(self, action: #selector(ZoomUserImageViewController.hadleSingleTap(recognizer:)))
        doubleTapGestureRecognizer.addTarget(self, action: #selector(ZoomUserImageViewController.handleDoubleTap(recognizer:)))
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        hadlePinchDouble.addTarget(self, action: #selector(hadlePinch(sender: )))
        swipeDown.direction = .down
        swipeRight.direction = .right
        swipeUp.direction = .up
        
        scrollView.addGestureRecognizer(swipeDown)
        scrollView.addGestureRecognizer(swipeRight)
        scrollView.addGestureRecognizer(swipeUp)
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
        scrollView.addGestureRecognizer(doubleTapGestureRecognizer)
        singleTapGestureRecognizer.delegate = self
        doubleTapGestureRecognizer.delegate = self
    }
    
    // return to ProfileViewController via swipe image
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.down:
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromBottom
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                view.window!.layer.add(transition, forKey: kCATransition)
                dismiss(animated: false, completion: nil)
            case UISwipeGestureRecognizer.Direction.right:
                let transition = CATransition()
                transition.duration = 0.4
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromLeft
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                view.window!.layer.add(transition, forKey: kCATransition)
                dismiss(animated: false, completion: nil)
            case UISwipeGestureRecognizer.Direction.up:
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromTop
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                view.window!.layer.add(transition, forKey: kCATransition)
                dismiss(animated: false, completion: nil)
            default:
                break
            }
        }
    }
    
    @objc func hadleSingleTap(recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    @objc func handleDoubleTap(recognizer: UITapGestureRecognizer) {
        if (scrollView.zoomScale > scrollView.minimumZoomScale) {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
    @objc func hadlePinch(sender: UIPinchGestureRecognizer) {
        guard sender.view != nil else {
            return
        }
        if sender.state == .began || sender.state == .changed {
            sender.view?.transform = ((sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!)
            sender.scale = 1.0
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return userImage
    }
    
    
    
    
    
    
    
    
    
    
}

