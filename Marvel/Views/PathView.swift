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
    var color: UIColor = Constants.deadPool {
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
