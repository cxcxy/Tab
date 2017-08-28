//
//  ViewController.swift
//  Tab
//
//  Created by 陈旭 on 2017/7/25.
//  Copyright © 2017年 陈旭. All rights reserved.
//


import UIKit
import RxDataSources
import RxSwift
import RxCocoa
//  MARK: - 视图控件扩展
private extension UILabel {
//    var rx_say: AnyObserver<String> {
    
//        return UIBindingObserver.init(UIElement: <#T##AnyObject#>, binding: <#T##(AnyObject, AnyObject) -> Void#>)
    
//        return UIBindingObserver.init(UIElement: self, binding: { (label, string) in
//            label.text = string
//        })
//    }
    var rx_sayHelloObserver: AnyObserver<String> { // 返回的是一个观察者属性
        return UIBindingObserver(UIElement: self, binding: { (label, string) in
            label.text = "Hello \(string)"
        }).asObserver()
    }
    
    var validationResult:UIBindingObserver<UILabel,String> {
        return UIBindingObserver.init(UIElement: self, binding: { (label, str) in
            label.text = str
        })
    }
}
class ViewController: UIViewController {
    let disposeBag = DisposeBag()
  
    @IBOutlet weak var bottomView: BrandBottomLookMoreView!
    @IBOutlet weak var btnTestOne: UIButton!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var tfName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

//        observable_from()
//        observable_of()
//        observable_create()
//        observable_element()
//        observable_generate()
//        observable_Variable()
//        observable_startWith()
//        observable_map() 
//        observable_scan()
//        observable_filter()
//        observable_elementAt()
        
        
//        btnTestOne.zhw_ignoreEvent = false
        self.btnTestOne.acceptEventInterval = 3.0
        self.btnTestOne.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { [unowned self] in
            print("11111")
        }).addDisposableTo(disposeBag)
        
//       _ = NotificationCenter.default.rx.notification(Notification.Name("kNotificationTestName")).takeUntil(self.rx.deallocated).subscribe(onNext: { (value) in print(value) })
        
       
        
//         NotificationCenter.default.rx.notification(Notification.Name(rawValue: "hahaha"), object: self).subscribe(onNext: { (sender) in
//            print(sender)
//         }).addDisposableTo(disposeBag)
//        
        
//            NotificationCenter.default.addObserver(self, selector:#selector(testNotifation), name:NSNotification.Name(rawValue: "hahaha"), object:nil)
        
//        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "hahaha"), object: self, queue: nil) { (sender) in
//             print("heiheiheihei")
//        }
//        
        
        _ = NotificationCenter.default.rx.notification(Notification.Name("kNotificationTestName")).takeUntil(self.rx.deallocated).subscribe(onNext: { (value) in
            print(value)
            print("2222")
        })
        
 
        
        observable_take()
        let viewModel = RegisterViewModel()
        
        tfName.rx.text.orEmpty.bind(to: viewModel.username).addDisposableTo(disposeBag)
        
        // tfName 为被观察者，lbName.rx_sayHelloObserver 返回的是一个观察者， 观察tfName的行为， 然后，作出自己的行为反应
//        tfName.rx.text.orEmpty.bind(to: lbName.rx_sayHelloObserver).addDisposableTo(disposeBag)
        
//        viewModel.usernameUsable.bind(to: lbName.validationResult).addDisposableTo(disposeBag)
        
        viewModel.usernameUsable.bind(to: lbName.rx.validationResult).addDisposableTo(disposeBag)
//        lbName.rx.validationResult
//        viewModel.usernameUsable.asObservable().bind(to: lbName.validationResult).addDisposableTo(disposeBag)
        
        colorChange()
//        rx_flatMap()
        

        
        textBreak()
        
