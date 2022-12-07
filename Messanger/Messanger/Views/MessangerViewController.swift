//
//  MessangerViewController.swift
//  Messanger
//
//  Created by Consultant on 12/1/22.
//

import Foundation
import UIKit
import Firebase

class MessangerViewController: UIViewController {
    
    lazy var frmView = {
        let vw = UIView(frame: .zero)
        
        
        return vw
    }()
    
    lazy var scrollView: UITableView = {
        let scroll = UITableView(frame: .zero)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white

        scroll.dataSource = self
        scroll.register(MessangerTableViewCell.self, forCellReuseIdentifier: "MessangerCell")
        
        return scroll
    }()
    
    lazy var sendMessage: UITextView = {
        let text = UITextView(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .white
        text.font = UIFont.systemFont(ofSize: 18)
        text.layer.cornerRadius = 20
        text.text = "Text message"
        text.isScrollEnabled = true
        text.clearsOnInsertion = true
        
        return text
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(buttPressed), for: .touchUpInside)
        button.setTitle("Send", for: .normal)
        
        return button
        
    }()
    
    var messages: [message] = []
//    var frameView = UIView?.self
    let ref = Database.database().reference().child("messages")

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        ref.observe(.childAdded) { snap, arg  in
            guard let temp = snap.value as? [String: AnyObject] else {return}
            guard let usrnm = temp["username"] as? String else {return}
            guard let msg = temp["body"] as? String else {return}
            guard let timestmp = temp["timestamp"] as? String else {return}
            guard let uid = temp["UID"] as? String else {return}
            self.messages.append(message(UID: uid, body: msg, timestamp: timestmp, username: usrnm))

            print("messages length: \(self.messages.count)")
            self.scrollView.reloadData()
            self.scrollView.scrollToRow(at: IndexPath(row: self.messages.count-1, section: 0), at: .bottom, animated: true)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemMint
        self.title = "Messages"
        
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillShow(notification:)),
//                                               name: UIResponder.keyboardWillShowNotification,
//                                               object: nil)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillHide( notification:)),
//                                               name: UIResponder.keyboardWillHideNotification,
//                                               object: nil)
        
        createUI()

    }
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification) {
//        let userInfo = notification.userInfo ?? [:]
//        let keyboardFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
//        let adjustmentHeight = (CGRectGetHeight(keyboardFrame) + 20) * (show ? 1 : -1)
//        scrollView.contentInset.bottom += adjustmentHeight
//        scrollView.verticalScrollIndicatorInsets.bottom += adjustmentHeight
////        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
//    }
//    @objc
//    func keyboardWillShow(notification: NSNotification) {
//        adjustInsetForKeyboardShow(show: true, notification: notification)
//    }
//    @objc
//    func keyboardWillHide(notification: NSNotification) {
//        adjustInsetForKeyboardShow(show: false, notification: notification)
//    }
    
    
    func createUI() {
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.sendMessage)
        self.view.addSubview(self.sendButton)
        
        self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.sendMessage.topAnchor, constant: -8).isActive = true
        self.scrollView.layer.cornerRadius = 20
        
        self.sendMessage.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        self.sendMessage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.sendMessage.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.sendButton.leadingAnchor.constraint(equalTo: self.sendMessage.trailingAnchor, constant: 8).isActive = true
        self.sendButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        self.sendButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.sendButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.sendButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

}
extension MessangerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessangerCell", for: indexPath) as? MessangerTableViewCell else { return UITableViewCell() }
        print("messages: \(messages[indexPath.row])")
        var msgBody: String = messages[indexPath.row].body
        msgBody.replace(("\""), with: "")
        msgBody.replace(";", with: "")
        msgBody.replace("\\U2019", with: "'")
        cell.isUserInteractionEnabled = false
        
        print("message body: \(msgBody)")
        print("sender: \(messages[indexPath.row].username)")

        if self.messages[indexPath.row].username.lowercased().trimmingCharacters(in: .whitespaces) == "tony" {
            cell.messageLabel.backgroundColor = .systemPink
            cell.sender.textAlignment = .right
        } else{
            cell.messageLabel.backgroundColor = .blue
            cell.sender.textAlignment = .left
        }
            cell.messageLabel.text = msgBody
            cell.sender.text = self.messages[indexPath.row].username
            
        return cell

    }
    
    @objc
    func buttPressed() {
        print("button press")
        self.scrollView.reloadData()
        let ref = Database.database().reference()
        
        guard let body = self.sendMessage.text else {return}
        let uid = "tehee"
        let timestmp = "\(Date())"
        let usrnm = "Tony"
        if body != "" , body != "Text message" {
            ref.child("messages").child(timestmp).setValue(["UID" : uid, "body": body, "timestamp": timestmp, "username" : usrnm])
            
        }
        self.sendMessage.text = "Text message"
        self.sendMessage.clearsOnInsertion = true
        if messages.count > 3 {
            self.scrollView.scrollToRow(at: IndexPath(row: messages.count-1, section: 0), at: .bottom, animated: true)
        }
    }
    
    
    
}

