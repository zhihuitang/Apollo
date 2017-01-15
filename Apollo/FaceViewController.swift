//
//  FaceItViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2016-12-16.
//  Copyright © 2016 Zhihui Tang. All rights reserved.
//

import UIKit

class FaceViewController: BaseViewController {
    
    var blinking = false {
        didSet {
            startBlink()
        }
    }
    struct BlinkingRate {
        static let OpenDuration = 1.5
        static let CloseDuration = 0.5
    }
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView, action: #selector(FaceView.changeScale(recognizer:))
            ))

            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseHappiness)
            )
            happierSwipeGestureRecognizer.direction = .down
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)

            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.decreaseHappiness)
            )
            sadderSwipeGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            updateUI()
        }
    }
    private var mouthCurvatures = [FacialExpression.Mouth.Frown: -1.0, .Grin:0.5, .Smile: 1.0, .Smirk:-0.5, .Neutral:0.0]
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed: 0.5,.Furrowed:-0.5,.Normal:0.0]
    
    var expression = FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smirk) {
        didSet {
            updateUI()
        }
    }

    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    func decreaseHappiness() {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    private func updateUI() {
        switch expression.eyes {
            case .Open: faceView.eyesOpen = true
            case .Closed: faceView.eyesOpen = false
            case .Squinting: faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0

    }
    @IBAction func toggleEyes(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            switch expression.eyes {
            case .Open: expression.eyes = .Closed
            case .Closed: expression.eyes = .Open
            case .Squinting: break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        blinking = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        blinking = false
        
    }
    
    func startBlink(){
        if blinking {
            faceView.eyesOpen = false
            Timer.scheduledTimer(timeInterval: BlinkingRate.CloseDuration, target: self, selector: #selector(FaceViewController.endBlink), userInfo: nil, repeats: false)
        }
    }
    
    func endBlink() {
        if blinking {
            faceView.eyesOpen = true
            Timer.scheduledTimer(timeInterval: BlinkingRate.OpenDuration, target: self, selector: #selector(FaceViewController.startBlink), userInfo: nil, repeats: false)
        }
    }
    @IBAction func toggleEye(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            switch expression.eyes {
            case .Open: expression.eyes = .Closed
            case .Closed: expression.eyes = .Open
            case .Squinting: break
            }
        }
    }
    @IBAction func headShake(_ sender: UITapGestureRecognizer) {
        UIView.animate(
            withDuration: Animation.ShakeDuation,
            animations: {
                self.faceView.transform = CGAffineTransform(rotationAngle: Animation.ShakeAngle)
            }) { (finished) in
            //
            UIView.animate(
                withDuration: Animation.ShakeDuation,
                animations: {
                    self.faceView.transform = CGAffineTransform(rotationAngle: -Animation.ShakeAngle)
                }) { (finished) in
                //
                    UIView.animate(
                        withDuration: Animation.ShakeDuation,
                        animations: {
                            self.faceView.transform = CGAffineTransform(rotationAngle: 0)
                    }) { (finished) in
                    //
                }
            }
        }
    }
    
    private struct Animation {
        static let ShakeAngle = CGFloat(M_PI/6)
        static let ShakeDuation = 0.5
    }
    
}

extension FaceViewController {
    
    override var name: String {
        return "FaceView demo"
    }

}
