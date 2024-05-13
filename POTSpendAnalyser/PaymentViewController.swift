//
//  PaymentViewController.swift
//  POTSpendAnalyser
//
//  Created by Shanthakumar Vm on 11/05/24.
//

import UIKit
import Foundation

class PaymentViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var amountField: UITextField!
    
    
    @IBOutlet weak var transactionTextField: UITextField!
    
    
    @IBOutlet weak var CustomerIDTextField: UITextField!
    
    @IBOutlet weak var paymentTypeSegmentControl: UISegmentedControl!
    

    // MARK: - Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentTypeSegmentControl.setTitle("Make Payment", forSegmentAt: 0)
        paymentTypeSegmentControl.setTitle("Receive Payment", forSegmentAt: 1)
            
    }
    
    @IBAction func submitTransaction(_ sender: UIButton) {
        
        guard let customerId = CustomerIDTextField.text,
              let transactionDescription = transactionTextField.text,
              let amountText = amountField.text,
              let amount = Double(amountText),
              let paymentType = PaymentType(rawValue: paymentTypeSegmentControl.selectedSegmentIndex) else {
            displayAlert(message: "Please fill in all fields correctly.")
            return
        }
        
        let transaction = Transaction(customerId: customerId,
                                      transactionDescription: transactionDescription,
                                      amount: amount,
                                      paymentType: paymentType,
                                      dateTime: Date())
        
        saveTransactionLocally(transaction: transaction)
        displayAlert(message: "Transaction saved locally.")
        clearFields()
        
        
    }
    
    
   
    
    // MARK: - Helper methods
    
    func displayAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    func clearFields() {
        CustomerIDTextField.text = ""
        transactionTextField.text = ""
        amountField.text = ""
        paymentTypeSegmentControl.selectedSegmentIndex = 0
    }
    
    func saveTransactionLocally(transaction: Transaction) {
        var savedTransactions = loadTransactions() // Load existing transactions
        
        savedTransactions.append(transaction) // Append new transaction
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(savedTransactions) {
            UserDefaults.standard.set(encoded, forKey: "savedTransactions") // Save transactions to UserDefaults
        } else {
            print("Failed to encode transactions.")
        }
    }
    
    func loadTransactions() -> [Transaction] {
        if let savedTransactionsData = UserDefaults.standard.data(forKey: "savedTransactions") {
            let decoder = JSONDecoder()
            if let savedTransactions = try? decoder.decode([Transaction].self, from: savedTransactionsData) {
                return savedTransactions
            }
        }
        return []
    }
}

struct Transaction: Codable {
    let customerId: String
    let transactionDescription: String
    let amount: Double
    let paymentType: PaymentType
    let dateTime: Date
}

enum PaymentType: Int, Codable {
    case makePayment = 0
    case receivePayment = 1
}
