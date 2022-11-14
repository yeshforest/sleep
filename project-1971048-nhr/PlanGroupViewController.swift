//
//  PlanGroupViewController.swift
//  project-1971048-nhr
//
//  Created by Hansung Computer on 2022/05/27.
//

import UIKit
class sleepPlan{//ChartViewController로 전달하는 데이타
    init(date:String,sleepTime:Double){
        self.date=date
        self.sleepTime=sleepTime
    }
    var date:String//해당날짜
    var sleepTime:Double//수면시간
    
}

class PlanGroupViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var planGroupTableView: UITableView!
    var planGroup: PlanGroup!
    var plan:Plan?
    var chartData=[Double]()
    var data = [sleepPlan]()
    //var data : [sleepPlan]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planGroupTableView.dataSource = self        // 테이블뷰의 데이터 소스로 등록
        planGroupTableView.delegate=self//딜리게이터로 등록

        // 단순히 planGroup객체만 생성한다
        planGroup = PlanGroup(parentNotification:receivingNotification)
        planGroup.queryPlan()       // 데이터를 가져온다. 데이터가 오면 planGroupListener가 호출된다.
        if plan != nil{
            save()
        }
        
    }

    @IBAction func editingPlans(_ sender: UIButton) {
        if planGroupTableView.isEditing == true{
            planGroupTableView.isEditing = false
            sender.setTitle("Edit", for: .normal)
        }else{
            planGroupTableView.isEditing = true
            sender.setTitle("Done", for: .normal)
        }

    }
    func save(){
      
            planGroup.saveChange(plan: plan!, action: .Add)    // 단지 데이터베이스에 저장만한다. 그러면 receivingNotification 함수가 호출되고 tableView.reloadData()를 호출하여 생성된 데이터가 테이블뷰에 보이게 된다.

    }
   
    func receivingNotification(plan: Plan?, action: DbAction?){
        // 데이터가 올때마다 이 함수가 호출되는데 맨 처음에는 기본적으로 add라는 액션으로 데이터가 온다.
        self.planGroupTableView.reloadData()  // 속도를 증가시키기 위해 action에 따라 개별적 코딩도 가능하다.
    }


        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let planGroup = planGroup{
            return planGroup.getPlans().count
        }
        return 0    // planGroup가 생성되기전에 호출될 수도 있다
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        
        
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "") // TableViewCell을 생성한다
  
     
        let plan = planGroup.getPlans()[indexPath.row] //plan을 가지고 온다.

        // 적절히 cell에 데이터를 채움
        cell.textLabel!.text = plan.today
        cell.detailTextLabel?.text = "취침 :"+plan.sleepingTime+"/기상: "+plan.wakeUpTime
        


        //문자열인것을 시간으로 바꿔야한다.
        let start=plan.sleepingTime.split(separator:":")
        let startMin:Int!;let startHour:Int!//취침시간
        startMin=Int(start[1])!;startHour=Int(start[0])!
        
        let end=plan.wakeUpTime.split(separator:":")
        let endMin:Int!;let endHour:Int!//기상시간
        endMin=Int(end[1])!;endHour=Int(end[0])!
        
        //print(endHour*60+endMin)
        //print(startHour*60+startMin)
        let sleepend=endHour*60+endMin
        let sleepstart=startHour*60+startMin
        print((endHour*60+endMin)-(startHour*60+startMin))
        
        
        /*data에 겹치는(누적되는) 데이타를 차트에 표시하지 않기 위해 */
        let temp=data.contains(where: {$0.date==plan.today})
        //print(temp)
        if(temp==false){
        
        if sleepend-sleepstart>0 {
            print((sleepend-sleepstart)/60)
            chartData.append(Double(((sleepend-sleepstart)/60)))
            data.append(sleepPlan(date:plan.today, sleepTime: Double(((sleepend-sleepstart)/60))))
        }else{
            print((sleepstart-sleepend)/60)
            chartData.append(Double((sleepstart-sleepend)/60))
            data.append(sleepPlan(date:plan.today, sleepTime: Double((sleepstart-sleepend)/60)))
        }
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            // 선택된 row의 플랜을 가져온다
            let plan = self.planGroup.getPlans()[indexPath.row]
            
            // 데이터베이스에서 지워졌음을 알려준다
            self.planGroup.saveChange(plan: plan, action: .Delete)
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // 데이터베이스에 까지 영향을 미치지 않고 planGroup에서만 위치 변경
        let from = planGroup.getPlans()[sourceIndexPath.row]
        let to = planGroup.getPlans()[destinationIndexPath.row]
        planGroup.changePlan(from: from, to: to)
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }


    @IBAction func goToBtn(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goTo", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "goTo" {
               let cvc = segue.destination as! ChartViewController
               //cvc.sleepTime = chartData
               cvc.data = data
            
           }
       }
    
}
