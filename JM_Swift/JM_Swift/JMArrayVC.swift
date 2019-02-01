//
//  JMArrayVC.swift
//  JM_Swift
//
//  Created by Jimmy Ng on 2019/2/1.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit

class JMArrayVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        jm_method_reduce()
        jm_method_flatmap()
        // Do any additional setup after loading the view.
    }
    

    //MARK:- Reduce
    func jm_method_reduce()  {
        //
        let numbers = [1,2,3,4,5]
        let sum = numbers.reduce(0){total, num in total + num}
        let sum2 = numbers.reduce(1, {x,y in
            return x * y
        })
        print(sum,sum2)//15 120
        
        let persons = numbers.map { (num) -> Person in
            return Person.init(age: num, name: "person\(num)")
        }
        
        let totalAge = persons.reduce("name1") { (age, per) -> String in
            return per.name! + age
        }
        print(totalAge)// person5person4person3person2person1name1
        
        numbers.forEach {number in
            print(number)
        }
    }

    func jm_method_flatmap()  {
        let suits = ["J","Q","K","A"]
        let result = suits.flatMap{ string in
            suits.map{rank in
                (string,rank)
            }
        }
        print(result)
    }
}
struct Person {
    var age:Int?
    var name:String?
    
}
