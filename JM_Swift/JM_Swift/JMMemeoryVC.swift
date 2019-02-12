//
//  JMMemeoryVC.swift
//  JM_Swift
//
//  Created by YunJiSoft on 2019/2/12.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit

class JMMemeoryVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        testMemeory()
        // Do any additional setup after loading the view.
    }
    

    func testMemeory()  {
        var window: Window? = Window()
        var view: View? = View(window: window!)
        window?.rootView = view!
        view = nil
        window = nil
        
        
        
    }
 

}
class View {
    unowned var window: Window
    init(window: Window) {
        self.window = window
    }
    deinit {
        print("Deinit View")
    }
}
class Window {
    var rootView: View?
    deinit {
        print("Deinit Window")
    }
}

