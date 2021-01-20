//
//  Player.swift
//  NBA
//
//  Created by Александр Фомичев on 04.01.2021.
//

import Foundation
struct PlayersResponse : Decodable{
    let data : [Player]
}
struct Player : Decodable {
    let team : Team
    let firstName : String
    let lastName : String
    let heightFeet : Int?
    let heightInches : Int?
    let position : String
    var name: String {
        firstName + " " + lastName
    }
    var height : String {
        if let heightFeet = heightFeet, let heightInches = heightInches{
              return "\(heightFeet)'\(heightInches)''"
        }else
        {
            return "Unknown"
        }
    }
    
    enum CodingKeys : String, CodingKey{
        case firstName = "first_name"
        case lastName = "last_name"
        case heightFeet = "height_feet"
        case heightInches = "height_inches"
        case team
        case position
    }
}

