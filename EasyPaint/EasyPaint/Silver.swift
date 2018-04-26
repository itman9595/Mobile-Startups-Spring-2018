//
//  Silver.swift
//  EasyPaint
//
//  Created by Bauyrzhan Muratbek on 4/26/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class Silver: ViewController {
    
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var brushSizeLabel: UILabel!
    @IBOutlet weak var colorPicker: UIButton!
    @IBOutlet weak var eraserBtn: UIButton!
    var eraserBox: UIView!
    
    var drawingColor: CGColor = UIColor.black.cgColor
    var brushSize: CGFloat = 10.0
    var lastPoint = CGPoint.zero
    var swiped = false
    var eraserIsActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.brushSizeLabel.text = "\(Int(self.brushSize))"
        colorPicker.layer.cornerRadius = 5
        eraserBox = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        eraserBox.backgroundColor = UIColor.black
        eraserBox.isHidden = true
        self.view.addSubview(eraserBox)
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        self.tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        context?.move(to: fromPoint)
        context?.addLine(to: toPoint)
        
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(self.brushSize)
        
        if (!eraserIsActive) {
            context?.setStrokeColor(drawingColor)
        } else {
            context?.setStrokeColor(UIColor.white.cgColor)
        }
        
        context?.setBlendMode(CGBlendMode.normal)
        
        context?.strokePath()
        
        self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        self.tempImageView.alpha = 1.0
        
        UIGraphicsEndImageContext()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.swiped = false
        
        if let touch = touches.first {
            self.lastPoint = touch.location(in: self.view)
        }
        
        if (eraserIsActive) {
            eraserBox.frame.size = CGSize(width: self.brushSize, height: self.brushSize)
            eraserBox.isHidden = false
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.swiped = true
        
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.view)
            
            eraserBox.frame.origin = CGPoint(x: currentPoint.x - eraserBox.frame.size.width/2, y: currentPoint.y - eraserBox.frame.size.height/2)
            
            self.drawLineFrom(fromPoint: self.lastPoint, toPoint: currentPoint)
            
            self.lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (eraserIsActive) {
            eraserBox.isHidden = true
        }
        
        if !swiped {
            self.drawLineFrom(fromPoint: self.lastPoint, toPoint: self.lastPoint)
        }
        
        UIGraphicsBeginImageContext(self.mainImageView.frame.size)
        self.mainImageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height) , blendMode: .normal, alpha: 1.0)
        self.tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height) , blendMode: .normal, alpha: 1.0)
        
        self.mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.tempImageView.image = nil
    }
    
    @IBAction func minusButtonPressed(_ sender: UIButton) {
        self.brushSize -= 1
        self.brushSizeLabel.text = "\(Int(self.brushSize))"
    }
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
        self.brushSize += 1
        self.brushSizeLabel.text = "\(Int(self.brushSize))"
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        self.mainImageView.image = nil
    }
    
    @IBAction func chooseColor(_ sender: UIButton) {
        let popoverVC = storyboard?.instantiateViewController(withIdentifier: "colorPickerPopover") as! ColorPickerViewController
        popoverVC.modalPresentationStyle = .popover
        popoverVC.preferredContentSize = CGSize(width: 268, height: 430)
        if let popoverController = popoverVC.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = CGRect(x: 0, y: 0, width: 85, height: 30)
            popoverController.permittedArrowDirections = .any
            popoverController.delegate = self
            popoverVC.delegate = self
        }
        present(popoverVC, animated: true, completion: nil)
    }
    
    override func setButtonColor (_ color: UIColor) {
        colorPicker.backgroundColor = color
        drawingColor = color.cgColor
    }
    
    @IBAction func eraseButtonPressed(_ sender: UIButton) {
        if (eraserBtn.titleColor(for: .normal) == UIColor.red) {
            eraserIsActive = false
            eraserBtn.setTitleColor(UIColor.blue, for: .normal)
        } else {
            eraserIsActive = true
            eraserBtn.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
