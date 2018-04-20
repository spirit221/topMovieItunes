//
//  ChangeSizePopupContentViewController.swift
//  SBCardPopupExample
//
//  Created by Steve Barnegren on 22/06/2017.
//  Copyright © 2017 Steve Barnegren. All rights reserved.
//

import UIKit

class ChangeSizePopupContentViewController: UIViewController, SBCardPopupContent {

    static func create() -> UIViewController {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChangeSizePopupContentViewController") as! ChangeSizePopupContentViewController
        return viewController
    }

    // MARK: - Properties

    @IBOutlet fileprivate var revealViews: [UIView]!
    @IBOutlet weak fileprivate var button: UIButton!
    @IBOutlet weak var qqqq: UILabel!
    weak var popupViewController: SBCardPopupViewController?
    var film: Films?
    let allowsTapToDismissPopupCard = true
    let allowsSwipeToDismissPopupCard = true

    private var isShowingRevealViews = false

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        revealViews.forEach {
            $0.isHidden = true
            $0.alpha = 0
        }
        qqqq.text = film?.nameFilm
    }

    // MARK: - Actions
    func commonInit(film: Films) {
        self.film = film
    }
    @IBAction private func buttonPressed(sender: UIButton) {

        if isShowingRevealViews {
            popupViewController?.close()
            return
        }

        self.isShowingRevealViews = true
        self.button.setTitle("Close", for: .normal)

        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: [.curveEaseInOut],
                       animations: {

                        self.revealViews.forEach {
                            $0.isHidden = false
                        }
        }) { _ in
            self.showRevealViews()
        }
    }

    private func showRevealViews() {

        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: [.curveEaseInOut],
                       animations: {

                        self.revealViews.forEach {
                            $0.alpha = 1
                        }
        },
                       completion: nil)
    }

}
