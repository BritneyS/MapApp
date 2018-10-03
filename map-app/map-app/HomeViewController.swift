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
    

    //MARK: Properties
    
    var locations: [Location] = []
    var selectedIndex: Int?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        populateData()
    }
    
    //MARK: Methods

    func populateData() {
        let locationDatabase = LocationDatabase()
        for location in locationDatabase.locationDatabase {
            locations.append(location)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "":
            guard let mapViewController = segue.destination as? MapViewController else { return }
            let lat = locations[selectedIndex!].latitude
            let lon = locations[selectedIndex!].longitude
            mapViewController.latlon = (latitude: lat, longitude: lon) as? (Double, Double)
        default:
            return
        }
    }

}

//MARK: - TableView Data Source Methods

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        let location = locations[indexPath.row] as! Park
        cell.textLabel?.text = location.name
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

