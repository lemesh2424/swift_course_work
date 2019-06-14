//
//  CustomerViewController.swift
//  kursach
//
//  Created by Oleh Lemeshenko on 5/10/19.
//  Copyright © 2019 Oleh Lemeshenko. All rights reserved.
//

import UIKit

let user = User()
var productsInOrder = 0

class CustomerViewController: UIViewController {
@IBOutlet weak var tableView: UITableView!
  let shop = Shop.shared
  
  @IBOutlet weak var ordersCount: UILabel!
  @IBOutlet weak var orderPrice: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    view.addSubview(tableView)
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    ordersCount.text = "\(productsInOrder)"
    if let sum = user.getPrice() {
      orderPrice.text = "\(sum)$"
    }
  }
  @IBAction func closeOrder(_ sender: UIBarButtonItem) {
    user.closeOrder()
    user.checkLastOrderStatus()
    user.checkLastOrderStatus()
    productsInOrder = 0
    ordersCount.text = "\(productsInOrder)"
    orderPrice.text = "0$"
  }
}

extension CustomerViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = "\(shop.products[indexPath.row].name) - \(shop.products[indexPath.row].price)$"
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shop.products.count
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if productsInOrder == 0 {
      user.createOrder(product: shop.products[indexPath.row])
      if let sum = user.getPrice() {
        orderPrice.text = "\(sum)$"
      }
      productsInOrder += 1
      ordersCount.text = "\(productsInOrder)"
    } else {
      user.addToLastOrder(product: shop.products[indexPath.row])
      if let sum = user.getPrice() {
        orderPrice.text = "\(sum)$"
      }
      productsInOrder += 1
      ordersCount.text = "\(productsInOrder)"
    }
  }
}
