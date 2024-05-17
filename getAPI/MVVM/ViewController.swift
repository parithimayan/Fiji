//
//  ViewController.swift
//  getAPI
//
//  Created by ilamparithi mayan on 03/05/24.
//

import UIKit

class ViewController: UIViewController {

    var json:[WelcomeElement]?

    @IBOutlet weak var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblView.delegate = self
        tblView.dataSource = self
      getMethod()
    }

    func getMethod() {

        let url = URL(string: "https://api.github.com/users/hadley/orgs")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, error in
        print("response -->\(response!)")
        let decode = JSONDecoder()
            do {
                let result = try decode.decode([WelcomeElement].self, from: data!)
                DispatchQueue.main.async {
                    self.json = result
                    self.tblView.reloadData()
                }
            } catch {
                print("401 ----> \(error) ")
            }


        }.resume()
   }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
               cell.lbl1?.text = json?[indexPath.row].login
                cell.lbl2?.text = "\(json?[indexPath.row].id ?? 0 )"
                cell.lbl3?.text = json?[indexPath.row].nodeID
                cell.lbl4?.text = json?[indexPath.row].description
                return cell
            }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}






