//
//  PlayerViewController.swift
//  NBA
//
//  Created by Александр Фомичев on 30.12.2020.
//

import UIKit

class PlayersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var players: [Player] = []
    let apiClient: ApiClient = ApiClientImpl()
    
 
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Players"
        navigationController?.navigationBar.prefersLargeTitles = true
        reload()
    }
    
    @IBAction func onReloadButtonClick(_ sender: Any) {
        reload()
    }
    
    private func reload(){
        activityIndicatorView.hidesWhenStopped = true
        showLoading()
        apiClient.getPlayers(completion: {result in
            DispatchQueue.main.async {
                switch result{
                case .success(let players):
                    self.players = players
                    self.showData()
                case .failure:
                    self.players = []
                    self.showError()
                }
                self.tableView.reloadData()
            }
        }
        )
    }
    
    private func showLoading(){
        activityIndicatorView.startAnimating()
        reloadButton.isHidden = true
        errorLabel.isHidden = true
    }
    
    private func showData(){
        activityIndicatorView.stopAnimating()
        reloadButton.isHidden = true
        errorLabel.isHidden = true
    }
    
    private func showError(){
        activityIndicatorView.stopAnimating()
        errorLabel.isHidden = false
        reloadButton.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)
        let player = players[indexPath.row]
        cell.textLabel?.text = player.name
        cell.detailTextLabel?.text = player.team.name
        return cell
    }  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let playerDetailsViewController = storyboard.instantiateViewController(identifier: "PlayerDetails")
            as! PlayerDetailsViewController
        playerDetailsViewController.player = players[indexPath.row]
        navigationController?.pushViewController(playerDetailsViewController, animated: true)
    }

}
