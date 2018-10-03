//
//  KBProgressHUD.swift
//  KBProgressHUD
//
//  Created by Kamlesh Bokdia on 10/2/18.
//

import UIKit

public class KBProgressHUD: UIViewController {
    
    static var isActive = false
    var messageConstraints: [NSLayoutConstraint]?
    var nonMessageConstraints: [NSLayoutConstraint]?
    
    let activityView: UIView = {
        let activityView = UIView()
        activityView.backgroundColor = UIColor.white
        activityView.layer.cornerRadius = 10
        activityView.clipsToBounds = true
        activityView.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        activityView.layer.shadowOffset = CGSize(width: 2, height: 2)
        activityView.layer.shadowRadius = 4
        activityView.layer.shadowOpacity = 1
        activityView.layer.masksToBounds = false
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        indicator.color = UIColor.gray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        activityView.addSubview(activityIndicator)
        activityView.addSubview(messageLabel)
        view.addSubview(activityView)
        //        setupConstraints()
        
        activityIndicator.startAnimating()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateConstraints()
    }
    
    func updateConstraints() {
        
        if let constraints = messageConstraints {
            NSLayoutConstraint.deactivate(constraints)
        }
        
        if let constraints = nonMessageConstraints {
            NSLayoutConstraint.deactivate(constraints)
        }
        
        var constraints = [NSLayoutConstraint]()
        
        if let message = messageLabel.text, message.count > 0 {
            constraints = [
                activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                activityIndicator.topAnchor.constraint(equalTo: activityView.topAnchor, constant: 12),
                activityIndicator.centerXAnchor.constraint(equalTo: activityView.centerXAnchor),
                activityIndicator.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8),
                messageLabel.leadingAnchor.constraint(equalTo: activityView.leadingAnchor, constant: 12),
                messageLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor,constant: 8),
                messageLabel.trailingAnchor.constraint(equalTo: activityView.trailingAnchor, constant: -12),
                messageLabel.bottomAnchor.constraint(equalTo: activityView.bottomAnchor, constant: -12)
            ]
            messageConstraints = constraints
        }
        else {
            constraints = [
                activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                activityIndicator.topAnchor.constraint(equalTo: activityView.topAnchor, constant: 12),
                activityIndicator.leadingAnchor.constraint(equalTo: activityView.leadingAnchor, constant: 12),
                activityIndicator.bottomAnchor.constraint(equalTo: activityView.bottomAnchor, constant: -12),
                activityIndicator.trailingAnchor.constraint(equalTo: activityView.trailingAnchor, constant: -12)
            ]
            
            nonMessageConstraints = constraints
        }
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    static public func showMessage(_ message: String) {
        //        KBProgressHUD.shared.messageLabel.text = message
        show(message: message)
    }
    
    static public func show(message: String? = nil) {
        if KBProgressHUD.isActive {
            return
        }
        
        guard let window = UIApplication.shared.keyWindow else { return }
        window.makeKeyAndVisible()
        
        let hudVC = KBProgressHUD()
        hudVC.messageLabel.text = message
        hudVC.modalPresentationStyle = .overCurrentContext
        window.rootViewController?.present(hudVC, animated: false, completion: nil)
        
        KBProgressHUD.isActive = true
    }
    
    static public func dismiss() {
        guard let window = UIApplication.shared.keyWindow,
            let hudVC = window.rootViewController?.presentedViewController as? KBProgressHUD else { return }
        
        hudVC.activityIndicator.stopAnimating()
        hudVC.messageLabel.text = nil
        hudVC.dismiss(animated: false, completion: nil)
        KBProgressHUD.isActive = false
    }
    
}
