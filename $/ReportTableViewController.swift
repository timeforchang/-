//
//  ReportTableViewController.swift
//  $
//
//  Created by Andrew on 6/16/16.
//
//

import UIKit
import CoreData

class ReportTableViewController: UITableViewController
{
    var expenseReport = [Expense]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loadReport()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadReport() -> NSArray
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
                expenseReport.append(entry)
            }
        }
        
        return expenseReport
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return expenseReport.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // Table view cells are reused and should be dequeued using a cell identifier.
        //let cellIdentifier = "ExpenseTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier("ExpenseTableViewCell") as! ExpenseTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        if expenseReport.count > 0
        {
            let item = expenseReport[indexPath.row]
            var formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            //if item.cost == nil {
            
            if item.cost != nil
            {
                cell.costLabel?.text = "$" + String(item.cost!)
            }
            
            if item.type != nil
            {
                cell.typeLabel.text = item.type
            }
            
            if item.date != nil
            {
                cell.dateLabel.text = formatter.stringFromDate(item.date!)
            }
            //}
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
