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
    var parks: [ParsedPark] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //populateData()

        let url = self.parksURL()
        let jsonString = performParkRequest(with: url)
        print("Received JSON string \(jsonString)")
        self.parks = parse(data: jsonString!)!
        print("\(parks[0].name)")
    }
    
    //MARK: Methods

//    func populateData() {
//        let locationDatabase = LocationDatabase()
//        for location in locationDatabase.locationDatabase {
//            locations.append(location)
//
//        }
//    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "latLonToMap":
            guard let mapViewController = segue.destination as? MapViewController else { return }
            guard let selectedIndex = selectedIndex else { return }
            let lat = locations[selectedIndex].latitude
            let lon = locations[selectedIndex].longitude
            mapViewController.latlon = (latitude: lat, longitude: lon)
        default:
            return
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

//MARK: - TableView Data Source Methods

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return locations.count
        return parks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        let location = parks[indexPath.row] as! ParsedPark
        cell.textLabel?.text = location.name
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

//MARK: - TableViewDelegate Methods

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        selectedIndex = indexPath.row
        return indexPath
    }
}

//through Parks 2016 Socrata API
extension HomeViewController {
    
    // MARK: Methods
    
    func parksURL() -> URL {
        let urlString = "https://data.detroitmi.gov/resource/pizv-bpt2.json?$select=name,the_geom"
        let url = URL(string: urlString)
        return url!
    }
    
    func performParkRequest(with url: URL) -> Data? /*String*/ {
        do {
            return try Data(contentsOf: url)
           // return try String(contentsOf: url)
        } catch {
            print("Download Error: \(error.localizedDescription)")
//            showNetworkError()
            return nil
            //return ""
        }
    }
    
    //loads JSON data into app model
    func parse(data: Data) -> [ParsedPark]? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode([ParsedPark].self, from: data)
            //print("Results: \(result.results)")
            print("Result: \(result[0].name), \(result[0].the_geom.lat), \(result[0].the_geom.lon)")
            return result
        } catch {
            print("JSON Error \(error)")
            return nil
        }
    }
    
    
}

