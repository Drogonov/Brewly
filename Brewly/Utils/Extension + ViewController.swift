//
//  Extension + ViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit

enum NotificationConfiguration {
    case textField
    case defaultAction
    case rejectAction
    
    init() {
        self = .defaultAction
    }
}

extension UIViewController {
    func configureAddModelAlert(
        title: String,
        message: String? = nil,
        textFieldNamePlaceholder: String? = nil,
        textFieldActionText: String? = nil,
        rejectActionText: String? = nil,
        completion: @escaping(NotificationConfiguration, String?) -> Void
    ) {
        var vagetableName: String?
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        // vagetableName textfield
        alert.addTextField { (textFieldName) in
            textFieldName.placeholder = textFieldNamePlaceholder
        }
        
        alert.addAction(UIAlertAction(title: textFieldActionText,
                                      style: .default,
                                      handler: { (_) in
            let textFieldName = alert.textFields![0] // Force unwrapping because we know it exists.
            alert.dismiss(animated: true) {
                print("Text field: \(String(describing: textFieldName.text))")
                vagetableName = textFieldName.text
                completion(.textField, vagetableName)
            }
        }))
        
        // reject action
        alert.addAction(UIAlertAction(title: rejectActionText,
                                      style: .destructive,
                                      handler: { (_) in
            alert.dismiss(animated: true)
            completion(.rejectAction, nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func animateWithKeyboard(
        notification: NSNotification,
        animations: ((_ keyboardFrame: CGRect) -> Void)?) {
            // Extract the duration of the keyboard animation
            let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
            let duration = notification.userInfo![durationKey] as! Double
            
            // Extract the final frame of the keyboard
            let frameKey = UIResponder.keyboardFrameEndUserInfoKey
            let keyboardFrameValue = notification.userInfo![frameKey] as! NSValue
            
            // Extract the curve of the iOS keyboard animation
            let curveKey = UIResponder.keyboardAnimationCurveUserInfoKey
            let curveValue = notification.userInfo![curveKey] as! Int
            let curve = UIView.AnimationCurve(rawValue: curveValue)!
            
            // Create a property animator to manage the animation
            let animator = UIViewPropertyAnimator(
                duration: duration,
                curve: curve
            ) {
                // Perform the necessary animation layout updates
                animations?(keyboardFrameValue.cgRectValue)
                
                // Required to trigger NSLayoutConstraint changes
                // to animate
                self.view?.layoutIfNeeded()
            }
            
            // Start the animation
            animator.startAnimation()
        }
}
