//
//  DetailViewController.swift
//  Tab
//
//  Created by 陈旭 on 2017/7/25.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa
import Alamofire
import ObjectMapper
import NSObject_Rx


class DetailViewController: UIViewController,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    let dataSource  = RxTableViewSectionedReloadDataSource<SectionModel<String,WOWHotStyleModel>>()

    var pageIndex = 1
    
    var dataArr = Variable<[WOWHotStyleModel]>([])
    
    let viewModel  = GroupViewModel()
    
    let speakerListViewModel = SpeakerListViewModel()
    
    struct Reusable {
        static let applyCell = ReusableCell<WOWApplyAfterCell>()
    }
    deinit {
        print("shifang")
    }
    
    
//    let article = ArticleModel(id: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle    = .none
        tableView.rowHeight            = UITableViewAutomaticDimension
        tableView.estimatedRowHeight   = 60
        
        tableView.register(UINib.init(nibName: "WOWApplyAfterCell", bundle: Bundle.main), forCellReuseIdentifier: "WOWApplyAfterCell")
        tableView.register(UINib.init(nibName: "TwoStyleCell", bundle: Bundle.main), forCellReuseIdentifier: "TwoStyleCell")
//        tableView.register(Reusable.applyCell)
        tableView.register(ReusableCell<TwoStyleCell>())
        
        tableView.mj_footer = mj_footer

//        loadData(pageIndex)
        configTableView()
        
//        GroupModelData.shareInstance.getGroupModelData { (vm) in
//            vm.asObservable().subscribe({[unowned self]  (model) in
//                if let a = model.element {
//                    self.dataArr.value.append(contentsOf: a)
//                           self.mj_footer.endRefreshing()
//                }
//                
//            }).addDisposableTo(self.disposeBag)
//        }
        let params:[String : Any] = [
            "currentPage": pageIndex,
            "pageSize": 10,
            ]
        
        ArticleModel.shareInstance.getArticleListData(params as [String : AnyObject]).subscribe(onNext: { (modelArray) in
            print(modelArray)
            self.dataArr.value.append(contentsOf: modelArray)
        }).addDisposableTo(rx_disposeBag)
        
        
        ArticleModel.shareInstance.refresh.asObservable().subscribe(onNext: { (status) in
            self.refreshStatus(status: status)
        }).addDisposableTo(rx_disposeBag)
        
//        Observable.combineLatest(refreshStatus())
        
 NotificationCenter.default.post(name: Notification.Name(rawValue: "kNotificationTestName"), object: "testContent")
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "kNotificationTestName"), object: ["1":2])
//        NotificationCenter.default.po
        
//       
        
        
        
