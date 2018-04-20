//
//  Films.swift
//  ItunesTop
//
//  Created by Sergey Gusev on 07.04.2018.
//  Copyright © 2018 Sergey Gusev. All rights reserved.
//

import Foundation
import UIKit
class Films {
    let nameFilm: String
    let poster:  UIImage
    let voteAverage: String
    let releaseDate: String
    let overview: String
    let primaryGenreName: String
    init(nameFilm: String, poster: UIImage, voteAverage: String, releaseDate: String, overview: String, primaryGenreName: String) {
        self.nameFilm = nameFilm
        self.poster = poster
        self.voteAverage = voteAverage
        self.releaseDate = releaseDate
        self.overview = overview
        self.primaryGenreName = primaryGenreName
    }
}
