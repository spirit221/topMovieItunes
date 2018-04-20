//
//  ViewController.swift
//  ItunesTop
//
//  Created by Sergey Gusev on 07.04.2018.
//  Copyright © 2018 Sergey Gusev. All rights reserved.
//

import Foundation
import UIKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    var movies: [Films] = []
    let getTopList = GetTopList()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Top 25 movies"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
        self.navigationController?.delegate = self
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "TableViewCell")
        getMoviesTop()
    }
    @objc func refresh(sender:AnyObject) {
        getMoviesTop()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
        cell?.commonInit(title: movies[indexPath.item].nameFilm, poster: movies[indexPath.item].poster)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
        let getTopListDetailed = GetTopListDetailed()
        getTopListDetailed.download(id: movies[indexPath.item].voteAverage) { [weak self] description in
            guard let film = self?.movies[indexPath.item] else { return }
            self?.activityIndicator.removeFromSuperview()
            let stackView = InsetLabel().generateTop25(film: film, description: description)
            let cardPopup = SBCardPopupViewController(contentView: stackView)
            cardPopup.show(onViewController: self!)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func getMoviesTop() {
        if Connectivity.isConnectedToInternet {
            movies.removeAll()
            getTopList.download() { [weak self] movies in
                self?.activityIndicator.removeFromSuperview()
                self?.movies = movies
                self?.tableView.separatorStyle = .singleLine
                self?.tableView.reloadData()
            }
        } else {
            let controller = UIAlertController(title: "No Internet Connection",
                                               message: "This app requires an Internet connection",
                                               preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(ok)
            present(controller, animated: true, completion: nil)
        }
    }
}

