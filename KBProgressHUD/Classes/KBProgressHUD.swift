//
//  KBProgressHUD.swift
//  KBProgressHUD
//
//  Created by Kamlesh Bokdia on 10/2/18.
//

import UIKit

public class KBProgressHUD {
    
    static var presentedHUD: KBProgressHUDView? = nil
    
    static public func showMessage(_ message: String) {
        show(message: message)
    }
    
    static public func show(message: String? = nil) {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        var hudView: KBProgressHUDView!
        if let presentedView = KBProgressHUD.presentedHUD {
            hudView = presentedView
        }
        else {
            hudView = KBProgressHUDView()
            KBProgressHUD.presentedHUD = hudView
            window.addSubview(hudView)
        }
        
        hudView.frame = window.frame
        hudView.alpha = 1
        hudView.messageLabel.text = message
        hudView.setNeedsUpdateConstraints()
    }
    
    static public func dismiss() {
        guard let hudView = KBProgressHUD.presentedHUD else { return }
        hudView.alpha = 0
        hudView.messageLabel.text = nil
    }
    
}


class KBProgressHUDView: UIView {
    
    var viewContraints: [NSLayoutConstraint]?
    
    let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
    
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
        indicator.startAnimating()
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
    
    override func updateConstraints() {
        updateViewConstraints()
        super.updateConstraints()
    }
    
    func updateViewConstraints() {
        
        if let constraints = viewContraints {
            NSLayoutConstraint.deactivate(constraints)
        }
        
        var constraints = [
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            activityView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.topAnchor.constraint(equalTo: activityView.topAnchor, constant: 12),
            ]
        
        if let message = messageLabel.text, message.count > 0 {
            constraints.append(contentsOf: [
                activityIndicator.centerXAnchor.constraint(equalTo: activityView.centerXAnchor),
                activityIndicator.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8),
                messageLabel.leadingAnchor.constraint(equalTo: activityView.leadingAnchor, constant: 12),
                messageLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor,constant: 8),
                messageLabel.trailingAnchor.constraint(equalTo: activityView.trailingAnchor, constant: -12),
                messageLabel.bottomAnchor.constraint(equalTo: activityView.bottomAnchor, constant: -12)
                ])
        }
        else {
            constraints.append(contentsOf: [
                activityIndicator.leadingAnchor.constraint(equalTo: activityView.leadingAnchor, constant: 12),
                activityIndicator.bottomAnchor.constraint(equalTo: activityView.bottomAnchor, constant: -12),
                activityIndicator.trailingAnchor.constraint(equalTo: activityView.trailingAnchor, constant: -12)
                ])
        }
        
        viewContraints = constraints
        NSLayoutConstraint.activate(constraints)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        activityView.addSubview(activityIndicator)
        activityView.addSubview(messageLabel)
        addSubview(backgroundView)
        addSubview(activityView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
