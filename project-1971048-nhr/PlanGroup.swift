//
//  PlanGroup.swift
//  project-1971048-nhr
//
//  Created by Hansung Computer on 2022/05/27.
//

import Foundation
class PlanGroup:NSObject{
    var plans = [Plan]()
    var database:Database!
    var parentNotification:((Plan?,DbAction?)->Void)?
    
    
    
    init(parentNotification:((Plan?,DbAction?)->Void)?){
        super.init()
        self.parentNotification=parentNotification
        //database=DbMemory(parentNotification : receivingNotification)
        database=DbFirebase(parentNotification : receivingNotification)
    }
    func receivingNotification(plan: Plan?, action: DbAction?){
        if let plan = plan{
            switch(action){    // 액션에 따라 적절히     plans에 적용한다
                case .Add: addPlan(plan: plan)
                case .Modify: modifyPlan(modifiedPlan: plan)
                case .Delete: removePlan(removedPlan: plan)
                default: break
            }
        }
        if let parentNotification = parentNotification{
            parentNotification(plan, action) // 역시 부모에게 알림내용을 전달한다.
        }

    }
    func queryPlan(){
        plans.removeAll()    // 새로운 쿼리에 맞는 데이터를 채우기 위해 기존 데이터를 전부 지운다
        database.queryPlan()
    }

    
    func saveChange(plan: Plan, action: DbAction){
        // 단순히 데이터베이스에 변경요청을 하고 plans에 대해서는
        // 데이터베이스가 변경알림을 호출하는 receivingNotification에서 적용한다
        database.saveChange(plan: plan, action: action)
    }

    private func find(_ key: String) -> Int?{
        for i in 0..<plans.count{
            if key == plans[i].key{
                return i
            }
        }
        return nil
    }

    private func addPlan(plan:Plan){ plans.append(plan) }
    private func modifyPlan(modifiedPlan: Plan){
        if let index = find(modifiedPlan.key){
            plans[index] = modifiedPlan
        }
    }
    private func removePlan(removedPlan: Plan){
        if let index = find(removedPlan.key){
            plans.remove(at: index)
        }
    }
    func changePlan(from: Plan, to: Plan){
        if let fromIndex = find(from.key), let toIndex = find(to.key) {
            plans[fromIndex] = to
            plans[toIndex] = from
        }
    }
    func getPlans() -> [Plan] {
        
        // plans를 리턴한다
        return plans
    }


}



