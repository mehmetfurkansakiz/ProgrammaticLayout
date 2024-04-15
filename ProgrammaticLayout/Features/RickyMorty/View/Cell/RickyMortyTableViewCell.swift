//
//  RickyMortyTableViewCell.swift
//  ProgrammaticLayout
//
//  Created by furkan sakız on 6.04.2024.
//

import UIKit
import SnapKit
import AlamofireImage

class RickyMortyTableViewCell: UITableViewCell {
    
    private let customImage: UIImageView = UIImageView()
    private let customTitle: UILabel = UILabel()
    private let customDescpription: UILabel = UILabel()
    
    private let randomImage: String = "https://picsum.photos/200/300"
    
    enum Identifier: String {
        case custom = "Furkan"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(customImage)
        addSubview(customTitle)
        addSubview(customDescpription)
        customTitle.font = .boldSystemFont(ofSize: 18)
        customDescpription.font = .italicSystemFont(ofSize: 14)
        
        customImage.layer.shadowColor = UIColor.black.cgColor
        customImage.layer.shadowOpacity = 0.1
        customImage.layer.shadowOffset = CGSize(width: 0, height: 4)
        customImage.layer.shadowRadius = 4
        customImage.layer.masksToBounds = false
        
        customImage.layer.borderWidth = 1.0
        customImage.layer.borderColor = UIColor.gray.cgColor
        customImage.layer.cornerRadius = 15.0
        customImage.clipsToBounds = true
        
        customImage.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.width * 0.4)
            make.top.equalTo(contentView)
            make.right.left.equalToSuperview()
        }
        
        customTitle.snp.makeConstraints { make in
            make.top.equalTo(customImage.snp.bottom)
            make.right.left.equalTo(contentView)
            make.height.equalTo(contentView.frame.width * 0.1)
        }
        
        customDescpription.snp.makeConstraints { make in
            make.top.equalTo(customTitle.snp.bottom)
            make.right.left.equalTo(customTitle)
            make.bottom.equalToSuperview()
            make.height.equalTo(contentView.frame.width * 0.08)
        }
    }
    
    func saveModel(model: Result) {
        customTitle.text = model.name
        customDescpription.text = model.status
        
        customImage.af.setImage(withURL: (URL(string: model.image ?? randomImage) ?? URL(string: randomImage))!)
    }
}
