//
//  ViewController.swift
//  RXExample
//
//  Created by Nathaniel Whittington on 3/19/22.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var numberLabel2: UILabel!
    var count : BehaviorRelay<String> = BehaviorRelay(value: "0")
    var count2 : BehaviorRelay<String> = BehaviorRelay(value: "0")
    
        var dispoableBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        count
            .asObservable()
            .bind(to: numberLabel.rx.text).disposed(by: dispoableBag)
        
        count2
            .asObservable()
            .bind(to: numberLabel2.rx.text).disposed(by: dispoableBag)
            increment()
            increment2()
    }
    
    
    func increment(){
        
        tapButton.rx
                .tap
                .subscribe { [weak self] event in
                    guard let strongSelf = self else {return}
                    guard var num = Int(strongSelf.count.value) else {return}
                    num += 1
                    self?.count.accept(String(num))
                    
                    
                }.disposed(by: dispoableBag)
 
    }
    
    func increment2(){
        
        tapButton.rx
            .tap
            .subscribe {[weak self] event in
                guard let strongSelf = self else {return}
                guard var num = Int(strongSelf.count2.value) else {return}
                num += 1
                self?.count2.accept(String(num))
            }.disposed(by: dispoableBag)
           
            
    }

    
  
}

