//
//  SwapButton.swift
//  CustomModalPresentation
//
//  Created by Vanine Ghazaryan on 31.05.25.
//

import UIKit

final class SwapButton: UIButton {
    
    var action: (()->Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }

    private func setupStyle() {
        setTitle("Swap", for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        backgroundColor = UIColor.systemBlue.withAlphaComponent(0.9)
        layer.cornerRadius = 16
        layer.masksToBounds = false

        // Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 12

        // Touch feedback
        addTarget(self, action: #selector(touchDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(touchUp), for: [.touchDragExit, .touchCancel])
        addTarget(self, action: #selector(touchUpInside), for: [.touchUpInside])
    }

    @objc private func touchDown() {
        animate(scale: 0.96, alpha: 0.8)
    }

    @objc private func touchUp() {
        animate(scale: 1.0, alpha: 1.0)
    }
    
    @objc private func touchUpInside() {
        touchUp()
        action?()
    }

    private func animate(scale: CGFloat, alpha: CGFloat) {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.8,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.alpha = alpha
        }, completion: nil)
    }
}
