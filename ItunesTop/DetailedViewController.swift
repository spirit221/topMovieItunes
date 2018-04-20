//
//  DetailedViewController.swift
//  ItunesTop
//
//  Created by Sergey Gusev on 07.04.2018.
//  Copyright © 2018 Sergey Gusev. All rights reserved.
//
import UIKit

class DetailedViewController: UIViewController {
    var  movieName: String = ""
    var poster: UIImage?
    var movieId: String = ""
    @IBOutlet weak var nameLabel: UILabel!
   // @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var posterLabel: UIImageView!
    //@IBOutlet weak var releaseDateLabel: UILabel!
   // @IBOutlet weak var genre: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = movieName
        posterLabel.image = poster
//        getTop25Detailed.download(id: movieId) { [weak self] movies in
//            self?.idLabel.text = movies[0].overview
//            //self?.posterLabel.image = movies[0].poster
//            self?.releaseDateLabel.text = String(movies[0].releaseDate.prefix(10))
//            self?.genre.text = movies[0].primaryGenreName
//        }
    }
    
    func commonInit(title: String, poster: UIImage, id: String) {
        movieName = title
        self.poster = poster
        movieId = id
    }
    
    
}
