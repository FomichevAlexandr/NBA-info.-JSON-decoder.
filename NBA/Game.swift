//
//  Game.swift
//  NBA
//
//  Created by Александр Фомичев on 11.01.2021.
//

import Foundation
struct GameResponse : Decodable{
    let data : [Game]
}
struct Game : Decodable{
    let date: String
    let homeTeamScore : Int
    let visitorTeamScore : Int
    let season : Int
    let homeTeam : Team
    let visitorTeam: Team
    
    enum CodingKeys: String, CodingKey{
        case date
        case homeTeamScore = "home_team_score"
        case visitorTeamScore = "visitor_team_score"
        case season
        case homeTeam = "home_team"
        case visitorTeam = "visitor_team"
    }
}

