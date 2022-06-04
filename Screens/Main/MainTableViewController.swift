//
//  MainTableViewController.swift
//  F1Pilots
//
//  Created by Mustafa Berkan Vay on 19.04.2022.
//

import UIKit

class MainTableViewController: UITableViewController {
    private var pilots: [PilotsResponse.Pilot] = []
    
    private var lastSelectedPilot: PilotsResponse.Pilot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPilots()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailViewController else {
            return
        }
        
        guard let lastSelectedPilot = lastSelectedPilot else {
            return
        }
        
        detailViewController.loadViewIfNeeded()
        
        detailViewController.configure(withPilot: lastSelectedPilot)
    }
    
    private func fetchPilots() {
        KukaRESTClient.getAllPilots { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(pilotsResponse):
                DispatchQueue.main.async {
                    self.pilots = pilotsResponse
                        .items
                        .sorted { $0.point > $1.point }
                    
                    self.tableView.reloadData()
                }
                
            case let .failure(error):
                // TODO: Handle the error
                
                print(error)
            }
        }
    }
}

extension MainTableViewController {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Drivers"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pilots.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        let pilot = pilots[indexPath.row]
        
        let isFavorited = FavoriteStorage.contains(id: pilot.id)
        
        cell.configure(withPilot: pilot, isFavorited: isFavorited)
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        lastSelectedPilot = pilots[indexPath.row]
        
        return indexPath
    }
}

extension MainTableViewController: MainTableViewCellDelegate {
    func favoriteButtonTapped(forPilot pilot: PilotsResponse.Pilot) {
        if FavoriteStorage.contains(id: pilot.id) {
            FavoriteStorage.remove(id: pilot.id)
        } else {
            FavoriteStorage.add(id: pilot.id)
        }
        
        tableView.reloadData()
    }
}