//        let list = [1,2,3,4,5,6,7,8,9,10]
//        
//        let sum = list.reduce(0,{$0 + $1})
//        print(sum)
    }
    func testNotifation()  {
        print("heiheiheihei")
    }
    func textBreak()  {
        let a = 0
        switch a {
        case 0:
            guard a == 0 else {
                break
            }
            print("111")
        default:
            break
        }
         print("222")
    }
    func colorChange()  {

        let gradientLayer  = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor]
        gradientLayer.locations = [0.0,1.0]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 1)
        gradientLayer.frame = lbName.bounds
        self.lbName.layer.addSublayer(gradientLayer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.bottomView.view.frame = self.bottomView.bounds
    }
    @IBAction func clickAction(_ sender: Any) {
        let vc = UIStoryboard.initialViewController("Main", identifier:String(describing: DetailViewController.self)) as! DetailViewController

        self.navigationController?.pushViewController(vc, animated: true)
        
//        let vc = UIStoryboard.initialViewController("Main", identifier:String(describing: TextKitVC.self)) as! TextKitVC
//    
//        self.navigationController?.pushViewController(vc, animated: true)
        
        
//        print("点击了")
//        UIView.animate(withDuration: 3, animations: {
//            
//        }) { (finished) in
//            
//        }
    }
  
    @IBAction func clickMoreAction(_ sender: Any) {
        let vc = UIStoryboard.initialViewController("Main", identifier:String(describing: SecondViewController.self)) as! SecondViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension Result {
    var description: String {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case let .failed(message):
            return message
        }
    }
}
extension Result {
    var textColor: UIColor {
        switch self {
        case .ok:
            return UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
        case .empty:
            return UIColor.black
        case .failed:
            return UIColor.red
        }
    }
}

extension Reactive where Base: UILabel {

    var validationResult:UIBindingObserver<Base,Result> {
        return UIBindingObserver.init(UIElement: base, binding: { (label, result) in
            label.textColor = result.textColor
            label.text = result.description
        })
    }

//    var validationResult: UIBindingObserver<Base, Result> {
//        return UIBindingObserver(UIElement: base) { label, result in
//            label.textColor = result.textColor
//            
////            label.text = result.description
//        }
//    }
//    var a:UIBindingObserver<Base,Result> {
//        return UIBindingObserver.init(UIElement: base, binding: { (label, resule) in
//            label.textColor = resule.textColor
//        })
//        return UIBindingObserver(UIElement: base) { label, result in
//            label.textColor = result.textColor
//            
//            //            label.text = result.description
//        }
//    }
}
extension Reactive where Base: UITextField {
//    var inputEnabled: UIBindingObserver<Base, Result> {
//        return UIBindingObserver(UIElement: base) { textFiled, result in
//            textFiled.isEnabled = result.isValid
//        }
//    }
}

// 表示我们的一些请求的结果
enum Result {
    case ok(message: String)
    case empty
    case failed(message: String)
}
class ValidationService {
    static let instance = ValidationService()
    
    private init() {}
    
    let minCharactersCount = 6
    
    //这里面我们返回一个Observable对象，因为我们这个请求过程需要被监听。
    func validateUsername(_ username: String) -> Observable<Result> {
        
        if username.characters.count == 0 {//当字符等于0的时候什么都不做
            return Observable.just(.empty)
        }
        
        if username.characters.count < minCharactersCount {//当字符小于6的时候返回failed
            return .just(.failed(message: "号码长度至少6个字符"))
        }
        
//        if usernameValid(username) {//检测本地数据库中是否已经存在这个名字
//            return .just(.failed(message: "账户已存在"))
//        }
        
        return .just(.ok(message: "用户名可用"))
    }
    
//    // 从本地数据库中检测用户名是否已经存在
//    func usernameValid(_ username: String) -> Bool {
//        let filePath = NSHomeDirectory() + "/Documents/users.plist"
//        let userDic = NSDictionary(contentsOfFile: filePath)
//        let usernameArray = userDic!.allKeys as NSArray
//        if usernameArray.contains(username) {
//            return true
//        } else {
//            return false
//        }
//    }
}
class RegisterViewModel {
    let username = Variable<String>("") // 定义为 variable 变量， 初始值为“”
    // output:
    let usernameUsable: Observable<Result>
//    let
    init() {
        let servict = ValidationService.instance
        
        usernameUsable = username.asObservable().flatMapLatest{ (username) in
//            return servict.validateUsername(username).observeOn(MainScheduler.instance).catchErrorJustReturn(.failed(message:"username检测出错"))
              return  servict.validateUsername(username).asDriver(onErrorJustReturn: .failed(message:"username检测出错"))
        }
    }
}


extension ViewController {
    // of 是创建一个 sequence 能发出很多种事件的信号
    func observable_of()  {
        Observable.of(1,2,3,4).subscribe { a in
            print(a)
            }.addDisposableTo(disposeBag)
    }
    
