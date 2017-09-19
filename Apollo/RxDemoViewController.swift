//
//  RxDemo.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-04-03.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import PhotosUI
import Async
import PromiseKit

class RxDemoViewController: BaseViewController {
    
    private let disposeBag = DisposeBag()
    @IBOutlet weak var btnAsyncSwift: UIButton!
    
    override var name: String {
        return "RxSwift Demo"
    }
    
    @IBAction func rxDemo1(_ sender: Any) {
        print("RxSwift1")
        
        let _ = Observable.from([1,2,3,4,5])
            .flatMap({ (value) -> Observable<String> in
                //
                sleep(1)
                let s = "A+\(value)"
                print("Observable flatMap: \(s)")
                return Observable.just(s)
            })
            .subscribe(onNext: { (value) in
                print("got \(value)")
            }, onError: { (erro) in
                //
            }, onCompleted: { 
                //
                print("completed😬")
            }, onDisposed: { 
                //
            })
    }
    @IBAction func scan(_ sender: Any) {
        
        //fetchPhoto()
        //fetchPhotoCollectionList()
        fetchAssetCollection()
    }
    
    private func fetchPhoto1(){
        let fetchOptions = PHFetchOptions()
        
        let albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        print("smartAlbums count \(albums.count)")
        
        albums.enumerateObjects({ (collection, index, stop) in
            //
            
            print("index: \(index), \(collection.description)")
      
        })
    }
    
    private func fetchAssetCollection(){
        let result = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
        result.enumerateObjects({ (collection, index, stop) in
            if let albumName = collection.localizedTitle {
                print("Album => \(collection.localIdentifier), \(collection.estimatedAssetCount), \(albumName) ")
            }
            
            let assResult = PHAsset.fetchAssets(in: collection, options: nil)
            
            
            assResult.enumerateObjects({ (asset, index, stop) in
                //print("index \(index)")
                
                let options = PHImageRequestOptions()
                options.resizeMode = .exact
                let scale = UIScreen.main.scale
                let dimension = CGFloat(78.0)
                // 获取原图
                let size = PHImageManagerMaximumSize
                options.deliveryMode = .highQualityFormat
                options.isSynchronous = true
                
                
                PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .default, options: options) { (image, info) in
                    if let name = asset.originalFilename {
                        print("photo \(name) \(index) \(String(describing: image?.size)) ")
                    }
                }
 
 
                /*
                 // http://www.hangge.com/blog/cache/detail_1233.html
                 // 获取原图
                 */
                
                /*
                PHImageManager.default().requestImageData(for: asset, options: nil, resultHandler: { (data, text, orientation, info) in
                    if let name = asset.originalFilename {
                        print("photo \(name) \(asset.localIdentifier)")
                    }
                    //
                })
 */
                /*
                PHImageManager.default().requestImageData(for: asset, options: nil, resultHandler: { _, _, _, info in
                    if let name = (info!["PHImageFileURLKey"] as? NSURL)?.lastPathComponent {
                        print("photo \(name) \(asset.localIdentifier)")
                    }
                })
 */
                

            })
            print("finish")

        })
    }
    
    private func fetchPhotoCollectionList(){
        let result = PHCollectionList.fetchCollectionLists(with: .folder, subtype: .any, options: nil)
        print("result \(result.count)")
        result.enumerateObjects({ (collectionList, index, stop) in
            print("title: \(String(describing: collectionList.localizedTitle))")
        })
    }
    
    
    @IBAction func asyncSwiftDemo(_ sender: Any) {
        let group = AsyncGroup()
        group.background {
            print("This is run on the background queue")
            sleep(2)
        }
        group.background {
            print("This is also run on the background queue in parallel")
            sleep(5)
        }
        print("waiting......")
        group.wait()
        print("Both asynchronous blocks are complete")
        print("======================================================")
        Async.userInitiated {
            // 1
                return 10
            }.main {
                // 2
                print("got \($0) in main")
            }.background {
                // 3
                sleep(5)
                print("got \($0) in background")
            }.main {
                // 4
                let text = "AsyncSwift \($0)"
                self.btnAsyncSwift.setTitle(text, for: .normal)
                print("got \($0) in main")
            }
    }
    
    
    private func fetchPhoto() {
        let fetchOptions = PHFetchOptions()
        let descriptor = NSSortDescriptor(key: "creationDate", ascending: true)
        fetchOptions.sortDescriptors = [descriptor]
        
        let fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        
        guard fetchResult.firstObject != nil else {
            return
        }
        let options = PHImageRequestOptions()
        options.resizeMode = .exact
        let scale = UIScreen.main.scale
        let dimension = CGFloat(78.0)
        let size = CGSize(width: dimension * scale, height: dimension * scale)
        
        var count = 0
        fetchResult.enumerateObjects({ (asset, index, stop) in
            //print("====== \(asset.description) ")
            PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: options) { (image, info) in
                count = count + 1
                if let name = asset.originalFilename {
                    print("photo \(count): \(name) ")
                }
                
            }
        })
    }
    
    @IBAction func rxSchedulerTest(_ sender: UIButton) {
        print("==UI \(Thread.current)")
        
        Observable.create { (observer: AnyObserver<Int>) -> Disposable in
                print("==Observable \(Thread.current)")
                observer.onNext(1)
                observer.onCompleted()
                return Disposables.create()
            }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map({ (n) -> Int in
                print("==A \(Thread.current)")
                return n + 10
            })
            .observeOn(MainScheduler.instance)
            .map({ (m) -> String in
                print("==B \(Thread.current)")
                return String(m)
            })
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
            .map({ (text) -> String in
                print("==C \(Thread.current)")
                return "X" + text
            })
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (text) in
                print("==D \(Thread.current)")
                print("got \(text)")
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
    }

    
    @IBAction func btnPromiseClicked(_ sender: Any) {
        PHPhotoLibrary.requestAuthorization().then { authorized in
            print("authorized: \(authorized.rawValue)")  // => true or false
        }.always {
            print("promise finished")
        }

        /*
        firstly {
            UIApplication.shared.networkActivityIndicatorVisible = true
        }.then {
            return CLLocationManager.promise()
        }.then { location in
            let alert = UIAlertView()
            alert.addButton(title: "Proceed!")
            alert.addButton(title: "Proceed, but fastest!")
            alert.cancelButtonIndex = alert.addButton("Cancel")
            return alert.promise()
        }.then { dismissedButtonIndex in
            //… cancel wasn't pressed
        }.always {
            // *still* runs if the promise was cancelled
            UIApplication.shared.networkActivityIndicatorVisible = false
        }.catch { error in
            //… cancel wasn't pressed
        }
        */
    }
}


extension PHAsset {
    
    var originalFilename: String? {
        
        var fname:String?
        
        if #available(iOS 9.0, *) {
            let resources = PHAssetResource.assetResources(for: self)
            if let resource = resources.first {
                fname = resource.originalFilename
            }
        }
        
        if fname == nil {
            // this is an undocumented workaround that works as of iOS 9.1
            fname = self.value(forKey: "filename") as? String
        }
        
        return fname
    }
}
