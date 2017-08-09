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



struct Module {
    let des:String?
    let img:String?
    
    let img1:String?
//    let img2:String = ""
    
}


class SecondViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    
    let dataSource  = RxTableViewSectionedReloadDataSource<SectionModel<String,Module>>()
    let viewModel  = GroupViewModel()
    var pageIndex = 1
    var isOpen : Bool = false
    
    var dataArr = Variable<[SectionModel<String,RefundReason>]>([])
    
    var arr  = Variable<[SectionModel<String,Module>]>([])
    
    
//    let model = Module.init(des: "hahah", img: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle    = .none
        self.tableView.rowHeight            = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight   = 60
        tableView.register(UINib.init(nibName: "WOWApplyAfterCell", bundle: Bundle.main), forCellReuseIdentifier: "WOWApplyAfterCell")
        tableView.register(UINib.init(nibName: "TwoStyleCell", bundle: Bundle.main), forCellReuseIdentifier: "TwoStyleCell")
        tableView.register(UINib.init(nibName: "WOWBrandRecommendCell", bundle: Bundle.main), forCellReuseIdentifier: "WOWBrandRecommendCell")
        tableView.register(UINib.init(nibName: "BrandStoryCell", bundle: Bundle.main), forCellReuseIdentifier: "BrandStoryCell")
        
        tableView.mj_footer = mj_footer
        tableView.mj_header = mj_header
        
        
        self.arr.value.append(SectionModel.init(model: "0", items: [Module.init(des: "1111111222222啊六点开始给发货速度发啊叫啊叫短款礼服哈只能下次 v 看啊就打开了飞机啊哭了低中年级考虑爱噢点击分卡家；啦都来自农村吗菂哦书法家了；阿道夫快乐；啊激动哭了哭宗角禄康 v 家拉开的烦恼看了考场女看男自噢家adorn阿奎罗放假啊可怜的飞机离开了看着你下次哦 v 啊就哦 if你你啊发髻；埃及看哪都开了房间",
                                                                                img: "https://img.wowdsgn.com/page/banners/2c7589b3-7ffb-41b7-8df2-a5a2551dc143_2dimension_1248x624.jpg",
                                                                                img1: "https://img.wowdsgn.com/page/banners/2c7589b3-7ffb-41b7-8df2-a5a2551dc143_2dimension_1248x624.jpg")]))
        
        
        
        
        self.arr.value.append(SectionModel.init(model: "0", items: [Module.init(des: "2222222", img: "https://img.wowdsgn.com/page/banners/73a2b371-5888-4906-a990-25e47f708cab_2dimension_904x603.jpg", img1: nil)]))
        self.arr.value.append(SectionModel.init(model: "0", items: [Module.init(des: "3333333", img: "https://img.wowdsgn.com/page/banners/73a2b371-5888-4906-a990-25e47f708cab_2dimension_904x603.jpg", img1: nil)]))
        self.arr.value.append(SectionModel.init(model: "0", items: [Module.init(des: "4444444", img: "https://img.wowdsgn.com/page/banners/73a2b371-5888-4906-a990-25e47f708cab_2dimension_904x603.jpg", img1: nil)]))
        self.arr.value.append(SectionModel.init(model: "0", items: [Module.init(des: "555555", img: "https://img.wowdsgn.com/page/banners/73a2b371-5888-4906-a990-25e47f708cab_2dimension_904x603.jpg", img1: nil)]))
        self.arr.value.append(SectionModel.init(model: "0", items: [Module.init(des: "6666666", img: "https://img.wowdsgn.com/page/banners/73a2b371-5888-4906-a990-25e47f708cab_2dimension_904x603.jpg", img1: nil)]))
        
        
        arr.asObservable().bind(to: tableView.rx.items(dataSource: dataSource)).addDisposableTo(disposeBag)
        
        dataSource.configureCell = { [unowned self](_ , tableView , indexPath , element) in

            
//         if indexPath.section  != 0{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "BrandStoryCell") as! BrandStoryCell
//            
//                cell.data = element
//                return cell
//            
//         }else {
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "WOWBrandRecommendCell") as! WOWBrandRecommendCell
            
//                let arr = ["1","2","3"]
//                cell.hightConstraint.constant = CGFloat(arr.count * 127)
//                cell.dataArr.value = arr

                return cell
//            }

            
        }
     // 点击事件
        tableView.rx
            .itemSelected
            .map { [unowned self] (indexPath) in
                return (indexPath, self.dataSource[indexPath])
            }
            .subscribe(onNext: { indexPath, model in
                print("Tapped `\(model)` @ \(indexPath)")
            })
            .addDisposableTo( disposeBag)
        


          // 点击事件
//        tableView.rx.modelSelected(type(of: self.dataSource).Section.Item.self).subscribe { (model) in
//            print(model.element?.title ?? "")
//        }.addDisposableTo(disposeBag)
        

        
        tableView.rx
            .setDelegate(self)
            .addDisposableTo(disposeBag)
        
//        loadData(pageIndex)
        
      
//        configTableView()
    }

    func loadData(_ currentPage: Int = 1)  {
        let url = URL.init(string: "http://10.0.60.121:8080/v2/product/recommend?")
        
        let params = [
            "currentPage": currentPage,
            "pageSize": 10,
            ]
        let parameters: Parameters = [
            "paramJson" : JSONStringify(params as AnyObject)
            
        ]

//        viewModel.getGroups(params: params).bind(to: tableView.rx.items(dataSource: dataSource)).addDisposableTo(disposeBag)
        
        Alamofire.request(url!, method: .get, parameters: parameters).responseJSON {[weak self] response in
            
            if let data = response.data, let json = String(data: data, encoding: .utf8) {
                
                let info = Mapper<ReturnInfo>().map(JSONString:json)
                if let strongSelf = self {
                    let arr = info?.data?.productVoList
                    if strongSelf.pageIndex == 1 {
                        strongSelf.dataArr.value.removeAll()
                    }
                    arr?.enumerated().forEach({
                        strongSelf.dataArr.value.append(SectionModel.init(model: "0", items: [$1]))
                    })
                    strongSelf.mj_footer.endRefreshing()
                    strongSelf.mj_header.endRefreshing()

                }
                
            }
            
        }
    }
    
    func configTableView()  {

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
    lazy var mj_header:MJRefreshHeader = {
        let f = MJRefreshHeader(refreshingTarget: self, refreshingAction:#selector(loadRefresh))!

        return f
    }()
    func loadRefresh() {
        pageIndex = 1
        loadData(pageIndex)
        
    }
    func loadMore() {
        pageIndex += 1
        loadData(pageIndex)
        
    }
    func JSONStringify(_ value: AnyObject,prettyPrinted:Bool = false) -> String{
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        if JSONSerialization.isValidJSONObject(value) {
            
            do{
                let data = try JSONSerialization.data(withJSONObject: value, options: options)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }catch {
                
            }
        }
        return ""
        
    }
    deinit {
        print("shifang")
    }
}

extension SecondViewController: UITableViewDelegate,BrandDelegate,TVDelegate ,T_TextDelegate,BrandStoryDelegate{
    func heightChange() {
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    func heightAllChange() {
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    func updateHeightCell(){
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func reloadData(){
    
        tableView.reloadData()
    }
}