//
//  ViewController.swift
//  JM_Swift
//
//  Created by YunJiSoft on 2018/12/21.
//  Copyright © 2018 Jimmy. All rights reserved.
//

import UIKit
import RxSwift
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loadin                                                                                                     g the view, typically from a nib.
//        self.rx_dispose()
//        self.rx_own_observable()
        self.rx_operator()
    }
  
    func rx_dispose() {
        let schedule = SerialDispatchQueueScheduler(qos: .default)
        let subscription = Observable<Int>.interval(1, scheduler: schedule)
//            .observeOn(MainScheduler.instance)
            .subscribe { (event) in
                debugPrint("event: \(event), thread:\(Thread.current)")
                
        }
        
        Thread.sleep(forTimeInterval: 10.0)
        subscription.dispose()
        
        
    }
    func myFrom<E>(_ sequence:[E]) -> Observable<E> {
        return Observable.create({ (obser) -> Disposable in
            for ele in sequence {
                obser.onNext(ele)
            }
            obser.onCompleted()
            return Disposables.create(){
                print("Disposave")
            }
        })
    }
    func rx_own_observable()  {
        let stringCounter = myFrom(["first","second"])
        print("started")
        stringCounter
            .subscribe(onNext:{n in
                print(n)
            })
        
        print("-----")
        stringCounter
            .subscribe(onNext:{n in
                print(n)
            })
        print("ended")
        
        let counter = myInterval(0.1)
        print("started time")
        let sub1 = counter.subscribe(onNext:{n in
            print("first number:\(n),thread:\(Thread.current)")
        })
        let sub2 = counter.subscribe(onNext:{n in
            print("second number:\(n),thread:\(Thread.current)")
        })
        Thread.sleep(forTimeInterval: 0.5)
        sub1.dispose()
        sub2.dispose()
        print("ended time")
    }
    func myInterval(_ interval:TimeInterval) -> Observable<Int> {
        return Observable.create({ (observal) -> Disposable in
            print("subscribed")
            let timer = DispatchSource.makeTimerSource( queue: DispatchQueue.global())
            timer.schedule(deadline: DispatchTime.now()+interval,repeating:interval)
            let cancel = Disposables.create{
                print("disposed")
                timer.cancel()
            }
            var next = 0
            timer.setEventHandler(handler: {
                if cancel.isDisposed{
                    return
                }
                observal.on(.next(next))
                next += 1
            })
            timer.resume()
            return cancel
        })
    }
    
    func rx_operator()  {
        let subscription = myInterval(0.1)
            .myMap { e in
                return "This is simply \(e)"
            }
            .subscribe(onNext: { n in
                print(n)
            })
        
        Thread.sleep(forTimeInterval: 2)
        subscription.dispose()
    }
    
    func rx_kvo()  {
        //
    }

}

extension ObservableType {
    func myMap<R>(transform: @escaping (E) -> R) -> Observable<R> {
        return Observable.create { observer in
            let subscription = self.subscribe { e in
                switch e {
                case .next(let value):
                    let result = transform(value)
                    observer.on(.next(result))
                case .error(let error):
                    observer.on(.error(error))
                case .completed:
                    observer.on(.completed)
                }
            }
            
            return subscription
        }
    }
}
