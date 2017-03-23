//
//  ViewController.swift
//  A_ChainAnimationSwiftDemo
//
//  Created by Animax Deng on 3/7/17.
//  Copyright © 2017 Animx. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Implement UITableViewDelegate and UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if let box = cell?.viewWithTag(1), let titleLabel = cell?.viewWithTag(10) as? UILabel {
            
            titleLabel.text = ""
            box.isHidden = false
            
            switch indexPath.row {
            case 0:
                titleLabel.text = "UIView block animation chain example"
                box.addAnimate(withDuration: 1.0, aniamtion: { 
                    box.alpha = 0.0
                }).addAnimate(withDuration: 1.0, aniamtion: { 
                    box.alpha = 1.0
                }).play()
                
                break
            case 1:
                titleLabel.text = "Effection animation chain example"
                box.addAnimate(with: .pulse, type: .easeInBack, duration: 1.0)
                    .addAnimate(with: .squeeze, type: .bigSpring, duration: 1.0)
                    .play()
                break
            case 2:
                titleLabel.text = "UIView block animation and Effection animation chain mix example"
                
                box.addAnimate(withDuration: 1.0, aniamtion: { box.alpha = 0.3 })
                    .addAnimate(with: .pulse, type: .easeInBack, duration: 1.0)
                    .addAnimate(withDuration: 1.0, aniamtion: {
                        box.alpha = 1.0
                    })
                    .addAnimate(with: .squeeze, type: .easeOutElastic, duration: 1.0)
                    .play()
                
                break
            case 3:
                titleLabel.text = "Sync effection animation chain combin example"
                
                box.syncAnimate()
                    .addAnimate(with: .wobble, type: .easeInBack, duration: 1.0)
                    .addAnimate(with: .mirror_zoomOut, type: .easeInExpo, duration: 1.5)
                    .play()
                
                break
            case 4:
                titleLabel.text = "CALayer animation chain example"
                
                box.syncAnimate()
                    .setPositionX(20, animtionType: .spring, duraion: 2.0)
                    .setSize(CGSize(width: 5, height: 5), animtionType: .bigLongSpring , duraion: 3.0)
                    .then
                    .setCornerRadius(10, animtionType: .noEffect)
                    .play()
                
                break
            case 5:
                titleLabel.text = "Custom oblique animation chain example"
                
                box.animateWait(0.5).setLeftOblique(1.0, animtionType: .easeInBack, duraion: 1.0)
                    .setTopOblique(1.0, animtionType: .easeInQuad, duraion: 1.0)
                    .setRightOblique(1.0, animtionType: .easeInCirc, duraion: 1.0)
                    .setBottomOblique(1.0, animtionType: .easeInOutSine, duraion: 1.0)
                    .setRecoverOblique(.easeInOutBounce, duraion: 1.0)
                    .play()
                
                break
            case 6:
                titleLabel.text = "Wait, block, and animation chain example"
                
                box.animateWait(2.0)
                    .setScale(1.5, animtionType: .bigSpring, duraion: 1.0)
                    .wait(1.0)
                    .block({
                        box.backgroundColor = UIColor.blue
                    })
                    .wait(3.0)
                    .setBackgroundColor(UIColor.red, animtionType: .bigLongSpring, duraion: 2.0)
                    .play()
                
                break
            default:
                break
            }
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
}

