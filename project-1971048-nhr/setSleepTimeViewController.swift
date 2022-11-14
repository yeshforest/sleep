//
//  setSleepTimeViewController.swift
//  project-1971048-nhr
//
//  Created by Hansung Computer on 2022/05/26.
//

import UIKit

class setSleepTimeViewController: UIViewController {

    @IBOutlet weak var wakeUpTime: UILabel!
    

    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
    
        super.viewDidLoad()
        datePicker.backgroundColor = .gray
        
    }
    func setSleepTime(selectedTime:Date){
        
        
        let formatter=DateFormatter()
        formatter.dateFormat="HH:mm"
        
       //print(formatter.string(from: selectedTime))
        /*4시간30분*/
        let fourThrity=formatter.string(from: selectedTime+60*60*(4.75))

        /*6시간*/
        let six=formatter.string(from: selectedTime+60*60*(6.25))
        
        /*7시간30분*/
        let sevenThrity=formatter.string(from: selectedTime+60*60*(7.75))

        /*9시간*/
        let nine=formatter.string(from: selectedTime+60*60*(9.25))

        
        
        wakeUpTime.text = fourThrity+" or "+six+" or \n"+sevenThrity+" or "+nine
    }

    
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView=sender//전달된 인수 저장
        
        setSleepTime(selectedTime:datePickerView.date)
    }
    
}
