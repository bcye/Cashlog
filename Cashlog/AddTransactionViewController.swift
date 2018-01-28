//
//  ViewController.swift
//  MoneyTracker
//
//  Created by Bruce Roettgers on 27.12.17.
//  Copyright © 2017 bcye. All rights reserved.
//

import UIKit
import CoreData

class AddTransactionViewController: UIViewController, UITextFieldDelegate {
    
    //will be passed through by tableViewController
    var managedObjectContext: NSManagedObjectContext!
    
    //MARK: Custom NumPad Functions
    var isIncome = true
    var firstNumEnter = true
    
    @IBAction func seven(_ sender: Any) {
        if firstNumEnter == true {
            amountLabel.text = "7"
            firstNumEnter = false
        } else {
        amountLabel.text! += "7"
        }
    }
    @IBAction func eight(_ sender: Any) {
        if firstNumEnter == true {
            amountLabel.text = "8"
            firstNumEnter = false
        } else {
            amountLabel.text! += "8"
        }
    }
    @IBAction func nine(_ sender: Any) {
        if firstNumEnter == true {
            amountLabel.text = "9"
            firstNumEnter = false
        } else {
            amountLabel.text! += "9"
        }
    }
    @IBAction func four(_ sender: Any) {
        if firstNumEnter == true {
            amountLabel.text = "4"
            firstNumEnter = false
        } else {
            amountLabel.text! += "4"
        }
    }
    @IBAction func five(_ sender: Any) {
        if firstNumEnter == true {
            amountLabel.text = "5"
            firstNumEnter = false
        } else {
            amountLabel.text! += "5"
        }
    }
    @IBAction func six(_ sender: Any) {
        if firstNumEnter == true {
            amountLabel.text = "6"
            firstNumEnter = false
        } else {
            amountLabel.text! += "6"
        }
    }
    @IBAction func one(_ sender: Any) {
        if firstNumEnter == true {
            amountLabel.text = "1"
            firstNumEnter = false
        } else {
            amountLabel.text! += "1"
        }
    }
    @IBAction func two(_ sender: Any) {
        if firstNumEnter == true {
            amountLabel.text = "2"
            firstNumEnter = false
        } else {
            amountLabel.text! += "2"
        }
    }
    @IBAction func three(_ sender: Any) {
        if firstNumEnter == true {
            amountLabel.text = "3"
            firstNumEnter = false
        } else {
            amountLabel.text! += "3"
        }
    }
    @IBAction func dot(_ sender: Any) {
        if firstNumEnter == true {
            amountLabel.text = "0."
            firstNumEnter = false
        } else {
            amountLabel.text! += "."
        }
    }
    @IBAction func zero(_ sender: Any) {
        if firstNumEnter == true {
            amountLabel.text = "0"
            firstNumEnter = false
        } else {
            amountLabel.text! += "0"
        }
    }
    @IBAction func deleteOneNum(_ sender: Any) {
        if firstNumEnter == false {
            amountLabel.text = String(amountLabel.text!.dropLast())
        }
    }
    
    //Text variables
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var titelInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.titelInput.delegate = self
        //Secures that amountLabel contains a text at all time
        if amountLabel.text == nil {
            amountLabel.text = "0.00"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Hides the keyboard when pressing Done on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //MARK: Income/Expense functions
    @IBAction func income(_ sender: Any) {
        isIncome = true
    }
    @IBAction func expense(_ sender: Any) {
        isIncome = false
    }
    
    
    //MARK: Navigation Items
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        
        //Saves passed item
        guard let text = titelInput.text, !text.isEmpty else { return }
        
        let item = NSEntityDescription.insertNewObject(forEntityName: "Transaction", into: managedObjectContext) as! Transaction
        item.text = text
        item.isPositive = isIncome
        item.amount = Float(amountLabel.text!)!
        item.date = NSDate()
        managedObjectContext.saveChanges(viewController: self)
        print("Transaction successfully saved!")
        
        //Calls the function to update the total
        let presentedBy = presentingViewController as? TableViewController
        presentedBy?.changeNavTitle()
        
        dismiss(animated: true, completion: nil)
    }
    

    
}


