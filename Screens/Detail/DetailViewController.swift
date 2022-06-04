//
//  DetailViewController.swift
//  F1Pilots
//
//  Created by Mustafa Berkan Vay on 19.04.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var teamLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var pointLabel: UILabel!
}

extension DetailViewController {
    func configure(withPilot pilot: PilotsResponse.Pilot) {
        title = pilot.name
        pointLabel.text = pilot.pointFormatted
        
        fetchPilotDetail(ofId: pilot.id)
    }
    
    private func fetchPilotDetail(ofId id: Int) {
        KukaRESTClient.getPilotDetail(forId: id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(pilotDetail):
                self.fillFields(fromPilotDetail: pilotDetail)
                
            case let .failure(error):
                // TODO: Handle the error
                
                print(error)
            }
        }
    }
    
    private func fillFields(fromPilotDetail pilotDetail: PilotDetail) {
        DispatchQueue.main.async {
            self.teamLabel.text = pilotDetail.team
            self.ageLabel.text = "\(pilotDetail.age) years old"
            
            if let url = URL(string: pilotDetail.image) {
                self.imageView.kf.setImage(with: url)
            }
        }
    }
}
