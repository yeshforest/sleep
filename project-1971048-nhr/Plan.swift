//
//  Plan.swift
//  project-1971048-nhr
//
//  Created by Hansung Computer on 2022/05/27.
//

import Foundation
class Plan:NSObject,NSCoding{
    var key:String//key
    var today:String//오늘날짜
    var sleepingTime:String//잠들시간
    var wakeUpTime:String//기상시간
    
    
    
    init(sleepingTime:String,wakeUpTime:String){
        let formatter_day=DateFormatter()
        formatter_day.dateFormat="MM월 dd일 E"
        

        self.key=UUID().uuidString   // 거의 unique한 id를 만들어 낸다.
        self.today=formatter_day.string(from: Date());//오늘날짜
        self.sleepingTime=sleepingTime//잠들시간
        self.wakeUpTime=wakeUpTime//일어날 시간
        
        super.init()
    }
    func clone() -> Plan {
        let clonee = Plan(sleepingTime:"00:00", wakeUpTime:"00:00")

        clonee.key = self.key    // key는 String이고 String은 struct이다. 따라서 복제가 된다
        clonee.today = self.today 
        clonee.sleepingTime=self.sleepingTime
        clonee.wakeUpTime=self.wakeUpTime
        return clonee
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(key, forKey: "key")       // 내부적으로 String의 encode가 호출된다
        aCoder.encode(today, forKey: "today")
        aCoder.encode(sleepingTime, forKey: "sleepingTime")
        aCoder.encode(wakeUpTime, forKey: "wakeUpTime")
        
    }
    // unarchiving할때 호출된다
    required init(coder aDecoder: NSCoder) {
        key = aDecoder.decodeObject(forKey: "key") as! String? ?? "" // 내부적으로 String.init가 호출된다
        today = aDecoder.decodeObject(forKey: "today") as! String
        sleepingTime = aDecoder.decodeObject(forKey: "sleepingTime") as! String
        wakeUpTime = aDecoder.decodeObject(forKey: "wakeUpTime") as! String
      
        super.init()
    }


    
}
