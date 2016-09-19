//
//  SegmentedControlViewController.swift
//  $
//
//  Created by Andrew on 6/27/16.
//
//

import UIKit
import CoreData

class SegmentedControlViewController: UIViewController
{
    @IBOutlet weak var listViewContainer: UIView!
    @IBOutlet weak var pieChartContainer: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func switchContainers(sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0
        {
            UIView.animateWithDuration(0.5, animations: {
                    self.listViewContainer.alpha = 1
                    self.pieChartContainer.alpha = 0})
        }
        else
        {
            UIView.animateWithDuration(0.5, animations: {
                self.listViewContainer.alpha = 0
                self.pieChartContainer.alpha = 1})
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}