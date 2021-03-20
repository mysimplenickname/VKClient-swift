//
//  FriendsSelectorControl.swift
//  VKClient
//
//  Created by Lev on 3/14/21.
//

import UIKit

class FriendsSelectorControl: UIControl {

    private var friends: [User] = User.loadUsers()
    
    private var stackView: UIStackView!
    
    var selectedValue: User?
    
    func setup() {
        
        var letters: [Character] = []
        
        for friend in friends {
            let string = friend.surname
            let letter = string[string.index(string.startIndex, offsetBy: 0)]
            if letters.firstIndex(of: letter) == nil {
                letters.append(letter)
            }
        }
        
        letters.sort()
        
        var buttons: [UIButton] = []
        
        for letter in letters {
            let button = UIButton(type: .system)
            button.setTitle(String(letter), for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            buttons.append(button)
        }
        
        stackView = UIStackView(arrangedSubviews: buttons)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }

    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Actions
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let letter = sender.title(for: .normal)
        for friend in friends {
            let surname = friend.surname
            let friendFirstLetter = surname[surname.index(surname.startIndex, offsetBy: 0)]
            if String(friendFirstLetter) == letter {
                selectedValue = friend
                sendActions(for: .touchUpInside)
                break
            }
        }
            
    }
    
}
