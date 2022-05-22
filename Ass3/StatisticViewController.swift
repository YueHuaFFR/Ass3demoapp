//
//  StatisticViewController.swift
//  Ass3
//
//  Created by Bob on 2022/5/19.
//

import UIKit
import Charts

let ScreenHeight = UIScreen.main.bounds.size.height
let ScreenWidth = UIScreen.main.bounds.size.width

class StatisticViewController: UIViewController {
    var pieChartView: PieChartView  = PieChartView()
    var data: PieChartData = PieChartData()

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var startDate: UIDatePicker!
    var datasource: [NSDictionary] = [NSDictionary]()
    var FoodSouce: [NSDictionary] = [NSDictionary]()
    var HouseSouce: [NSDictionary] = [NSDictionary]()
    var TransportationSouce: [NSDictionary] = [NSDictionary]()
    var EntertainmentSouce: [NSDictionary] = [NSDictionary]()
    var ShopSouce: [NSDictionary] = [NSDictionary]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Statistic"
        //添加饼状图
        addPieChart()
        //设置基本样式
        setPieChartViewBaseStyle()
        
    }
    
    //添加饼状图
    func addPieChart(){
        pieChartView.backgroundColor = ZHFColor.white
        pieChartView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.size.width, height: contentView.bounds.size.height)
        pieChartView.delegate = self
        contentView.addSubview(pieChartView)
    }
    func setPieChartViewBaseStyle(){
        //基本样式
        pieChartView.setExtraOffsets(left: 30, top: 30, right: 30, bottom: 0)//饼状图距离边缘的间隙
        pieChartView.usePercentValuesEnabled = true//是否根据所提供的数据, 将显示数据转换为百分比格式
        pieChartView.dragDecelerationEnabled = true//拖拽饼状图后是否有惯性效果
        pieChartView.drawSlicesUnderHoleEnabled = true//是否显示区块文本

        //空（实）心饼状图样式
        pieChartView.drawHoleEnabled = true//饼状图是否是空心 true为空心 false为实心
        pieChartView.holeRadiusPercent = 0.5//空心半径占比
        pieChartView.holeColor = ZHFColor.white//空心颜色 这个不能设置成clear
        pieChartView.transparentCircleRadiusPercent = 0.54//半透明空心半径占比
        pieChartView.transparentCircleColor = ZHFColor.zhf_colorAlpha(withHex: 0xffffff, alpha: 0.4)//半透明空心的颜色
        //饼状图中间描述
        if pieChartView.isDrawHoleEnabled == true {
            pieChartView.drawCenterTextEnabled = true
            pieChartView.centerText = ""
        }
        else{}
        //饼状图描述
        pieChartView.chartDescription?.text = ""
        pieChartView.chartDescription?.font = UIFont.systemFont(ofSize: 10)
        pieChartView.chartDescription?.textColor = ZHFColor.zhf33_titleTextColor
        //饼状图图例
         let l = pieChartView.legend
        l.maxSizePercent = 1 //图例在饼状图中的大小占比, 这会影响图例的宽高
        l.formToTextSpace = 5 //文本间隔
        l.font = UIFont.systemFont(ofSize: 10)//字体大小
        l.textColor = ZHFColor.gray//字体颜色
        l.form = Legend.Form.circle//图示样式: 方形、线条、圆形
        //图例在饼状图中的位置(上局中、 水平布局)
        l.horizontalAlignment = Legend.HorizontalAlignment.center
        l.verticalAlignment = Legend.VerticalAlignment.top
        l.orientation = Legend.Orientation.horizontal //水平布局
        l.formSize = 12;//图示大小
    }
    @objc func updataData(){
        //对应x轴上面需要显示的数据
        let tempArr = NSMutableArray.init()
        var price = 0.0
        if FoodSouce.count > 0 {
            tempArr.add(FoodSouce)
            for dict in FoodSouce {
                let money = dict["money"] as! String
                let pricetemp = Double(money)
                price += pricetemp!
            }
        }
        if HouseSouce.count > 0 {
            tempArr.add(HouseSouce)
            for dict in HouseSouce {
                let money = dict["money"] as! String
                let pricetemp = Double(money)
                price += pricetemp!
            }
        }
        if TransportationSouce.count > 0 {
            tempArr.add(TransportationSouce)
            for dict in HouseSouce {
                let money = dict["money"] as! String
                let pricetemp = Double(money)
                price += pricetemp!
            }
        }
        if EntertainmentSouce.count > 0 {
            tempArr.add(EntertainmentSouce)
            for dict in HouseSouce {
                let money = dict["money"] as! String
                let pricetemp = Double(money)
                price += pricetemp!
            }
        }
        if ShopSouce.count > 0 {
            tempArr.add(ShopSouce)
            for dict in HouseSouce {
                let money = dict["money"] as! String
                let pricetemp = Double(money)
                price += pricetemp!
            }
        }
            
            
        let count = tempArr.count
        //对应Y轴上面需要显示的数据
        let yVals: NSMutableArray  = NSMutableArray.init()
        for i in 0 ..< count {
            let arrDic = tempArr[i] as! NSArray
            let dict = arrDic[0] as! NSDictionary
            let val: Double = Double(arrDic.count)
            let entry:PieChartDataEntry  = PieChartDataEntry.init(value: val, label: (dict["cagtegory"] as! String))
           // let entry:BarChartDataEntry  = BarChartDataEntry.init(x:  Double(i), y: Double(val))
            yVals.add(entry)
        }
        //创建PieChartDataSet对象
        let labelStr = "TotalPrice:  " + String(price)
        let set1: PieChartDataSet = PieChartDataSet.init(entries: yVals as? [ChartDataEntry], label: labelStr)
        set1.drawIconsEnabled = false //是否在饼状图上面显示图片
        set1.sliceSpace = 2 //相邻区块之间的间距
        set1.selectionShift = 8//选中区块时, 放大的半径
        set1.drawValuesEnabled = true //是否在饼状图上面显示数值
        set1.highlightEnabled = true //点击选饼状图是否有高亮效果，（单击空白处取消选中）
    set1.setColors(ZHFColor.gray,ZHFColor.blue,ZHFColor.red,ZHFColor.zhf_randomColor(),ZHFColor.zhf_randomColor())//设置柱形图颜色(是一个循环，例如：你设置5个颜色，你设置8个柱形，后三个对应的颜色是该设置中的前三个，依次类推)
        //  set1.setColors(ChartColorTemplates.material(), alpha: 1)
        //  set1.setColor(ZHFColor.gray)//颜色一致
        
        set1.xValuePosition = PieChartDataSet.ValuePosition.insideSlice//名称位置
        //PieChartDataSet.ValuePosition.insideSlice 数据显示在饼图内部
        let dataSets: NSMutableArray  = NSMutableArray.init()
        dataSets.add(set1)
        //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
        let data:  PieChartData = PieChartData.init(dataSets: dataSets as? [IChartDataSet])
        let formatter: NumberFormatter = NumberFormatter.init()
        //formatter.numberStyle = NumberFormatter.Style.currency//自定义数据显示格式  小数点形式(可以尝试不同看效果)
        formatter.numberStyle = NumberFormatter.Style.percent //自定义数据显示格式  小数点形式(可以尝试不同看效果)
        formatter.maximumFractionDigits = 0
        formatter.multiplier = 1
        let forma :DefaultValueFormatter = DefaultValueFormatter.init(formatter: formatter)
        data.setValueFormatter(forma)
        data.setValueFont(UIFont.systemFont(ofSize: 10))
        data.setValueTextColor(ZHFColor.orange)
        pieChartView.data = data
        pieChartView.animate(xAxisDuration: 1, easingOption: ChartEasingOption.easeOutExpo)
    }
    
    
    @IBAction func calculateClick(_ sender: Any) {

        if startDate.date.compare(endDate.date) == .orderedDescending {
            let nameAlert = UIAlertController(title: "Alert", message: "The start date should be smaller than the end date", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel)
            nameAlert.addAction(ok)
            present(nameAlert, animated: true, completion: nil)
        }
        
        getData()
    }
    
    func getData() {
        // 本地获取数据
         let tfArray = NSArray(contentsOfFile:NSHomeDirectory() + "/Documents/tfDic.plist") as! [NSDictionary]
        var i = 0
        while i < tfArray.count {
            let model = tfArray[i]
            let modeldateStr = model["date"] as! String
            let modeldate = stringConvertDate(string: modeldateStr)
            if (endDate.date.compare(modeldate) == .orderedDescending) && (modeldate.compare(startDate.date) == .orderedDescending) {
                
                let cagtegory = model["cagtegory"] as! String

                if cagtegory == "Food" {
                    FoodSouce.append(model)
                } else if cagtegory == "House" {
                    HouseSouce.append(model)
                } else if cagtegory == "Transportation" {
                    TransportationSouce.append(model)
                } else if cagtegory == "Entertainment" {
                    EntertainmentSouce.append(model)
                } else if cagtegory == "Shop" {
                    ShopSouce.append(model)
                }
            }
            i += 1
        }
        
        //3.添加（刷新数据）
        updataData()
    }
    
    func stringConvertDate(string:String, dateFormat:String="yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: string)
        return date!
    }
}

extension StatisticViewController :ChartViewDelegate {
    //1.点击选中
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
    }
    //2.没有选中
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        
    }
    //3.捏合放大或缩小
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        
    }
    //4.拖拽图表
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        
    }
}
