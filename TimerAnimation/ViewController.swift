//
//  ViewController.swift
//  TimerAnimation
//
//  Created by Abhishek K on 20/03/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startOutlet: UIButton!
    @IBOutlet weak var timerText: UITextField!
    @IBOutlet weak var viewContainer: UIView!
    var timerView:TimerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerView = UINib.init(nibName: "TimerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TimerView
        self.viewContainer.addSubview(timerView)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        if TimerModel.sharedTimer.timeLeft != 0.0{
            timerView.refresh(time: TimerModel.sharedTimer.timeLeft)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func startAction(_ sender: Any) {
        
        TimerModel.sharedTimer.startTimer(withInterval: Double(timerText.text!)!)
        GlobalVariables.Payment.transTime = Double(timerText.text!)
        GlobalVariables.Payment.timeLeft = Double(timerText.text!)
        timerView.refresh(time: Double(timerText.text!)!)
        startOutlet.isEnabled = false
        
        
    }
    
   
    
}

