//
//  PathView.swift
//  Marvel
//
//  Created by Георгий Борисов on 20.10.2024.
//

import Foundation
import UIKit

final class PathView:UIView {
    private let path = UIBezierPath()
    var color: UIColor = UIColor(red: 0.6, green: 0.08, blue: 0.09, alpha: 1.00) {
        didSet{
            setNeedsDisplay()
        }
    }
    
    private func setupColor() {
        color.setFill()
        path.fill()
    }
    
    override func draw(_ rect: CGRect) {
        path.removeAllPoints()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.close()
        setupColor()
    }
    
    
}
