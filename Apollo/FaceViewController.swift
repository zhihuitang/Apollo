//
//  FaceItViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2016-12-16.
//  Copyright © 2016 Zhihui Tang. All rights reserved.
//

import UIKit

class FaceViewController: BaseViewController {
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView, action: #selector(FaceView.changeScale(recognizer:))
            ))

            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseHappiness)
            )
            happierSwipeGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)

            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.decreaseHappiness)
            )
            sadderSwipeGestureRecognizer.direction = .down
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
}

extension FaceViewController {
    
    override var name: String {
        return "FaceView demo"
    }

}
