//
//  ViewController.swift
//  TedoooCombine
//
//  Created by morapelker on 07/02/2022.
//  Copyright (c) 2022 morapelker. All rights reserved.
//

import UIKit
import Combine
import TedoooCombine

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    private var bag = CombineBag()
    
    let textFieldSubject = CurrentValueSubject<String?, Never>(nil)
    let textViewSubject = CurrentValueSubject<String?, Never>(nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        textField.textPublisher ~> textFieldSubject => bag
        textView.textPublisher ~> textViewSubject => bag
        textField <~> textFieldSubject => bag
    }
    
    @IBAction func clear(_ sender: Any) {
        textFieldSubject.send(nil)
    }
    
    @IBAction func clicked(_ sender: Any) {
        print(String(describing: textFieldSubject.value))
        print(String(describing: textViewSubject.value))
    }
    
}

