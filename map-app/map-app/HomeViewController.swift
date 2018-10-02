//
//  ViewController.swift
//  map-app
//
//  Created by Britney Smith on 10/2/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - Properties
    
    var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

//MARK: - TableView Data Source Methods

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        return cell 
    }
    
    
}

//MARK: - TableViewDelegate Methods

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        selectedIndex = indexPath.row
        return indexPath
    }
}

