//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Terra Oldham on 10/23/14.
//  Copyright (c) 2014 HearsaySocial. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    @IBOutlet weak var trayView: UIView!
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var arrowView: UIImageView!
    var imageCenter: CGPoint!
    @IBAction func onDrag(sender: UIPanGestureRecognizer) {
        var point = panGestureRecognizer.locationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        var translation = panGestureRecognizer.translationInView(view)
        
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            imageCenter = trayView.center
            
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            var totalDistance = CGFloat(630 - 478)
            var ratioDistance = (trayView.center.y - CGFloat(478)) / totalDistance
            var angle = ratioDistance * CGFloat(M_PI)
            
            
            println("Gesture changed at: \(point)")
            
            var newCenterY = imageCenter.y + translation.y
            if newCenterY <= 478 {
                self.arrowView.transform = CGAffineTransformIdentity
                trayView.center.y = 478 + (newCenterY - 478)/5
            } else {
                trayView.center.y = newCenterY
                arrowView.transform = CGAffineTransformMakeRotation(angle)
            }
            
            
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            var animationTime = 0.3//NSTimeInterval(abs(150/velocity.y))
            if velocity.y < 0 {
                self.arrowView.transform = CGAffineTransformIdentity
                UIView.animateWithDuration(animationTime, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                    self.trayView.center.y = 498
                    }, completion: nil)
                
            } else {
                var angle = CGFloat(180 * M_PI / 180)
                self.arrowView.transform = CGAffineTransformMakeRotation(angle)
                UIView.animateWithDuration(animationTime, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                    self.trayView.center.y = 630
                    }, completion: nil)
                
            }
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayView.addGestureRecognizer(panGestureRecognizer)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
