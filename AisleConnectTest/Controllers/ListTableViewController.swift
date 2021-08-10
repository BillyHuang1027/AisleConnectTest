//
//  ListTableViewController.swift
//  AisleConnectTest
//
//  Created by 黃昌齊 on 2021/8/4.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var bookList: List?
    var accessToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlStr = "https://apistage2.aisleconnect.us/ac.server/rest/v2.5/checklist?access_token=\(accessToken)"
        
        ConnectController.shared.fetchBookListData(urlStr: urlStr) { (result) in
            switch result {

            case .success(let bookListData):
                self.updateUI(with: bookListData)
            case .failure(let error):
                self.displayError(error, title: "Fail to fetch data.")
            }
        }
    }
    
    func updateUI(with bookList: List) {
        DispatchQueue.main.async {
            self.bookList = bookList
            self.tableView.reloadData()
        }
    }
    
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 0
        if let count = bookList?.data.count {
            num = count
        }
        
        return num
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        if let listName = bookList?.data[indexPath.row],
           let bookCount = listName.products?.count {
            cell.bookCountLabel.text = "\(bookCount) books"
            cell.listNameLabel.text = listName.name
        } else if let listName = bookList?.data[indexPath.row] {
            cell.bookCountLabel.text = "0 books"
            cell.listNameLabel.text = listName.name
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let row = tableView.indexPathForSelectedRow?.row,
           let controller = segue.destination as? ListDetailTableViewController,
           let id = bookList?.data[row].id {
            controller.id = id
            controller.accessToken = accessToken
        }
    }
    

}
