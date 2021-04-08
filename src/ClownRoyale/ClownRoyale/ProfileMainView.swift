import UIKit
class ProfileMainView: UIView {

    override func draw(_ frame: CGRect) {
        //Profile
        drawProfile()
    }
    
    
    internal func drawProfile() -> () {
        
        let halfSize:CGFloat = min( bounds.size.width/2, bounds.size.height/2)
        let desiredLineWidth:CGFloat = 10
            
        //Background Circle
        let circlePath = UIBezierPath(
                arcCenter: CGPoint(x:halfSize + halfSize/4,y:halfSize),
                radius: CGFloat( halfSize - (desiredLineWidth/2) ),
                startAngle: CGFloat(0),
            endAngle:CGFloat(Double.pi * 2),
                clockwise: true)
    
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
            
        shapeLayer.fillColor = UIColor(named: "ClownBlue")?.cgColor
        shapeLayer.strokeColor = UIColor(named: "ClownFirstRing")?.cgColor
        shapeLayer.lineWidth = desiredLineWidth
    
        layer.addSublayer(shapeLayer)
        
     }
}
