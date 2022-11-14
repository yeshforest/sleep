//
//  ViewController.swift
//  project-1971048-nhr
//
//  Created by Hansung Computer on 2022/05/26.
//

import UIKit

class nowViewController: UIViewController {

    @IBOutlet weak var wakeUpTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
      makeWakeUpTime();
    }
    func makeWakeUpTime(){
        
        /*시간만 가져오기*/
        let formatter_time=DateFormatter()
        formatter_time.dateFormat="HH:mm"
        
        let current_time_string=formatter_time.string(from: Date())
        print(current_time_string)
     
        /*4시간30분*/
        let fourThrity=formatter_time.string(from:Date(timeIntervalSinceNow: 60*60*(4.75)))//4시간30분+15분
        /*6시간*/
        let six=formatter_time.string(from:Date(timeIntervalSinceNow: 60*60*(6.25)))//6시간+15분
        /*7시간30분*/
        let sevenThrity=formatter_time.string(from:Date(timeIntervalSinceNow: 60*60*(7.75)))//7시간30분+15분
        /*9시간*/
        let nine=formatter_time.string(from:Date(timeIntervalSinceNow: 60*60*(9.25)))//9시간
        
        
        
        
        wakeUpTime.text=(fourThrity+" or "+six+" or "+sevenThrity+" or "+nine)
        
        
        
        
        
    }
  

}

