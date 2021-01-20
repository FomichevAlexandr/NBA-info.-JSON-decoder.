//
//  GamesViewController.swift
//  NBA
//
//  Created by Александр Фомичев on 11.01.2021.
//

import UIKit

class GameCell: UITableViewCell{
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var visitorTeamName: UILabel!
    @IBOutlet weak var homeTeamScore: UILabel!
    @IBOutlet weak var visitorTeamScore: UILabel!
    @IBOutlet weak var symbol2: UILabel!
}

class GamesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var reloadButtonView: UIButton!
    @IBOutlet weak var errorLabelView: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onReloadButtonClick(_ sender: Any) {
        reload()
    }
    
    private func showLoading(){
        activityIndicatorView.startAnimating()
        reloadButtonView.isHidden = true
        errorLabelView.isHidden = true
    }
    
    private func showData(){
        activityIndicatorView.stopAnimating()
        reloadButtonView.isHidden = true
        errorLabelView.isHidden = true
    }
    
    private func showError(){
        activityIndicatorView.stopAnimating()
        errorLabelView.isHidden = false
        reloadButtonView.isHidden = false
    }
    
    var games : [Game] = []
    let apiClient: ApiClient = ApiClientImpl()
    

    
    private func reload(){
        activityIndicatorView.hidesWhenStopped = true
        showLoading()
        apiClient.getGames(completion: {result in
            DispatchQueue.main.async {
                switch result{
                case .success(let games):
                    self.games = games
                    self.showData()
                case .failure:
                    self.games = []
                    self.showError()
                }
                self.tableView.reloadData()
            }
        }
        )
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        reload()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let gameDetailsViewController = storyboard.instantiateViewController(identifier: "GameDetails")
            as! GameDetailsViewController
        gameDetailsViewController.game = games[indexPath.row]
        navigationController?.pushViewController(gameDetailsViewController, animated: true)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell
        let game = games[indexPath.row]
        cell.homeTeamName.text = game.homeTeam.name
        cell.homeTeamScore.text = String (game.homeTeamScore)
        cell.visitorTeamName.text = game.visitorTeam.name
        cell.visitorTeamScore.text = String(game.visitorTeamScore)
        cell.symbol2.text = ":"
        return cell
    }
}
