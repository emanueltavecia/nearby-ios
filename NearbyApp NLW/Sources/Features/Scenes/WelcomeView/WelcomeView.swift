//
//  WelcomeView.swift
//  NearbyApp NLW
//
//  Created by Emanuel on 10/12/2024.
//

import Foundation
import UIKit

class WelcomeView: UIView {
    var didTapButton: (() -> Void)?
    private let logoImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Boas vindas ao Nearby!"
        label.font = Typography.titleXL
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Tenha cupons de vantagem para usar em seus estabelecimentos favoritos."
        label.font = Typography.textMD
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subTextForTipsLabel: UILabel = {
        let label = UILabel()
        label.text = "Veja como funciona:"
        label.font = Typography.textMD
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tipsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 24
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private static func createShadowLayer(color: CGColor, radius: CGFloat, offset: CGSize) -> CALayer {
        let layer = CALayer()
        layer.shadowColor = color
        layer.shadowOpacity = 1
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        return layer
    }

    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Começar", for: .normal)
        button.backgroundColor = Colors.greenBase
        button.titleLabel?.font = Typography.action
        button.setTitleColor(Colors.gray100, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor(red: 0.09, green: 0.329, blue: 0.18, alpha: 1).cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 12
        button.layer.shadowOffset = CGSize(width: 0, height: 2)

        // Adicionando sombras ajustadas
        button.layer.masksToBounds = false
        let shadowLayers = [
            createShadowLayer(color: UIColor(red: 0.09, green: 0.329, blue: 0.18, alpha: 0.1).cgColor, radius: 8, offset: CGSize(width: 0, height: 4)),
            createShadowLayer(color: UIColor(red: 0.09, green: 0.329, blue: 0.18, alpha: 0.08).cgColor, radius: 12, offset: CGSize(width: 0, height: 8)),
            createShadowLayer(color: UIColor(red: 0.09, green: 0.329, blue: 0.18, alpha: 0.05).cgColor, radius: 16, offset: CGSize(width: 0, height: 12))
        ]

        shadowLayers.forEach { layer in
            button.layer.insertSublayer(layer, at: 0)
        }

        return button
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupTips()
        addSubview(logoImageView)
        addSubview(welcomeLabel)
        addSubview(descriptionLabel)
        addSubview(subTextForTipsLabel)
        addSubview(tipsStackView)
        addSubview(startButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            logoImageView.widthAnchor.constraint(equalToConstant: 48),
            logoImageView.heightAnchor.constraint(equalToConstant: 48),
            
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 24),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            
            descriptionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            subTextForTipsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            subTextForTipsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            subTextForTipsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            tipsStackView.topAnchor.constraint(equalTo: subTextForTipsLabel.bottomAnchor, constant: 24),
            tipsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            tipsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -48),
            startButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            startButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            startButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    @objc
    private func didTap() {
        didTapButton?()
    }
    
    private func setupTips() {
        guard let icon1 = UIImage(named: "mapIcon") else { return }
        let tip1 = TipsView(icon: icon1, title: "Encontre estabelecimentos", description: "Veja locais perto de você que são parceiros Nearby")
        
        let tip2 = TipsView(icon: UIImage(named: "qrcode") ?? UIImage(), title: "Ative o cupom com QR Code", description: "Escaneie o código no estabelecimento para usar o benefício")
        
        let tip3 = TipsView(icon: UIImage(named: "ticket") ?? UIImage(), title: "Garanta vantagens perto de você", description: "Ative cupons onde estiver, em diferentes tipos de estabelecimento")
        
        tipsStackView.addArrangedSubview(tip1)
        tipsStackView.addArrangedSubview(tip2)
        tipsStackView.addArrangedSubview(tip3)
    }
}
