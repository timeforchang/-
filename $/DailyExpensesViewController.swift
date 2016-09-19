//
//  DailyExpensesViewController.swift
//  $
//
//  Created by Andrew on 6/14/16.
//
//

import UIKit
import CoreData

class DailyExpensesViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var earnedLabel: UILabel!
    @IBOutlet weak var spentLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let defaults = NSUserDefaults.standardUserDefaults()
        //refreshLabels()
        //defaults.setFloat(total, forKey: "Total")
        //self.totalLabel.text = defaults.stringForKey("tLabel")
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        getSum()
        getGreen()
        getRed()
        
        refreshLabels()
        
        resetGlobals()
    }
    
    @IBAction func plusButtonPress(sender: UIButton)
    {
        //refreshLabels()
    }
    
    @IBAction func minusButtonPress(sender: UIButton)
    {
        //refreshLabels()
    }
    
    @IBAction func clearButtonPress(sender: UIButton)
    {
        /*let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("Earned")
        defaults.removeObjectForKey("Spent")
        defaults.removeObjectForKey("Total")
        earnLabel = "$" + String(defaults.floatForKey("Earned"))
        spendLabel = "$" + String(defaults.floatForKey("Spent"))
        totalsLabel = "$" + String(defaults.floatForKey("Total"))
        defaults.setObject(earnLabel, forKey: "eLabel")
        defaults.setObject(spendLabel, forKey: "sLabel")
        defaults.setObject(totalsLabel, forKey: "tLabel")
        defaults.synchronize()
        self.earnedLabel.text = defaults.stringForKey("eLabel")
        self.spentLabel.text = defaults.stringForKey("sLabel")
        self.totalLabel.text = defaults.stringForKey("tLabel")*/
        
        clearAll()
        getSum()
        getGreen()
        getRed()
        refreshLabels()
    }
    
    func refreshLabels()
    {
        /*let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        self.earnedLabel.text = defaults.stringForKey("eLabel")
        self.spentLabel.text = defaults.stringForKey("sLabel")
        self.totalLabel.text = defaults.stringForKey("tLabel")
        //moneyRealm.deleteAll()*/
        
        self.totalLabel.text = "$" + String(sum)
        self.earnedLabel.text = "$" + String(green)
        self.spentLabel.text = "$" + String(red)
        
        //print(self.totalLabel.text)
        //print(self.earnedLabel.text)
        //print(self.spentLabel.text)
    }
    
    func getSum() -> Float
    {
        //query an array of Expenses
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
        
        //get total, earned, and spent values
        if expenses.count > 0
        {
            for price in expenses
            {
                sum += Float(price.cost!)
            }
        }
        else
        {
            sum = 0
        }
        
        return sum
    }
    
    func getGreen() -> Float
    {
        //query an array of Expenses
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
        
        //get total, earned, and spent values
        if expenses.count > 0
        {
            for price in expenses
            {
                if Float(price.cost!) > 0
                {
                    green += Float(price.cost!)
                }
                else
                {
                    green += 0
                }
            }
        }
        else
        {
            green = 0
        }
        
        return green
    }
    
    func getRed() -> Float
    {
        //query an array of Expenses
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
        
        //get total, earned, and spent values
        if expenses.count > 0
        {
            for price in expenses
            {
                if Float(price.cost!) < 0
                {
                    red += Float(price.cost!)
                }
                else
                {
                    red += 0
                }
            }
        }
        else
        {
            red = 0
        }
        
        return red
    }
    
    func clearAll()
    {
        let request = NSFetchRequest(entityName: "Expense")
        let context: NSManagedObjectContext = DataController().managedObjectContext
        
        request.returnsObjectsAsFaults = false
        
        do
        {
            let incidents = try context.executeFetchRequest(request)
            
            if incidents.count > 0
            {
                
                for result: AnyObject in incidents
                {
                    context.deleteObject(result as! NSManagedObject)
                    print("NSManagedObject has been Deleted")
                }
                try context.save()
            }
        }
        catch let error as NSError
        {
            // failure
            print("Clear failed: \(error.localizedDescription)")
        }
    }
    
    func resetGlobals()
    {
        sum = 0
        green = 0
        red = 0
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

