//
//  MoreViewController.swift
//  $
//
//  Created by Andrew on 6/27/16.
//
//

import UIKit
import CoreData

class MoreViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var addOrSubtractField: UITextField!
    @IBOutlet weak var addCategoryButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        addCategoryButton.enabled = false
        categoryField.addTarget(self, action: #selector(MoreViewController.checkFields), forControlEvents: .EditingDidEnd)
        addOrSubtractField.addTarget(self, action: #selector(MoreViewController.checkFields), forControlEvents: .EditingDidEnd)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TakeOffViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        var addOrSubtractPickerView = UIPickerView()
        addOrSubtractPickerView.delegate = self
        addOrSubtractField.inputView = addOrSubtractPickerView
    }
    
    
    @IBAction func addCategoryButtonPress(sender: UIButton)
    {
        addCategory()
    }
    
    func addCategory()
    {
        let catName = categoryField.text
        let addOrSubtractName = addOrSubtractField.text
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if addOrSubtractName == "Add"
        {
            var tempAddOptionsArray = defaults.arrayForKey("AddType")
            tempAddOptionsArray?.append(catName!)
            defaults.setObject(tempAddOptionsArray, forKey: "AddType")
            defaults.synchronize()
        }
        else if addOrSubtractName == "Subtract"
        {
            var tempSpendOptionsArray = defaults.arrayForKey("SpendType")
            tempSpendOptionsArray?.append(catName!)
            defaults.setObject(tempSpendOptionsArray, forKey: "SpendType")
            defaults.synchronize()
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
            let category = categoryField.text where !category.isEmpty,
            let addOrSubtract = addOrSubtractField.text where !addOrSubtract.isEmpty
            else {return}
        
        addCategoryButton.enabled = true
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return addOrSubtractOption.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return addOrSubtractOption[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        addOrSubtractField.text = addOrSubtractOption[row]
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}