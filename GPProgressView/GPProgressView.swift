// Copyright (c) 2016 GovindPrajapati

//Email : govindm.prajapati300@gmail.com

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import UIKit

enum GPlineCapStyle : String {
case Round = "round"
case Square = "square"
case Butt = "butt"
}

@IBDesignable
public class GPProgressView: UIView {

    @IBInspectable var  lineCapType : GPlineCapStyle = .Round
    @IBInspectable public var lineWidth : CGFloat = 5
    @IBInspectable public var _progress : Double = 0.1
    @IBInspectable public var strokeColor : UIColor = UIColor.blueColor()
    @IBInspectable public var backStrokeColor : UIColor = UIColor.grayColor()
    @IBInspectable public var fillColor : UIColor = UIColor.whiteColor()
    
   public var progress : Double?{
        
        set{
            if newValue > 0.00 && newValue < 1.0 {
        progressAnimate(newValue!)
            }
        }
        
        get{
        return _progress
        }
    }
    
    var shapeLayer : CAShapeLayer?
    var progressPath : UIBezierPath?
    

   public override func drawRect(rect: CGRect) {
       drowCircle()
    }
    
   public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
   public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    private func drowCircle() {
        
        
        let redius : CGFloat = frame.width > frame.height ? frame.height/2 - (lineWidth/2) : frame.width/2 - (lineWidth/2)
        
        let centerPoint : CGPoint = CGPointMake(frame.width/2, frame.height/2)
        
        let startAngleDeffrence : Double = (M_PI*1.5)
        let endAngle1 : CGFloat = CGFloat(degreesToRadians(360) + startAngleDeffrence)
        
        let progressPath1 : UIBezierPath = UIBezierPath(arcCenter: centerPoint, radius: redius, startAngle: CGFloat(M_PI*1.5), endAngle: endAngle1, clockwise: true)
        
        let shapeLayer1 = CAShapeLayer()
        shapeLayer1.path = progressPath1.CGPath
        shapeLayer1.fillColor = fillColor.CGColor
        shapeLayer1.strokeColor = backStrokeColor.CGColor
        shapeLayer1.lineCap = lineCapType.rawValue
        shapeLayer1.lineWidth = lineWidth
        
        layer.addSublayer(shapeLayer1)
        

        shapeLayer = CAShapeLayer()
        shapeLayer!.path = progressPath1.CGPath
        shapeLayer!.fillColor = UIColor.clearColor().CGColor
        shapeLayer!.strokeColor = strokeColor.CGColor
        shapeLayer!.lineCap = lineCapType.rawValue
        shapeLayer!.lineWidth = lineWidth
        shapeLayer!.strokeStart = 0.0
        shapeLayer!.strokeEnd = CGFloat( _progress)
        
        layer.addSublayer(shapeLayer!)
        
    }
    
    private func getEndAngleFromProgress(progress : Double) -> CGFloat{
        
    let progressDegree : Double = (360.00 / 100.0) * (progress * 100)
    let startAngleDeffrence : Double = (M_PI*1.5)
        
    return CGFloat(degreesToRadians(progressDegree) + startAngleDeffrence)
    }
    
    private func degreesToRadians(value : Double) -> Double{
        return value * M_PI/180
    }
    
    private func progressAnimate(newProgressValue : Double){
    
        let pathAnimation : CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 1
        
        pathAnimation.fromValue = progress
        pathAnimation.toValue = newProgressValue
        
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        pathAnimation.fillMode = kCAFillModeBoth
        pathAnimation.removedOnCompletion = false
        
        shapeLayer!.addAnimation(pathAnimation, forKey: "strokeEnd")
        
        self._progress = newProgressValue
        
    }
    
}
