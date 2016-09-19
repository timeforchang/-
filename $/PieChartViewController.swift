//
//  PieChartViewController.swift
//  $
//
//  Created by Andrew on 6/27/16.
//
//

import UIKit
import CoreData
import Charts

class PieChartViewController: UIViewController
{
    @IBOutlet weak var pieChartView: PieChartView!
    
    var aggregatePieChartReport = [Expense]()
    var typeReport = [String]()
    var uniqueTypes = [String]()
    var expenseArray = [Double]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        pieChartView.noDataText = "No data available for selected month."
        pieChartView.descriptionText = ""
        
        loadAggregateReport()
        getTypes()
        getExpenses()
        
        setChart(uniqueTypes, values: expenseArray)
    }
    
    func loadAggregateReport() -> NSArray
    {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM"
        let seedDateString = seedDate
        
        var expenses  = [Expense]()
        let request = NSFetchRequest(entityName: "Expense")
        let context: NSManagedObjectContext = DataController().managedObjectContext
        
        do
        {
            expenses = try context.executeFetchRequest(request) as! [Expense]
            // success ...
        }
        catch let error as NSError
        {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        for entry in expenses
        {
            let entryDateString = formatter.stringFromDate(entry.date!)
            
            if entryDateString == seedDateString
            {
                if Float(entry.cost!) < 0 as Float
                {
                    aggregatePieChartReport.append(entry)
                }
            }
        }
        
        return aggregatePieChartReport
    }
    
    func getTypes() -> [String]
    {
        for entry in aggregatePieChartReport
        {
            typeReport.append(entry.type!)
        }
        uniqueTypes = Array(Set(typeReport))
        
        //print(uniqueTypes)
        return uniqueTypes
    }
    
    func getExpenses() -> [Double]
    {
        for var i in 0..<uniqueTypes.count
        {
            var sum = 0 as Double
            for entry in aggregatePieChartReport
            {
                if entry.type!==uniqueTypes[i]
                {
                    sum += Double(entry.cost!)
                }
            }
            expenseArray.append(sum*(-1))
        }
        //print(expenseArray)
        return expenseArray
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
    }
    
    /*func getTypes() -> [String]
    {
        let reportTypes = Set(typeReport)
        return reportTypes
    }*/
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}