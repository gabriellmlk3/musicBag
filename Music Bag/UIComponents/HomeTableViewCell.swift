//
//  TableViewCell.swift
//  Music Bag
//
//  Created by Premier on 06/08/21.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {
    
    static let reuseID = "HomeCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "abc"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: HomeTableViewCell.reuseID)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
    }
    
    func setupCell(item: Items) {
        setupLayout()
        titleLabel.text = item.snippet.title
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
