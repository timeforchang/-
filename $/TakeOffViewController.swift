//
//  AddUpViewController.swift
//  $
//
//  Created by Andrew on 6/14/16.
//
//

import UIKit
import CoreData

class TakeOffViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    
    @IBOutlet weak var takeOffField: UITextField!
    @IBOutlet weak var takeOffTypeField: UITextField!
    
    @IBOutlet weak var subtractButton: UIButton!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var tempSpendTypeOptions: [String]
    {
        return (defaults.arrayForKey("SpendType") as? [String])!
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        subtractButton.enabled = false
        takeOffField.addTarget(self, action: #selector(TakeOffViewController.checkFields), forControlEvents: .EditingDidEnd)
        takeOffTypeField.addTarget(self, action: #selector(TakeOffViewController.checkFields), forControlEvents: .EditingDidEnd)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TakeOffViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        var subtractPickerView = UIPickerView()
        subtractPickerView.delegate = self
        takeOffTypeField.inputView = subtractPickerView
    }
    
    override func viewWillAppear(animated: Bool)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        var tempSpendTypeOptions = defaults.arrayForKey("SpendType")
    }
    
    @IBAction func subtractButtonPress(sender: UIButton)
    {
        /*let str = takeOffField.text
        let strValue = str?.floatValue
        spent -= strValue!
        total -= strValue!*/
        subtractMoney()
        /*let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setFloat(spent, forKey: "Spent")
        defaults.setFloat(total, forKey: "Total")
        spendLabel = "$" + String(defaults.floatForKey("Spent"))
        totalsLabel = "$" + String(defaults.floatForKey("Total"))
        defaults.setObject(spendLabel, forKey: "sLabel")
        defaults.setObject(totalsLabel, forKey: "tLabel")
        defaults.synchronize()*/
    }
    
    func subtractMoney()
    {
        let str = takeOffField.text
        let strValue = (str?.floatValue)!*(-1)
        let typeStr = takeOffTypeField.text
        
        // create an instance of our managedObjectContext
        let moc = DataController().managedObjectContext
        
        // we set up our entity by selecting the entity and context that we're targeting
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Expense", inManagedObjectContext: moc) as! Expense
        
        // add our data
        entity.setValue(strValue, forKey: "cost")
        entity.setValue(typeStr, forKey: "type")
        entity.setValue(NSDate(), forKey: "date")
        
        // we save our entity
        do
        {
            try moc.save()
        }
        catch
        {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard()
    {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func checkFields(sender : UITextField)
    {
        sender.text = sender.text?.stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
        guard
            let charge = takeOffField.text where !charge.isEmpty,
            let kind = takeOffTypeField.text where !kind.isEmpty
            else {return}
        
        subtractButton.enabled = true
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return tempSpendTypeOptions.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return tempSpendTypeOptions[row] 
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        takeOffTypeField.text = tempSpendTypeOptions[row] 
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

