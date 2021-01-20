//
//  ApiClient.swift
//  NBA
//
//  Created by Александр Фомичев on 06.01.2021.
//

import Foundation

enum ApiError: Error {
    case noData
}
protocol ApiClient {
    func getPlayers(completion: @escaping (Result<[Player],Error>) -> Void)
    func getGames(completion: @escaping (Result<[Game],Error>)->Void)
}
 
class ApiClientImpl : ApiClient {
    func getPlayers(completion: @escaping (Result<[Player],Error>) -> Void){
        let session = URLSession.shared
        let url = URL(string: "https://www.balldontlie.io/api/v1/players")!
        let urlRequest = URLRequest(url: url)
        let dataTask = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            
//            sleep(2)
//            completion(.failure(ApiError.noData))
//            return
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            do{
                let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode(PlayersResponse.self, from: data)
                completion(.success(response.data))
            }
            catch(let error){
                print(error)
                completion(.failure(error))
            }
        })
        dataTask.resume()
    }
    
    func getGames(completion: @escaping (Result<[Game], Error>) -> Void) {
        let session = URLSession.shared
        let url = URL(string: "https://www.balldontlie.io/api/v1/games")!
        let urlRequest = URLRequest(url: url)
        let dataTask = session.dataTask(with: urlRequest, completionHandler: {data, response, error in
            guard let data = data else{
                completion(.failure(ApiError.noData))
                return
            }
            do{
                let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode(GameResponse.self, from: data)
                completion(.success(response.data))
            }
            catch (let error){
                print(error)
                completion(.failure(error))
            }
        })
        dataTask.resume()
    }
}
