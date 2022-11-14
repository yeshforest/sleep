//
//  setWakeUpTimeViewController.swift
//  project-1971048-nhr
//
//  Created by Hansung Computer on 2022/05/27.
//

import UIKit

class setWakeUpTimeViewController: UIViewController {
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var sleepTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatePicker.backgroundColor = .gray
        
    
    }
    
    func setSleepTime(selectedTime:Date){
        let formatter=DateFormatter()
        formatter.dateFormat="HH:mm"
        
//        print(formatter.string(from: selectedTime-60*60*(4.75)))
        
        /*4시간30분+15분*/
        let fourThrity=formatter.string(from: selectedTime-60*60*(4.75))

        /*6시간+15분*/
        let six=formatter.string(from: selectedTime-60*60*(6.25))
        
        /*7시간30분+15분*/
        let sevenThrity=formatter.string(from: selectedTime-60*60*(7.75))

        /*9시간+15분*/
        let nine=formatter.string(from: selectedTime-60*60*(9.25))

        
        
        sleepTime.text = fourThrity+" or "+six+" or \n"+sevenThrity+" or "+nine
        
        
        
        
    }
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView=sender
        
        setSleepTime(selectedTime:datePickerView.date)
    }
    
  

}
