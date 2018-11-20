//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Leon Fan on 2018/11/20.
//  Copyright © 2018 Leon Fan. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.splitViewController?.delegate = self
    }
    
    let imageDict: [String:URL] = ["Earth": URL(string: "https://ws1.sinaimg.cn/large/0065oQSqgy1fxd7vcz86nj30qo0ybqc1.jpg")!, "Cassini": URL(string: "https://ws1.sinaimg.cn/large/0065oQSqgy1fwyf0wr8hhj30ie0nhq6p.jpg")!, "Saturn": URL(string: "https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg")!]

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let url = imageDict[segue.identifier ?? ""] {
            if let imageVC = segue.destination.contents as? ImageViewController {
                imageVC.imageURL = url
                imageVC.title = (sender as? UIButton)?.currentTitle
            }
        }
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contents == self {
            if let ivc = secondaryViewController.contents as? ImageViewController, ivc.imageURL == nil {
                return true
            }
        }
        return false
    }

}

extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
