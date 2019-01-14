//
//  DateFormatTool.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/26.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

enum DateStringType:Int {
    case yMdHms
    case yMd
}

//类方法
class DateFormatTool {
    
    //时间戳转换为时间
    class func dateStringFromTimestamp (type:DateStringType,timestamp:Double) -> String {
        
        //时间戳转换为时间
        let date = Date.init(timeIntervalSince1970: timestamp)
        //格式化
        let dformatter = DateFormatter()
        switch type {
        case .yMd:
            dformatter.dateFormat = "yyyy-MM-dd"
        case .yMdHms:
            dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }
        //时间转换为字符串
        let dateStr = dformatter.string(from: date)
        
        return dateStr
    }
    
    //获取 返回本月1号的时间 月末时间 今天 和 本月天数
    class func currentDaysOfMonthCount () -> (Double,Double,Int,Int) {
        //计算当月天数
        let calendar = Calendar.current
        let date = Date()
        let nowComps = calendar.dateComponents([.year,.month,.day], from: date)
        let year =  nowComps.year
        let month = nowComps.month
    
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        
        var endComps = DateComponents()
        endComps.day = 1
        endComps.month = month == 12 ? 1 : month! + 1
        endComps.year = month == 12 ? year! + 1 : year
    
        //计算本月天数
        let componentsSet = Set<Calendar.Component>([.day])
        let diff = calendar.dateComponents(componentsSet, from: startComps, to: endComps)
    
        //今天的日期
        let nowDay = nowComps.day
        
        //计算本月月初/月末时间戳
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        
        let yearStr = String(describing: year!)
        let monthStr = String(describing: month!)
        let diffStr = String(describing: diff.day!)
        
        let startDate = dformatter.date(from: "\(yearStr).\(monthStr).01 00:00:00")
        let startTimestamp = startDate?.timeIntervalSince1970
        let endDate = dformatter.date(from: "\(yearStr).\(monthStr).\(diffStr) 00:00:00")
        let endTimestamp = endDate?.timeIntervalSince1970
        
        return (startTimestamp!, endTimestamp!, nowDay!, diff.day!)
    }
    
    //计算昨日的起始时间戳
    class func getYesterdayTimeStamp() -> (Double,Double) {
        
        let todayDate = Date()
        //当前时间戳
        let nowTimeStamp = todayDate.timeIntervalSince1970
        //计算昨日时间戳
        let yesterdayTimestamp = Double(nowTimeStamp) - 60*60*24.0
        
        //昨日开始
        let start_dformatter = DateFormatter()
        start_dformatter.dateFormat = "yyyy.MM.dd 00:00:00"
        let start_yesterday = start_dformatter.string(from: Date.init(timeIntervalSince1970: yesterdayTimestamp))
        let start_timestamp = (start_dformatter.date(from: start_yesterday))?.timeIntervalSince1970
        
        //昨日结束
        let end_dformatter = DateFormatter()
        end_dformatter.dateFormat = "yyyy.MM.dd 23:59:59"
        let end_yesterday = end_dformatter.string(from: Date.init(timeIntervalSince1970: yesterdayTimestamp))
        let end_timestamp = (end_dformatter.date(from: end_yesterday))?.timeIntervalSince1970
        
        print("获取昨日初始时间戳！")
//        print(start_yesterday)
//        print(end_yesterday)
        
        return (Double(start_timestamp!),Double(end_timestamp!))
    }
    
    //获取今日 起始-现在 时间戳
    class func getTodayStartAndEndTimeStamp() -> (Double,Double) {
        let todayDate = Date()
        //当前时间戳
        let nowTimeStamp = todayDate.timeIntervalSince1970
        
        //今日开始时间戳
        let start_dformatter = DateFormatter()
        start_dformatter.dateFormat = "yyyy.MM.dd 00:00:00"
        let start_today = start_dformatter.string(from: Date.init(timeIntervalSince1970: nowTimeStamp))
        let start_timestamp = (start_dformatter.date(from: start_today))?.timeIntervalSince1970
        
        //当前时间戳
        //nowTimeStamp
        
        return (Double(start_timestamp!),Double(nowTimeStamp))
    }
    
    //获取7小时前的时间戳和当前时间戳
    class func getRecent7HourStartTimeAndEndTime() -> (Double,Double) {
        let nowDate = Date()
        //当前时间戳
        let nowTimeStamp = nowDate.timeIntervalSince1970
        //七小时之前时间戳
        let before7Hour = Double(nowTimeStamp) - 7*60*60
        return (Double(before7Hour),Double(nowTimeStamp))
    }
    
    //时间戳转化为日字符串
    class func getDayFromTimestamp (timestamp:Double) -> Int {
        
        //时间戳转化为时间
        let date = Date.init(timeIntervalSince1970: timestamp)
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = "dd"
        //日期转化为字符串
        let dayStr = dformatter.string(from: date)
        return Int(dayStr)!
    }
    
    //时间戳转化为小时
    class func getHourFromTimestamp (timestamp:Double) -> Int {
        
        //时间戳转化为时间
        let date = Date.init(timeIntervalSince1970: timestamp)
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = "HH"
        //日期转化为字符串
        let hStr = dformatter.string(from: date)
        return Int(hStr)!
    }
    
    //当前整点的小时数组 最近7小时内
    class func getCurrentHourTimestamp () -> [Int] {
        
        //获取今天的时间
        let date = Date()
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy.MM.dd HH"
        //日期转化为字符串
        let hStr = dformatter.string(from: date)
        //整点字符串转化为时间
        let hDate = dformatter.date(from: hStr)
        //时间转化为时间戳
        let hTimstamp = Double((hDate?.timeIntervalSince1970)!)
        
        var timestampArray = [Int]()
        let array = [6.0,5.0,4.0,3.0,2.0,1.0,0,-1.0]
        for x in array {
            let timestamp:Double = hTimstamp - x * 3600
            //将时间戳转化为小时
            let date = Date.init(timeIntervalSince1970: timestamp)
            let dformatter = DateFormatter()
            dformatter.dateFormat = "HH"
            //日期转化为字符串
            let hStr = dformatter.string(from: date)
            //根据时间戳获取小时
            timestampArray.append(Int(hStr)!)
        }
        print(timestampArray)
        
        return timestampArray
    }
    
}