    // from 就是从集合中创建 sequence 例如 数组， 字典 或者set 相当于 把 集合 当成一个信号
    func observable_from()  {
        Observable.from([1,2,3,4]).subscribe(onNext: { (a) in
            print(a)
        }).addDisposableTo(disposeBag)
        
    }
    // create 使我们可以自定义可观察的sequence ， 可以自定义 观察者 观察 被观察者 的方式， 例如 是否 监听 completed 这个操作
    func observable_create()  {
        let myJust = { (element: [Any]) -> Observable<[Any]> in
            
            return  Observable.create({ (observer) -> Disposable in
                observer.onNext(element)
                //                observer.onCompleted()
                return Disposables.create()
            })
            
        }
        myJust(["a"]).subscribe { (str) in
            print(str)
            }.addDisposableTo(disposeBag)
    }
    // repeatElement 创建一个 sequence 发出特定的事件3次 take() 指定事件的次数
    func observable_element(){
        Observable.repeatElement("str").take(3).subscribe { (str) in
            print(str)
            }.addDisposableTo(disposeBag)
    }
    // generate 是创建一个可观察的 sequence ，当初始化条件为 true 的时候， 他就会发出所对应的事件
    func observable_generate() {
        Observable.generate(initialState: 0, condition: { $0 < 3 }, iterate: { $0 + 1 }).subscribe { (a) in
            print(a)
            }.addDisposableTo(disposeBag)
    }
    // varialbe 是一个包装箱， 就像一个箱子一样，在使用的时候，会调用 asObservable（)拆箱， 里面的value 是 值 ，他不会发出error 事件， 但是会自动发出 completed 事件。 也看 variable 的作用域
    func observable_Variable()  {
        let variable = Variable("1")
        variable.asObservable().subscribe { (str) in
            print(str)
            }.addDisposableTo(disposeBag)
        
        variable.value = "3"
        variable.value = "4"
    }
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        variable.value = "5"
    //
    //    }
    // startWith 在发出事件之前，先发出某个特定的事件消息。 比如发出事件 2，3 然后，我startWith（“1”），那么就会先发出 1，然后2.3
    func observable_startWith()  {
        Observable.of("2","3").startWith("1").subscribe { (str) in
            print(str)
            }.addDisposableTo(disposeBag)
    }
    // map 通过传入一个函数闭包，  把原来的 sequence 转变为一个新的 sequece 的操作  下面的操作相当于 每个元素相乘
    func observable_map()  {
        Observable.of(1,2,3).map { (a) -> Int in
            return a * a
            }.subscribe { (b) in
                print(b)
            }.addDisposableTo(disposeBag)
    }
    //    scan 就是给一个初始化的数，然后不断的拿前一个结果和最新的值进行处理操作。
    func observable_scan()  {
        Observable.of(10,100,1000).scan(1) { (a, b) -> Int in
            return a + b
            }.subscribe { (c) in
                print(c)
            }.addDisposableTo(disposeBag)
    }
    //   filter  就是过滤掉某些不符合要求的事件
    func observable_filter(){
        
        Observable.of("a","b","c","d").filter { (str) -> Bool in
            return str == "a"
            }.subscribe { (str) in
                print( str)
            }.addDisposableTo(disposeBag)
    }
    func observable_elementAt()  {
        let  add = Variable("a","b","c","d")
        add.asObservable().subscribe {
            print($0)
            }.addDisposableTo(disposeBag)
    }
    
    func observable_take()  {
        Observable.of("a","b","c","d").take(1).subscribe { (str) in
                print( str)
            }.addDisposableTo(disposeBag)
    }
    
    func rx_flatMap()  {
        let disposeBag = DisposeBag()
        let sequenceInt = Observable.of(1,2,3)
        let sequenceString = Observable.of("A", "B", "C","D")
        
        sequenceInt.flatMapFirst{ (i) -> Observable<String> in
            print(i)
            return sequenceString
            }.subscribe { (str) in
                print(str)
            }.addDisposableTo(disposeBag)
        //        sequenceInt.flatMap {  _ in
        //            return sequenceString
        //            }
        //            .subscribe { print($0) }
        //            .addDisposableTo(disposeBag)
    }
    /*
     1-A,
     2-A
     1-B
     2-B
     1-C
     3-A
     1-D
     2-C
     3-B
     2-D
     3-C
     3-D
     
     */
    
}

