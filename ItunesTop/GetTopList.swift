//
//  GetTopList.swift
//  ItunesTop
//
//  Created by Sergey Gusev on 07.04.2018.
//  Copyright © 2018 Sergey Gusev. All rights reserved.
//
import Foundation
import UIKit
import Alamofire
import AlamofireImage

class GetTopList {
    typealias DictionaryJSON = [String: Any]
    var movies: [Films] = []
    func download(finished: @escaping (([Films]) -> Void)) {
        let searchUrl = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/25/explicit.json"
        guard let jsonURL = URL(string: searchUrl) else {
            print("error in listFilmId")
            return
        }
        Alamofire.request(jsonURL).responseJSON { response in
            switch response.result {
            case .success:
                guard let jsonStart = response.result.value as? DictionaryJSON,
                    let jsonMid = jsonStart["feed"] as? DictionaryJSON,
                    let jsonResult = jsonMid["results"] as? [DictionaryJSON] else { return }
                print(jsonResult)
                self.downloadFilm(json: jsonResult) { [weak self] movies in
                    finished(movies)
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    func downloadFilm(json: [DictionaryJSON], exit: @escaping (([Films]) -> Void)) {
        let group = DispatchGroup()
        for single in json {
            guard let filmName = single["name"] as? String,
                let releaseDate = single["releaseDate"] as? String  else { return }
            guard let poster =   single["artworkUrl100"] as? String else {
                print("poster fault")
                //TODO
                return
            }
            let voteAverage = single["id"] as? String ?? ""
            guard let url = URL(string: poster) else {
                print ("error url")
                return
            }
            group.enter()
            Alamofire.request(url, method: .get).responseImage { response in
                guard let posterImage = response.result.value else {
                    print ("error poster get")
                    return
                }
               self.movies.append(Films(nameFilm: filmName, poster: posterImage, voteAverage: voteAverage, releaseDate: releaseDate, overview: "nil", primaryGenreName: "nil"))
                print(filmName)
                group.leave()
                group.notify(queue: .main, execute: {
                    exit(self.movies)
                })
            }
        }
    }
}




