//
//  HeaderTableView.swift
//  TZ1221
//
//  Created by Stanislav on 19.08.2023.
//

import UIKit

class HeaderTableView: UITableViewHeaderFooterView {
    static let identifier = "tableHeader"
    
    let headerSectionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        headerSectionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(headerSectionLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerSectionLabel.sizeToFit()
        
        headerSectionLabel.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }
    
    func setupHeaderText(header: String) {
        headerSectionLabel.text = header
    }
    
}
