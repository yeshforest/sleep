//
//  DBMemory.swift
//  project-1971048-nhr
//
//  Created by Hansung Computer on 2022/05/27.
//

import Foundation

class DbMemory:Database{
 
    
    private var storage:[Plan]//데이터 저장하는곳
    
    var parentNotification:((Plan?, DbAction?) -> Void)?
    
    required init(parentNotification: ((Plan?, DbAction?) -> Void)?) {

        self.parentNotification = parentNotification // nil일 수도 있다

        storage = []
        
        storage.append(Plan(sleepingTime: "00:11", wakeUpTime:"07:11"))
        storage.append(Plan(sleepingTime: "01:30", wakeUpTime:"08:40"))
    
    }
    
    // 주어진 플랜에 대하여 삽입, 수정, 삭제를 storage에서 하고
    // 역시 parentListener를 호출하여 이러한 사실을 알린다.
    func saveChange(plan: Plan, action: DbAction){
        if action == .Add{
            storage.append(plan)
        }else{
            for i in 0..<storage.count{
                if plan.key == storage[i].key{
                    if action == .Delete{ storage.remove(at: i) }
                    if action == .Modify{ storage[i] = plan }
                    break
                }
            }
        }
        if let parentNotification = parentNotification{
            parentNotification(plan, action)  // 변경된 내역을 알려준다
        }
    }
    func queryPlan() {
        
        for i in 0..<storage.count{
         
                if let parentNotification = parentNotification{
        parentNotification(storage[i], .Add) // 한개씩 여러번 전달한다
                }
          
        }
    }

}
