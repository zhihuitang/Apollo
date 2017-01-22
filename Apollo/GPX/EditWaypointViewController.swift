//
//  EditWaypointViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-01-21.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit

class EditWaypointViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField! {
        didSet { nameTextField.delegate = self }
    }
    @IBOutlet weak var infoTextField: UITextField! {
        didSet { infoTextField.delegate = self }
    }
    
    var waypointToEdit: EditableWaypoint? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        nameTextField.becomeFirstResponder()
    }
    @IBAction func done(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        listenToTextFields()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopListeningToTextFields()
    }
    
    private func stopListeningToTextFields() {
        if let observer = ntfObserver {
            NotificationCenter.default.removeObserver(observer)
        }
        if let observer = itfObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    
    private var ntfObserver: NSObjectProtocol?
    private var itfObserver: NSObjectProtocol?
    
    private func listenToTextFields() {
        let center = NotificationCenter.default
        let queue = OperationQueue.main
        
        ntfObserver = center.addObserver(
            forName: NSNotification.Name.UITextFieldTextDidChange,
            object: nameTextField,
            queue: queue )
        { notification in
            if let waypoint = self.waypointToEdit {
                waypoint.name = self.nameTextField.text
            }
                
        }
        
        itfObserver = center.addObserver(
            forName: NSNotification.Name.UITextFieldTextDidChange,
            object: infoTextField,
            queue: queue )
        { notification in
            if let waypoint = self.waypointToEdit {
                waypoint.info = self.infoTextField.text
            }
            
        }
        
        
    }
    private func updateUI() {
        nameTextField?.text = waypointToEdit?.name
        infoTextField?.text = waypointToEdit?.info
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        preferredContentSize = view.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }
}
