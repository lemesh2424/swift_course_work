//
//  AddProductViewController.swift
//  kursach
//
//  Created by Oleh Lemeshenko on 5/10/19.
//  Copyright © 2019 Oleh Lemeshenko. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
  func itemDetailViewControllerDidCancel(_ controller: AddProductViewController)
  func itemDetailViewController(_ controller: AddProductViewController, didFinishAdding item: Product)
  func itemDetailViewController(_ controller: AddProductViewController, didFinishEditing item: Product)
}

class AddProductViewController: UIViewController {
  @IBOutlet weak var priceField: UITextField!
  @IBOutlet weak var nameField: UITextField!
  
  weak var delegate: AddItemViewControllerDelegate?
  var itemToEdit: Product?
  @IBOutlet weak var doneButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    if let item = itemToEdit {
      nameField.text = item.name
      priceField.text = String(item.price)
      doneButton.isEnabled = true
    }
  }
  
  @IBAction func done(_ sender: UIBarButtonItem) {
    if let item = itemToEdit {
      item.name = nameField.text ?? "Product"
      item.price = Double(priceField.text ?? "1") ?? 1
      delegate?.itemDetailViewController(self, didFinishEditing: item)
    } else {
      let item = Product(name: nameField.text ?? "Product", price: Double(priceField.text ?? "1") ?? 1, category: "Product")
      delegate?.itemDetailViewController(self, didFinishAdding: item)
    }
  }
}
