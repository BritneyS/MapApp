//
//  ViewController.swift
//  map-app
//
//  Created by Britney Smith on 10/2/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Properties
    
    var selectedIndex: Int?
    var parks: [ParsedPark] = []
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getParkData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: Methods
    
    func getParkData() {
        
        guard let url = self.parksURL() else { return }
        guard let jsonString = performParkRequest(with: url) else { return }
        self.parks = parse(data: jsonString) ?? []
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "latLonToMap":
            guard let mapViewController = segue.destination as? MapViewController else { return }
            guard let selectedIndex = selectedIndex else { return }
            let lat = parks[selectedIndex].the_geom.lat
            let lon = parks[selectedIndex].the_geom.lon
            mapViewController.latlon = (latitude: lat, longitude: lon)
        default:
            return
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - TableView Data Source Methods

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        let sortedParks = parks.sorted(by: { (p1,p2) -> Bool in return p1.name?.localizedStandardCompare(p2.name!) == .orderedAscending })
        let location = sortedParks[indexPath.row]
        cell.textLabel?.text = location.name
        cell.textLabel?.textColor = UIColor.whiteg
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - TableViewDelegate Methods

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        selectedIndex = indexPath.row
        return indexPath
    }
}

// MARK: - API Call
/// Referencing City of Detroit Parks API
extension HomeViewController {
    
    // MARK: - Methods
    
    func parksURL() -> URL? {
        let urlString = "https://data.detroitmi.gov/resource/pizv-bpt2.json?$select=name,the_geom"
        guard let url = URL(string: urlString) else { return nil }
        return url
    }
    
    func performParkRequest(with url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        } catch {
            print("Download Error: \(error.localizedDescription)")
            showNetworkError()
            return nil
        }
    }
    
    func showNetworkError() {
        let alert = UIAlertController(title: "Uh Oh!", message: "There was an error accessing the API. " + " Please try again", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    /// Loads JSON data into app model ParsedPark
    func parse(data: Data) -> [ParsedPark]? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode([ParsedPark].self, from: data)
            return result
        } catch {
            print("JSON Error \(error)")
            return nil
        }
    }
}

