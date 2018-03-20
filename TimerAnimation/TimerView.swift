//
//  TimerView.swift
//  TimerAnimation
//
//  Created by Abhishek K on 20/03/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import UIKit


struct GlobalVariables {
    struct Payment {
      static  var timeLeft:TimeInterval?
       static var transTime:TimeInterval?
        
    }
}

class TimerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    let timeLeftShapeLayer = CAShapeLayer()
    let bgShapeLayer = CAShapeLayer()
    let bgGrayShapeLayer = CAShapeLayer()
    var timeLeft: TimeInterval! = 0.0
    var endTime: Date!
    var timeLabel =  UILabel()
    var timer:Timer?
    let strokeIt = CABasicAnimation(keyPath: "strokeEnd")
    var rootViewController:UIViewController?
    
    var isUpdate : Bool = false
    
    override func awakeFromNib() {
    
    self.addTimeLabel()
    }
   
    
    func refresh(time:Double? = GlobalVariables.Payment.timeLeft ){
    self.timeLeft = time  ?? GlobalVariables.Payment.timeLeft
        let difference = GlobalVariables.Payment.transTime! - (time ?? GlobalVariables.Payment.timeLeft! - 1)
    let startAngleForLeftShape = Double(getAngle(Int(difference)))
    drawBgGrayShape()
    self.drawBgShape(startAngle: Double(startAngleForLeftShape) )
    
    self.drawTimeLeftShape(startAngle: Double(startAngleForLeftShape) )
    
    
    
    self.strokeIt.fromValue = 0.0
    self.strokeIt.toValue = 1.0
        self.strokeIt.duration = GlobalVariables.Payment.timeLeft!
    self.timeLeftShapeLayer.add(self.strokeIt, forKey: nil)
    
    self.endTime = Date().addingTimeInterval(self.timeLeft)
    
    self.scheduledTimer()
    }
    
    
    func drawBgGrayShape() {
    bgGrayShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: self.bounds.size.width*0.7 , y: self.bounds.size.height*0.5), radius:
    self.bounds.size.width*0.17, startAngle: -90.degreesToRadians, endAngle: -450.degreesToRadians, clockwise: false).cgPath
    bgGrayShapeLayer.strokeColor = UIColor.gray.cgColor
    bgGrayShapeLayer.fillColor = UIColor.clear.cgColor
    bgGrayShapeLayer.lineWidth = 2
    self.layer.addSublayer(bgGrayShapeLayer)
    }
    
    
    func drawBgShape(startAngle:Double) {
    bgShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: self.bounds.size.width*0.7 , y: self.bounds.size.height*0.5), radius:
    self.bounds.size.width*0.17, startAngle: -(startAngle).degreesToRadians, endAngle: -450.degreesToRadians, clockwise: false).cgPath
    bgShapeLayer.strokeColor = UIColor.red.cgColor
    bgShapeLayer.fillColor = UIColor.clear.cgColor
    bgShapeLayer.lineWidth = 2
    self.layer.addSublayer(bgShapeLayer)
    }
    func drawTimeLeftShape(startAngle:Double) {
    timeLeftShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: self.bounds.size.width*0.7, y: self.bounds.size.height*0.5), radius:
    self.bounds.size.width*0.17, startAngle: -(startAngle).degreesToRadians, endAngle: -450.degreesToRadians, clockwise: false).cgPath
    timeLeftShapeLayer.strokeColor = UIColor.lightGray.cgColor
    timeLeftShapeLayer.fillColor = UIColor.clear.cgColor
    timeLeftShapeLayer.lineWidth = 2
    self.layer.addSublayer(timeLeftShapeLayer)
    }
    func addTimeLabel() {
    timeLabel = UILabel(frame: CGRect(x: -self.bounds.size.width/10   , y:self.bounds.size.height*0.45 , width:self.bounds.size.width*2 - self.bounds.size.width*0.4, height: 12))
    
    timeLabel.font = UIFont(name: "SF UI Display", size: 13)
    timeLabel.textAlignment = .center
    timeLabel.text = timeLeft.time
    self.addSubview(timeLabel)
    }
    
    func scheduledTimer() {
    
    if timer == nil{
    timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    }
    
    
    
    @objc func updateTime() {
    if timeLeft > 0 {
    isUpdate = true
    timeLeft = endTime.timeIntervalSinceNow
    timeLabel.text = timeLeft.time
    } else {
    timer?.invalidate()
    timeLabel.text = "00:00"
    if isUpdate == true {
    isUpdate = false
   
    }
    }
    }
    
    
    func getAngle(_ differnce:Int)->Int{
        let transTime = Int(GlobalVariables.Payment.transTime!)
    let getDiffPercent = 100*differnce/transTime
    
    let angle = getDiffPercent*360/100
    return 90+angle
    
    }
    
   
    

}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}


extension TimeInterval {
    var time:String {
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        return String(format:"%02d:%02d", minutes,  seconds )
    }
}
extension Double {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
}

class TimerModel: NSObject {
    static let sharedTimer: TimerModel = {
        let timer = TimerModel()
        return timer
    }()
    
    var internalTimer: Timer?
    var endTime: Date!
    var timeLeft: TimeInterval! = 0.0
    
    func startTimer(withInterval interval: Double) {
        if internalTimer == nil {
            internalTimer?.invalidate()
        }
        self.endTime = Date().addingTimeInterval(interval)
        internalTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(doJob), userInfo: nil, repeats: true)
    }
    
    func pauseTimer() {
        guard internalTimer != nil else {
            print("No timer active, start the timer before you stop it.")
            return
        }
        internalTimer?.invalidate()
    }
    
    func stopTimer() {
        guard internalTimer != nil else {
            print("No timer active, start the timer before you stop it.")
            return
        }
        
        internalTimer?.invalidate()
    }
    
    @objc func doJob() {
        timeLeft = endTime.timeIntervalSinceNow
    }
    
    
}
