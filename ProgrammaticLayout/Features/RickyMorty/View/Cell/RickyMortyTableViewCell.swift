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
        customDescpription.font = .italicSystemFont(ofSize: 10)
        
        customImage.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.right.left.equalToSuperview()
        }
        
        customTitle.snp.makeConstraints { make in
            make.top.equalTo(customImage.snp.bottom).offset(10)
            make.right.left.equalTo(customImage)
            make.width.height.equalTo(20)
        }
        
        customDescpription.snp.makeConstraints { make in
            make.top.equalTo(customTitle.snp.bottom).offset(5)
            make.right.left.equalTo(customTitle)
            make.bottom.equalToSuperview()
        }
    }
    
    func saveModel(model: Result) {
        customTitle.text = model.name
        customDescpription.text = model.status
        
        customImage.af.setImage(withURL: (URL(string: model.image ?? randomImage) ?? URL(string: randomImage))!)
    }
}