//        let vm = GroupModelData.shareInstance.getGroupModelData()
//        vm.asObservable().subscribe { (model) in
//            print(model.element?[0].title)
//        }.addDisposableTo(disposeBag)
        
        
    }
    
    func refreshStatus(status:RefreshStatus)  {
        switch status {
        case .NoMoreData:
            print("没有更多的数据了")
        default:
            break

        }
    }
    func loadData(_ currentPage: Int = 1)  {
//        provider.request(.getNewsList)
        
        let params:[String : Any] = [
                    "currentPage": currentPage,
                    "pageSize": 10,
        ]
//       subscribe on  和 subscribe onNext 区别在于： on - 里面接受 next 和 完成的回调， noNext 只接受 next的回调
        
//        self.viewModel.getGroups(params: params).subscribe(onNext: {[weak self] (info) in
//            let arr =  info.productVoList
//            if let strongSelf = self,let arr = arr {
//       
//                strongSelf.dataArr.value.append(contentsOf: arr)
//                 strongSelf.mj_footer.endRefreshing()
//        
//            }
//            
//        }).addDisposableTo(disposeBag)
        
//        provider.request(.getGroupList(params: params )).subscribe { event in
//            switch event {
//            case let .next(response):
//           
//                if  let json = String(data: response.data, encoding: .utf8) {
//                        print(json)
//           
//                }
//                
////                image = UIImage(data: response.data)
//            case let .error(error):
//                print(error)
//            default:
//                break
//            }
//        }.addDisposableTo(disposeBag)
        
//        provider.request(.getGroupList(params: params)).mapString().subscribe { [weak self](event) in
//
//                print(event)
//                            let info = Mapper<ReturnInfo>().map(JSONString:(event.element ?? ""))
//                            if let strongSelf = self {
//                                let arr = info?.data?.productVoList
//                                strongSelf.dataArr.value.append(contentsOf: arr!)
//                                strongSelf.mj_footer.endRefreshing()
//            
//                            }
//
//
//        }.addDisposableTo(disposeBag)
        
        
        
        
        
        
//        provider.request(.getGroupList(params: params)).mapArray(type: ReturnInfo.self).subscribe(onNext: { (arr) in
//            print(arr)
//        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
        
        
        

        
//        
//        provider.request(.getGroupList(params: params)).mapJSON().mapObject(type: ReturnInfo.self) .subscribe(onNext: { [weak self](info: ReturnInfo) in
//
//            let arr =  info.data?.productVoList
//            if let strongSelf = self,let arr = arr {
//
//                strongSelf.dataArr.value.append(contentsOf: arr)
//                strongSelf.mj_footer.endRefreshing()
//                
//            }
//
//        }).addDisposableTo(disposeBag)
//            
        
        
        
        
        
        
//        provider.request(.getGroupList(params: params)).mapString().subscribe { (json) in
////             let info = Mapper<ReturnInfo>().map(JSONString:Untils.JSONStringify(json.element as AnyObject))
//            let info = Mapper<ReturnInfo>().map(JSONString:json.element ?? "")
//        }.addDisposableTo(disposeBag)
        
        
//        let url = URL.init(string: "http://10.0.60.121:8080/v2/product/recommend?")
//
//        let params = [
//            "currentPage": currentPage,
//            "pageSize": 10,
//        ]
//        let parameters: Parameters = [
//            "paramJson" : Untils.JSONStringify(params as AnyObject)
//      
//        ]
//        Alamofire.request(url!, method: .get, parameters: parameters).responseJSON {[weak self] response in
//            
//            if let data = response.data, let json = String(data: data, encoding: .utf8) {
//
//                let info = Mapper<ReturnInfo>().map(JSONString:json)
//                if let strongSelf = self {
//                    let arr = info?.data?.productVoList
//                    strongSelf.dataArr.value.append(contentsOf: arr!)
//                    strongSelf.mj_footer.endRefreshing()
//
//                }
//
//            }
//            
//        }
    }
    

    
    

    func configTableView()  {
        

        dataArr.asObservable().bind(to: tableView.rx.items(cellIdentifier: "TwoStyleCell", cellType: TwoStyleCell.self)){ (row,elememt,cell) in
            
            cell.lbTitle.text  = elememt.columnName!
//             cell.rightView.lb.text = elememt.title!
            
        }.disposed(by: disposeBag)
        
//        dataArr.asObservable().bind(to: tableView.rx.items())
        
        
          // 点击事件
        tableView.rx.modelSelected(RefundReason.self).subscribe { (model) in
            print(model.element?.title ?? "")
        }.addDisposableTo(disposeBag)
        
//        tableView.rx.modelSelected(type(of: dataArr.asObservable())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var mj_footer:MJRefreshAutoNormalFooter = {
        let f = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction:#selector(loadMore))!
        f.setTitle("- WOWDSGN -",  for: .noMoreData)
        f.stateLabel.textColor = UIColor.darkGray
        f.stateLabel.font = UIFont.systemFont(ofSize: 14)
        f.isAutomaticallyHidden = true
        return f
    }()
    func loadMore() {
        pageIndex += 1
//        GroupModelData.shareInstance.getGroupModelData { (vm) in
//            vm.asObservable().subscribe({[unowned self]  (model) in
//                if let a = model.element {
//                    self.dataArr.value.append(contentsOf: a)
//                }
//                
//            }).addDisposableTo(self.disposeBag)
//        }
        loadData(pageIndex)
//        print("haha")
    }

}
