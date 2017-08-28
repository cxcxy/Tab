//
//  TextKitVC.swift
//  Tab
//
//  Created by 陈旭 on 2017/8/4.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
import AVFoundation

class TextKitVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var aboutToBecomeInvisibleCell = -1
    var avPlayerLayer: AVPlayerLayer!
//    var videoURLs:[String] = []
    var firstLoad = true
    var visibleIP : IndexPath?
     @IBOutlet weak var feedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(UINib.init(nibName: "VideoCellTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "VideoCellTableViewCell")
//        feedTableView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
        //Your model to hold the videos in the video URL
//        for i in 0..<2{
//            let url = Bundle.main.url(forResource:"\(i+1)", withExtension: "mp4")
//            videoURLs.append(url!)
//        }
        // initialized to first indexpath
        visibleIP = IndexPath.init(row: 0, section: 0)

     
    }
    // video paths
    lazy var videoURLs: Array<String> = {
        return [
            "http://lavaweb-10015286.video.myqcloud.com/%E5%B0%BD%E6%83%85LAVA.mp4",
            "http://lavaweb-10015286.video.myqcloud.com/lava-guitar-creation-2.mp4",
            "http://lavaweb-10015286.video.myqcloud.com/hong-song-mei-gui-mu-2.mp4",
            "http://lavaweb-10015286.video.myqcloud.com/ideal-pick-2.mp4",
            
            // This path is a https.
            // "https://bb-bang.com:9002/Test/Vedio/20170110/f49601b6bfe547e0a7d069d9319388f4.mp4",
            // "http://123.103.15.1JPVideoPlayerDemoNavAndStatusTotalHei:8880/myVirtualImages/14266942.mp4",
            
            // This video saved in amazon, maybe load sowly.
            // "http://vshow.s3.amazonaws.com/file147801253818487d5f00e2ae6e0194ab085fe4a43066c.mp4",
            "http://120.25.226.186:32812/resources/videos/minion_01.mp4",
            "http://120.25.226.186:32812/resources/videos/minion_02.mp4",
            "http://120.25.226.186:32812/resources/videos/minion_03.mp4",
            "http://120.25.226.186:32812/resources/videos/minion_04.mp4",
            "http://120.25.226.186:32812/resources/videos/minion_05.mp4",
            "http://120.25.226.186:32812/resources/videos/minion_06.mp4",
            "http://120.25.226.186:32812/resources/videos/minion_07.mp4",
            "http://120.25.226.186:32812/resources/videos/minion_08.mp4",
            
            // To simulate the cell have no video to play.
            // "",
            "http://120.25.226.186:32812/resources/videos/minion_10.mp4",
            "http://120.25.226.186:32812/resources/videos/minion_11.mp4",
            "http://lavaweb-10015286.video.myqcloud.com/%E5%B0%BD%E6%83%85LAVA.mp4",
            "http://lavaweb-10015286.video.myqcloud.com/lava-guitar-creation-2.mp4",
            "http://lavaweb-10015286.video.myqcloud.com/hong-song-mei-gui-mu-2.mp4",
            "http://lavaweb-10015286.video.myqcloud.com/ideal-pick-2.mp4"]
    }()

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Thats it, just provide the URL from here, it will change with didSet Method in your custom cell class
        let cell = self.feedTableView.dequeueReusableCell(withIdentifier: "VideoCellTableViewCell") as! VideoCellTableViewCell
        cell.videoPlayerItem = AVPlayerItem.init(url:  URL.init(string: videoURLs[indexPath.row % 2])! )
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let indexPaths = self.feedTableView.indexPathsForVisibleRows
        var cells = [Any]()
        guard let indexPath = indexPaths else {
            return
        }
        for ip in indexPath{
            if let videoCell = self.feedTableView.cellForRow(at: ip) as? VideoCellTableViewCell{
                cells.append(videoCell)
            }
        }
        let cellCount = cells.count
        if cellCount == 0 {return}
        if cellCount == 1{
            if visibleIP != indexPaths?[0]{
                visibleIP = indexPaths?[0]
            }
            if let videoCell = cells.last! as? VideoCellTableViewCell{
                self.playVideoOnTheCell(cell: videoCell, indexPath: (indexPaths?.last)!)
            }
        }
        if cellCount >= 2 {
            for i in 0..<cellCount{
                let cellRect = self.feedTableView.rectForRow(at: (indexPaths?[i])!)
                let intersect = cellRect.intersection(self.feedTableView.bounds)
                //                curerntHeight is the height of the cell that
                //                is visible
                let currentHeight = intersect.height
                print("\n \(currentHeight)")
                let cellHeight = (cells[i] as AnyObject).frame.size.height
                //                0.95 here denotes how much you want the cell to display
                //                for it to mark itself as visible,
                //                .95 denotes 95 percent,
                //                you can change the values accordingly
                if currentHeight > (cellHeight * 0.95){
                    if visibleIP != indexPaths?[i]{
                        visibleIP = indexPaths?[i]
                        print ("visible = \(indexPaths?[i])")
                        if let videoCell = cells[i] as? VideoCellTableViewCell{
                            self.playVideoOnTheCell(cell: videoCell, indexPath: (indexPaths?[i])!)
                        }
                    }
                }
                else{
                    if aboutToBecomeInvisibleCell != indexPaths?[i].row{
                        aboutToBecomeInvisibleCell = (indexPaths?[i].row)!
                        if let videoCell = cells[i] as? VideoCellTableViewCell{
                            self.stopPlayBack(cell: videoCell, indexPath: (indexPaths?[i])!)
                        }
                        
                    }
                }
            }
        }
    }
    func playVideoOnTheCell(cell : VideoCellTableViewCell, indexPath : IndexPath){
        cell.startPlayback()
    }
    
    func stopPlayBack(cell : VideoCellTableViewCell, indexPath : IndexPath){
        cell.stopPlayback()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("end = \(indexPath)")
        if let videoCell = cell as? VideoCellTableViewCell {
            videoCell.stopPlayback()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
extension Array {
    
    //In Objective-C you'd perform the swizzling in load(),
    //but this method is not permitted in Swift
//    override class func initialize()
//    {
////        
////        struct Inner {
////            static let i = {
//        
//                let originalSelector = #selector(TestSwizzling.methodOne)
//                let swizzledSelector = #selector(TestSwizzling.methodTwo)
//                let originalMethod = class_getInstanceMethod(TestSwizzling.self, originalSelector);
//                let swizzledMethod = class_getInstanceMethod(TestSwizzling.self, swizzledSelector)
//                method_exchangeImplementations(originalMethod, swizzledMethod)
////            }
////        }
////        let _ = Inner.i
//    }
//    func initialize() {
//        
//    }
    
//    
//    func methodTwo()->Int{
//        // It will not be a recursive call anymore after the swizzling
//        return methodTwo()+1
//    }
    
    
    
    subscript (safe index: Int) -> Element? {
    
        return (0 ..< count).contains(index) ? self[index] : nil
    }
}
