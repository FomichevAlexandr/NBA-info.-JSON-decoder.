//
//  TeamDetailsViewController.swift
//  NBA
//
//  Created by Александр Фомичев on 05.01.2021.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    var team : Team?
    
    @IBOutlet weak var teamCity: UILabel!
    @IBOutlet weak var teamConferenceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = team?.name
        navigationController?.navigationBar.prefersLargeTitles = true
        teamCity.text = team?.city
        teamConferenceLabel.text = team?.conference
    }
    

}
