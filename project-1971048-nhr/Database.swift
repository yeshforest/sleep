//
//  Database.swift
//  project-1971048-nhr
//
//  Created by Hansung Computer on 2022/05/27.
//

import Foundation
//Database.swift
enum DbAction{
    case Add,Delete,Modify//데이터베이스 변경의 유형
}
protocol Database{
    // 생성자, 데이터베이스에 변경이 생기면 parentNotification를 호출하여 부모에게 알림
    init(parentNotification: ((Plan?, DbAction?) -> Void)? )

    func queryPlan()//모든 Plan을 읽어 parentNotification를 호출하여 부모에게 알림

    // 데이터베이스에 plan을 변경하고 parentNotification를 호출하여 부모에게 알림
    func saveChange(plan: Plan, action: DbAction)
}
//이걸 상속받는 것들은 이걸 다 implementation해줘야한다.
