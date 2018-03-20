//
//  SecondViewController.swift
//  TimerAnimation
//
//  Created by Abhishek K on 20/03/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    var timerView:TimerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        timerView = UINib.init(nibName: "TimerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TimerView
        self.viewContainer.addSubview(timerView)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
    
        timerView.refresh(time: TimerModel.sharedTimer.timeLeft)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
