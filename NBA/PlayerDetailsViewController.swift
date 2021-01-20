//
//  PlayerDetailsViewController.swift
//  NBA
//
//  Created by Александр Фомичев on 04.01.2021.
//

import UIKit

class PlayerDetailsViewController: UIViewController {
    var player : Player?
        
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var teamButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = player?.name
        navigationController?.navigationBar.prefersLargeTitles = true
        positionLabel.text = player?.position
        heightLabel.text = player?.height
        teamButton.setTitle(player?.team.name, for: UIControl.State.normal)
    }
    
    @IBAction func onTeamButtonClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let teamDetailsViewController = storyboard.instantiateViewController(identifier: "TeamDetails")
            as! TeamDetailsViewController
        teamDetailsViewController.team = player?.team 
        navigationController?.pushViewController(teamDetailsViewController, animated: true)
    }


}
