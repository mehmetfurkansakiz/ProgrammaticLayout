//
//  RickyMortyDetailViewController.swift
//  ProgrammaticLayout
//
//  Created by furkan sakız on 8.04.2024.
//

import UIKit
import SnapKit
import AlamofireImage

class RickyMortyDetailViewController: UIViewController {
    private let imageCharacter: UIImageView = UIImageView()
    private let labelName: UILabel = UILabel()
    private let labelStatus: UILabel = UILabel()
    private let labelGender: UILabel = UILabel()
    private let labelLocation: UILabel = UILabel()
    private let labelEpisodes: UILabel = UILabel()
    private let labelCreated: UILabel = UILabel()
    
    private let randomImage: String = "https://picsum.photos/200/300"
    
    var character: Result? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.addSubview(labelName)
        view.addSubview(imageCharacter)
        drawDesign()
        makeLabelName()
        makeImageView()
        makeInfoLabels()
        saveDatas()
        
    }
    
    private func drawDesign() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            self.labelName.text = self.character?.name
            self.labelName.textColor = .black
            self.labelName.font = .boldSystemFont(ofSize: 24)
            
            self.imageCharacter.layer.shadowColor = UIColor.black.cgColor
            self.imageCharacter.layer.shadowOpacity = 0.1
            self.imageCharacter.layer.shadowOffset = CGSize(width: 0, height: 4)
            self.imageCharacter.layer.shadowRadius = 4
            self.imageCharacter.layer.masksToBounds = false
            
            self.imageCharacter.layer.borderWidth = 1.0
            self.imageCharacter.layer.borderColor = UIColor.gray.cgColor
            self.imageCharacter.layer.cornerRadius = 15.0
            self.imageCharacter.clipsToBounds = true
        }
    }
    
    private func saveDatas() {
        imageCharacter.af.setImage(withURL: (URL(string: character?.image ?? randomImage) ?? URL(string: randomImage))!)
        labelGender.text = character?.gender
        labelStatus.text = character?.status
        labelCreated.text = character?.created
        labelEpisodes.text = "\(character?.episode?.first ?? "null") - \(character?.episode?.last ?? "null")"
        labelLocation.text = character?.location?.name
    }
    
    private func makeLabelWithStaticTitle(title: String, value: String?) -> UILabel {
        let attributedString = NSMutableAttributedString(string: "\(title): ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        
        if let value = value {
            attributedString.append(NSAttributedString(string: value, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
        }
        
        let label = UILabel()
        label.textColor = .black
        label.attributedText = attributedString
        
        return label
    }
}

extension RickyMortyDetailViewController {
    private func makeImageView() {
        imageCharacter.snp.makeConstraints { make in
            make.top.equalTo(labelName.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.greaterThanOrEqualTo(imageCharacter.snp.width)
        }
    }
    
    private func makeLabelName() {
        labelName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.centerX.equalToSuperview()
        }
    }
    
    private func makeInfoLabels() {
        let dateFormatter = DateFormatter()
        var formattedDate = String()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: character?.created ?? "") {
            dateFormatter.dateFormat = "dd MMMM yyyy, HH:mm:ss"
            formattedDate = dateFormatter.string(from: date)
        }
        
        var formattedEpisode: [String] = []
        if let episodes = character?.episode {
            for episodeURL in episodes {
                if let episodeNumber = URL(string: episodeURL)?.lastPathComponent {
                    formattedEpisode.append(episodeNumber)
                }
            }
        }
        
        let titles = ["Status", "Gender", "Location", "Episodes", "Created"]
        let values = [character?.gender, character?.status, character?.location?.name, "\(formattedEpisode.first ?? "Null") - \(formattedEpisode.last ?? "Null")", formattedDate]
        
        var topAnchor = imageCharacter.snp.bottom
        
        for (index, title) in titles.enumerated() {
            let label = makeLabelWithStaticTitle(title: title, value: values[index])
            view.addSubview(label)
            
            label.snp.makeConstraints { make in
                make.top.equalTo(topAnchor).offset(8)
                make.left.equalToSuperview().offset(32)
                make.right.equalToSuperview().offset(-32)
            }
            
            topAnchor = label.snp.bottom
        }
        
    }
}
