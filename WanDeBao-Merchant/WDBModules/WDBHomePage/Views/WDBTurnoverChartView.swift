//
//  WDBTurnoverChartView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/6/2.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import Charts

class WDBTurnoverChartView: UIView ,ChartViewDelegate{

    var chartView: BarChartView!
    
    //set方法
    var yDataArray: [Double]! {
        didSet {
            self.resetDatas()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:250))
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createUI() -> Void {
        
        chartView = BarChartView()
        self.addSubview(chartView)
        chartView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = false
        
        
        chartView.maxVisibleCount = 60
        
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = false
        //能否缩放
        chartView.setScaleEnabled(false)
        //能否捏合缩放
        chartView.pinchZoomEnabled = false
        //不显示右侧Y轴
        chartView.rightAxis.drawAxisLineEnabled = false
        //        chartView.rightAxis.enabled = false
        
        
        
        //设置x坐标
        let xAxis = chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 11)
        xAxis.labelTextColor = .lightGray
        xAxis.axisLineColor = .lightText
        xAxis.granularity = 1 //间隔
        xAxis.labelCount = 7
        xAxis.axisMinimum = 0
        xAxis.axisMaximum = 240
        //x轴绘制网格线
        xAxis.drawAxisLineEnabled = false
        xAxis.labelPosition = .bottom
        
        //设置y轴
        let leftAxis = chartView.leftAxis
        leftAxis.labelTextColor = .lightGray
        leftAxis.axisMaximum = 40
        leftAxis.axisMinimum = 0//设置Y轴的最小值
        leftAxis.drawAxisLineEnabled = true
        leftAxis.granularityEnabled = true
        leftAxis.drawZeroLineEnabled = true //从0开始绘制
        leftAxis.axisLineColor = .white//Y轴颜色
        //设置为虚线
        leftAxis.gridLineDashLengths = [5, 5]
        
        //是否显示横向实线
        chartView.rightAxis.enabled = false
        //是否显示x坐标
        //        chartView.xAxis.enabled = false
        //是否显示纵向网格线
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.chartDescription?.textColor = .gray
        chartView.legend.enabled = false
        
        chartView.animate(xAxisDuration: 1.5)
        
        
        //设置图的数据
        let yVals = (1..<8).map { (i) -> BarChartDataEntry in
            let val = 0
            return BarChartDataEntry(x: Double(i*30), y: Double(val))
        }
        
        //设置柱形图的属性
        var set1: BarChartDataSet! = nil
        set1 = BarChartDataSet(values: yVals, label: "")
        set1.colors = ChartColorTemplates.material()
        set1.drawValuesEnabled = false
        
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
        data.barWidth = 0.9*30
        chartView.data = data
        
    }
    
    func resetDatas() {
        
        //设置图的数据
        var yValues = [BarChartDataEntry]()
        for i in 0..<yDataArray.count {
            let val = yDataArray[i]
            yValues.append(BarChartDataEntry(x: Double(i*30), y: val))
        }
        
        //设置柱形图的属性
        var set1: BarChartDataSet! = nil
        set1 = BarChartDataSet(values: yValues, label: "")
        set1.colors = ChartColorTemplates.material()
        set1.drawValuesEnabled = false
        
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
        data.barWidth = 0.9*30
        chartView.data = data
    }

}
