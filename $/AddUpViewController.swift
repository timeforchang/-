//
//  AddUpViewController.swift
//  $
//
//  Created by Andrew on 6/14/16.
//
//

import UIKit
import CoreData

class AddUpViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    
    @IBOutlet weak var addUpField: UITextField!
    @IBOutlet weak var addUpTypeField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var tempAddTypeOptions: [String]
    {
        return (defaults.arrayForKey("AddType") as? [String])!
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
            addButton.enabled = false
        addUpField.addTarget(self, action: #selector(AddUpViewController.checkFields), forControlEvents: .EditingDidEnd)
        addUpTypeField.addTarget(self, action: #selector(AddUpViewController.checkFields), forControlEvents: .EditingDidEnd)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddUpViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        var addPickerView = UIPickerView()
        addPickerView.delegate = self
        addUpTypeField.inputView = addPickerView
    }
    
    override func viewWillAppear(animated: Bool)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        var tempAddTypeOptions = defaults.arrayForKey("AddType")
    }
    
    @IBAction func addButtonPress(sender: UIButton)
    {
        /*let income = Expense()
        income.makeCost(strValue!)
        try! moneyRealm.write
        {
            moneyRealm.add(income)
        }*/
        addMoney()
        //DailyExpensesViewController().refreshLabels()
        /*let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setFloat(earned, forKey: "Earned")
        defaults.setFloat(total, forKey: "Total")
        earnLabel = "$" + String(defaults.floatForKey("Earned"))
        totalsLabel = "$" + String(defaults.floatForKey("Total"))
        defaults.setObject(earnLabel, forKey: "eLabel")
        defaults.setObject(totalsLabel, forKey: "tLabel")
        defaults.synchronize()*/
    }
    
    func addMoney()
    {
        let str = addUpField.text
        let strValue = str?.floatValue
        let typeStr = addUpTypeField.text
        
        // create an instance of our managedObjectContext
        let moc = DataController().managedObjectContext
        
        // we set up our entity by selecting the entity and context that we're targeting
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Expense", inManagedObjectContext: moc) as! Expense
        
        // add our data
        entity.setValue(strValue!, forKey: "cost")
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
    
    func refreshAddList()
    {
        
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
            let charge = addUpField.text where !charge.isEmpty,
            let kind = addUpTypeField.text where !kind.isEmpty
        else {return}
            
        addButton.enabled = true
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return tempAddTypeOptions.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return tempAddTypeOptions[row] 
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        addUpTypeField.text = tempAddTypeOptions[row] 
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

