//
//  ChartViewController.swift
//  project-1971048-nhr
//
//  Created by Hansung Computer on 2022/06/07.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    
    @IBOutlet weak var barChartView: BarChartView!
    var days=[String]()
    var sleepTime = [Double]()
    var data=[Any]()


    override func viewDidLoad() {
        
        
        
        let formatter=DateFormatter()
        formatter.dateFormat="MM/dd"
       
      
        super.viewDidLoad()
        /*몇월 며칠 형태로 들어가게하기*/
        for i in data{
            days.append((i as! sleepPlan).date)
            sleepTime.append((i as! sleepPlan).sleepTime)
        }

      
        barChartView.noDataText = "데이터가 없습니다."
        barChartView.noDataFont = .systemFont(ofSize: 20)
        barChartView.noDataTextColor = .lightGray
       
        setChart(dataPoints: days, values: sleepTime)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(Int(i)), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "수면시간")

        // 차트 컬러
        chartDataSet.colors = [.systemCyan]

        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        chartDataSet.highlightEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
        barChartView.xAxis.setLabelCount(dataPoints.count, force: false)
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
   
}
