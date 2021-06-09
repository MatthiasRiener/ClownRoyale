//
//  LoadingViewController.swift
//  ClownRoyale
//
//  Created by Jan Donnerbauer on 09.06.21.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var jokeView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        jokeView.layer.masksToBounds = true
        jokeView.layer.cornerRadius = 15
        
        jokeView.layer.borderWidth = 10
        jokeView.layer.borderColor = UIColor(named: "ClownRedDunkel")?.cgColor
        
        SocketIOManager.sharedInstance.chooseCategoryRespone(completionHandler: {data in
            print("DATA 2:")
            print(data)
            self.performSegue(withIdentifier: "watcherPerspective", sender: self)
        })
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "watcherPerspective" {
            let watcherPerspectiveView = segue.destination as! WatcherPerspectiveViewController
            watcherPerspectiveView.modalPresentationStyle = .fullScreen
        }
    }
    

}
