//
//  ProductTableViewController.swift
//  AisleConnectTest
//
//  Created by 黃昌齊 on 2021/8/10.
//

import UIKit

class ProductTableViewController: UITableViewController {
    
    var product: Product?
    var id = 0
    var accessToken = ""
    var imageUrl = URL(string: "")
    
    @IBOutlet var contentView: ContentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("id:", id)
        print("Access token:", accessToken)
        let urlStr = "https://apistage2.aisleconnect.us/ac.server/rest/v2.5/product/\(id)?access_token=\(accessToken)"
        ConnectController.shared.fetchProductsData(urlStr: urlStr) { (result) in
            switch result {
            
            case .success(let product):
                self.updateUI(with: product)
            case .failure(let error):
                self.displayError(error, title: "Fail to fetch the data.")
            }
        }
        
        if let imageUrl = imageUrl {
            ConnectController.shared.fetchImage(url: imageUrl) { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    self.contentView.imageView.image = image
                }
            }
        }
    }
    
    func updateUI(with product: Product) {
        DispatchQueue.main.async {
            self.product = product
            self.navigationItem.title = product.data.name
            self.tableView.reloadData()
        }
    }
    
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "dissmiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return contentView
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        
        if let description = product?.data.description {
            cell.descriptionLabel.text = description
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
