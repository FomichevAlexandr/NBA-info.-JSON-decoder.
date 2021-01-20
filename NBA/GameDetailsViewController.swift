//
//  GameDetailsViewController.swift
//  NBA
//
//  Created by Александр Фомичев on 18.01.2021.
//

import UIKit

class GameDetailsViewController: UIViewController {
    var game : Game?
    @IBOutlet weak var homeTeamButton: UIButton!
    @IBOutlet weak var homeTeamCityLabel: UILabel!
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    
    @IBOutlet weak var visitorTeamCityLabel: UILabel!
    @IBOutlet weak var visitorTeamScoreLabel: UILabel!
    
    @IBOutlet weak var visitorTeamButton: UIButton!
    
    @IBAction func onHomeTeamButtonClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let teamDetailsViewController = storyboard.instantiateViewController(identifier: "TeamDetails")
            as! TeamDetailsViewController
        teamDetailsViewController.team = game?.homeTeam
        navigationController?.pushViewController(teamDetailsViewController, animated: true)
    }
    
    @IBAction func onVisitorTeamButtonClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let teamDetailsViewController = storyboard.instantiateViewController(identifier: "TeamDetails")
            as! TeamDetailsViewController
        teamDetailsViewController.team = game?.visitorTeam
        navigationController?.pushViewController(teamDetailsViewController, animated: true)
    }
    
    @IBOutlet weak var gameDateLabel: UILabel!
    
    @IBOutlet weak var gameSeasonLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Game"
        navigationController?.navigationBar.prefersLargeTitles = true
        homeTeamCityLabel.text = game?.homeTeam.city
        if let homeTeamScore = game?.homeTeamScore{
            homeTeamScoreLabel.text = String(homeTeamScore)
        }
        homeTeamButton.setTitle(game?.homeTeam.name, for: UIControl.State.normal)
        visitorTeamButton.setTitle(game?.visitorTeam.name, for: UIControl.State.normal)
        visitorTeamCityLabel.text = game?.visitorTeam.city
        if let visitorTeamScore = game?.visitorTeamScore{
            visitorTeamScoreLabel.text = String(visitorTeamScore)
        }
        gameDateLabel.text = game?.date
        if let gameSeason = game?.season{
            gameSeasonLabel.text = String(gameSeason)
        }
        
    }
    

}
