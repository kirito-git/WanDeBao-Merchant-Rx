//
//  WDBMonthChartView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/31.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//
import UIKit
import Charts

class WDBMonthChartView: UIView ,ChartViewDelegate {

    var scrollView:UIScrollView!
    var chartView:LineChartView!
    
    //set方法
    var xDataArray: [WDBOrderChartModel]! {
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
        
        scrollView = UIScrollView.init(frame: CGRect(x:10,y:10,width:SCREEN_WIDTH-20,height:230))
        scrollView.contentSize = CGSize(width:1600,height:230)
        scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView)
        
        
        chartView = LineChartView()
        chartView.frame = CGRect(x:0,y:0,width:1600,height:200)
        scrollView.addSubview(chartView)
        chartView.delegate = self
        
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = false
        //能否缩放
        chartView.setScaleEnabled(false)
        //能否捏合缩放
        chartView.pinchZoomEnabled = false
        //不显示右侧Y轴
        chartView.rightAxis.drawAxisLineEnabled = false
        //        chartView.rightAxis.enabled = false
        
        //设置标注
        //        let l = chartView.legend
        //        l.form = .line
        //        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        //        l.textColor = .red
        //        l.horizontalAlignment = .left
        //        l.verticalAlignment = .bottom
        //        l.orientation = .horizontal
        //        l.drawInside = false
        
        //设置x坐标
        let xAxis = chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 11)
        xAxis.labelTextColor = .lightGray
        xAxis.axisLineColor = .lightText
        //x轴绘制网格线
        xAxis.drawAxisLineEnabled = false
        xAxis.labelPosition = .bottom
        
        //设置y轴
        let leftAxis = chartView.leftAxis
        leftAxis.labelTextColor = .lightGray
        leftAxis.axisMaximum = 200
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
        
        
        //设置折线图的数据
        
        var yDataArray1 = [ChartDataEntry]()
        for i in 1...31 {
            let entry = ChartDataEntry.init(x: Double(i), y: Double(0))
            
            yDataArray1.append(entry)
        }
        
        //设置折现的属性
        let set1 = LineChartDataSet.init(values: yDataArray1, label: "")
        set1.colors = [UIColorRGB_Alpha(R: 163, G: 205, B: 237, alpha: 0.8)]
        set1.drawCirclesEnabled = true //是否绘制转折点
        set1.lineWidth = 1
        set1.circleRadius = 3
        set1.circleColors = [UIColor.gray]
        set1.mode = .linear  //设置曲线是否平滑
        
        //设置折线图的数据
        let data = LineChartData.init(dataSets: [set1])
        chartView.data = data
        
    }
    
    func resetDatas() {

        let xDatas = xDataArray ?? [WDBOrderChartModel]()
        if xDatas.count == 0 {
            return
        }
        var yDataArray = [ChartDataEntry]()
        for i in 0...(xDatas.count - 1) {
            let model = xDataArray[i]
            let y = model.totalSum!
            let entry = ChartDataEntry.init(x: Double(i+1), y: Double(y))
            yDataArray.append(entry)
        }
        
        //设置折现的属性
        let set1 = LineChartDataSet.init(values: yDataArray, label: "时")
        set1.colors = [UIColorRGB_Alpha(R: 163, G: 205, B: 237, alpha: 0.8)]
        set1.drawCirclesEnabled = true //是否绘制转折点
        set1.lineWidth = 1
        set1.circleRadius = 3
        set1.circleColors = [UIColor.gray]
        set1.mode = .linear  //设置曲线是否平滑
        
        //设置折线图的数据
        let data = LineChartData.init(dataSets: [set1])
        chartView.data = data
    }

}
