//
//  ListDetailTableViewController.swift
//  AisleConnectTest
//
//  Created by 黃昌齊 on 2021/8/6.
//

import UIKit

class ListDetailTableViewController: UITableViewController {
    
    var listDetail: ListDetail!
    var id = 0
    var accessToken = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Acess Token", accessToken)
        let urlStr = "https://apistage2.aisleconnect.us/ac.server/rest/v2.5/checklist/\(id)?access_token=\(accessToken)"
        ConnectController.shared.fetchListDetailData(urlStr: urlStr) { (result) in
            switch result {
            
            case .success(let listDetail):
                self.updateUI(with: listDetail)
            case .failure(let error):
                self.displayError(error, title: "Fail to fetch the data.")
            }
        }
    }
    
    func updateUI(with listDetail: ListDetail) {
        DispatchQueue.main.async {
            self.listDetail = listDetail
            self.navigationItem.title = listDetail.data.name
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

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listDetail?.data.products?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListDetailTableViewCell", for: indexPath) as! ListDetailTableViewCell
        let listDetail = listDetail.data.products?[indexPath.row]
        
        if let imageUrl = listDetail?.imageUrl {
            ConnectController.shared.fetchImage(url: imageUrl) { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    cell.bookImageView.image = image
                }
            }
        }
        cell.bookNameLabel.text = listDetail?.name
        cell.authorLabel.text = listDetail?.authors?.first 
        return cell
    }
    /*
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let row = tableView.indexPathForSelectedRow?.row,
           let controller = segue.destination as? ProductTableViewController
        {
            controller.id = (listDetail.data.products?[row].id)!
            controller.accessToken = accessToken
            controller.imageUrl = listDetail.data.products?[row].imageUrl
        }
    }
    

}
