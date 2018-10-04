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
    
 //   var locations: [Location] = []
    var selectedIndex: Int?
    var parks: [ParsedPark] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        let url = self.parksURL()
        guard let jsonString = performParkRequest(with: url) else { return }
        self.parks = parse(data: jsonString) ?? []
    }
    
    //MARK: Methods
    
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
        return parks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        let sortedParks = parks.sorted(by: { $0.name! < $1.name! })
        let location = sortedParks[indexPath.row]
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
    
    func performParkRequest(with url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        } catch {
            print("Download Error: \(error.localizedDescription)")
            showNetworkError()
            return nil
        }
    }
    
    //loads JSON data into app model
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
    
    func showNetworkError() {
        let alert = UIAlertController(title: "Uh Oh!", message: "There was an error accessing the iTunes Store. " + "Please try again", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}

