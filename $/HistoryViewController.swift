//
//  HistoryViewController.swift
//  $
//
//  Created by Andrew on 6/14/16.
//
//

import UIKit
import CoreData

class HistoryViewController: UIViewController
{
    //@IBOutlet weak var historyPicker: UIDatePicker!

    @IBOutlet weak var monthPicker: MonthYearPickerView!
    
    override func viewDidLoad()
    {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM"
        seedDate = formatter.stringFromDate(currDate)
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        //var formatter = NSDateFormatter()
        //formatter.dateFormat = "yyyy-MM-dd HH:mm ZZZ"
    }
    /*let listOfExpenses = moneyRealm.objects(Expense.self)
    for i in 0..<5
    {
        mostRecent = listOfExpenses[i]
        return mostRecent
    }*/
    
    /*@IBAction func testButtonPress(sender: UIButton)
    {
        self.testLabel.text = String(mostRecent)
    }*/

    @IBAction func goButtonPress(sender: UIButton)
    {
        monthPicker!.onDateSelected = {(month: Int, year: Int) in
            let string = String(format: "%d-%02d", year, month)
            NSLog(string) // should show something like 05/2015
            seedDate = string
        }
        //print(seedDate)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

