//
//  saveTimeViewController.swift
//  project-1971048-nhr
//
//  Created by Hansung Computer on 2022/05/27.
//

import UIKit

class saveTimeViewController: UIViewController {
    
    var bedTime:String!;
    var WakeUpTime:String!;
    var planGroup:PlanGroup!
    
    @IBOutlet weak var saveBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planGroup=PlanGroup(parentNotification: receivingNotification)
        print(planGroup.queryPlan())
        
        
        if bedTime==nil || WakeUpTime==nil{//시간들이 다 입력되어야 버튼 활성화
            saveBtn.isEnabled=false
        }
        
    }
    func receivingNotification(plan: Plan?, action: DbAction?){
          
          
        }
    
    func setSleepTime(selectedBedTime:Date){//잠든시간 받는 함수
        let formatter=DateFormatter()
        formatter.dateFormat="HH:mm"
        
       // print("bedTime: "+formatter.string(from: selectedBedTime))
        bedTime=formatter.string(from: selectedBedTime)
        
        
        if bedTime != nil && WakeUpTime != nil{
            saveBtn.isEnabled=true
        }
      
    }
    func setWakeUpTime(selectedWakeTime:Date){//기상시간 받는 함수
        let formatter=DateFormatter()
        formatter.dateFormat="HH:mm"
        
       // print("wakeTime: "+formatter.string(from: selectedWakeTime))
        WakeUpTime=formatter.string(from: selectedWakeTime)
        
        if bedTime != nil && WakeUpTime != nil{
            saveBtn.isEnabled=true
        }
    }
    @IBAction func gobedTime(_ sender: UIDatePicker) {//잠든 시간 datePicker
        let datePickerView=sender
        setSleepTime(selectedBedTime:datePickerView.date)
    }
    
    @IBAction func wakeUpTime(_ sender: UIDatePicker) {//일어난 시간 datePicker
        let datePickerView=sender
        setWakeUpTime(selectedWakeTime:datePickerView.date)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let plan = Plan(sleepingTime: bedTime, wakeUpTime: WakeUpTime)
        print("bedTime:"+bedTime+" wakeupTime"+WakeUpTime)

        
        if segue.identifier=="showPlan"{
            let planGroupViewController = segue.destination as! PlanGroupViewController
         
            planGroupViewController.plan = plan.clone()
            

        }
    }
}
