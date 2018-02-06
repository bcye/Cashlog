//
//  TableViewController.swift
//  MoneyTracker
//
//  Created by Bruce Roettgers on 27.12.17.
//  Copyright © 2017 bcye. All rights reserved.
//

import CoreData
import UIKit

class TableViewController: UITableViewController {
    
    //Array of all transactions used for the total
    var transactions = [Transaction]() {
        didSet {
            var sum: Double = 0
            for transaction in transactions {
                if transaction.isPositive {
                    sum += transaction.amount
                } else {
                    sum -= transaction.amount
                }
            }
            titleNav.title = "\(sum)\(currencySymbol)"
        }
    }
    
    //Total Label
    @IBOutlet weak var titleNav: UINavigationItem!
    //Currency of your region set up in iphone settings
    let currencySymbol = Currency().getSymbol()
    let managedObjectContext = CoreDataStack().managedObjectContext
    //fetchedResultsController also with coredata, works with tableView cant use for total (or can I)
    lazy var fetchedResultsController: TransactionFetchedResultsController = {
        return TransactionFetchedResultsController(moc: self.managedObjectContext, tableViewController: self)
    }()
    
    //Function fetches data and calcs the total
    func changeNavTitle() {
            
            let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
            
            do {
                transactions = try managedObjectContext.fetch(request)
            } catch {
                error.alert(with: self, error: .fetchFailed)
                print("Error: \(error)")
            }
            
            var sum: Double = 0
            for transaction in transactions {
                if transaction.isPositive {
                    sum += transaction.amount
                } else {
                    sum -= transaction.amount
                }
            }
            titleNav.title = "\(sum)\(currencySymbol)"
            fetchedResultsController.changedContent = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Fetch for total at start of app
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        
        do {
            transactions = try managedObjectContext.fetch(request)
        } catch {
            error.alert(with: self, error: .fetchFailed)
            print("Error: \(error)")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! TableViewCell

        // Configure the cell...
        
        return configureCell(cell, at: indexPath)
    }
    
    //Deleting objects
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        transactions.remove(at: indexPath.row)
        let item = fetchedResultsController.object(at: indexPath)
        managedObjectContext.delete(item)
        managedObjectContext.saveChanges(viewController: self)
    }
    
    //Configuring cell based on Core Data called in tableView cellForRowAt
    private func configureCell(_ cell: TableViewCell, at indexPath: IndexPath) -> TableViewCell {
        let transaction = fetchedResultsController.object(at: indexPath)
        /* cell.textLabel?.text = transaction.text
        if transaction.isPositive {
            cell.detailTextLabel?.text = "\(transaction.amount)\(currencySymbol)"
            cell.detailTextLabel?.textColor = UIColor.green
        } else {
            cell.detailTextLabel?.text = "-\(transaction.amount)\(currencySymbol)"
            cell.detailTextLabel?.textColor = UIColor.red
        } */
        
        cell.title.text = transaction.text
        cell.date.text = DateFormatter().stringWithOptions(dateStyle: .medium, date: transaction.date!, locale: Locale.current)
        if transaction.isPositive {
            cell.amount.text = "\(transaction.amount)\(currencySymbol)"
            cell.amount.textColor = UIColor.green
        } else {
            cell.amount.text = "-\(transaction.amount)\(currencySymbol)"
            cell.amount.textColor = UIColor.red
        }
        
        return cell
    }
    
    //MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    //passes managedObjectContext to AddVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTransaction" {
            let navigationController = segue.destination as! UINavigationController
            let addTransactionController = navigationController.topViewController as! AddTransactionViewController
            addTransactionController.managedObjectContext = self.managedObjectContext
        }
    }
}

