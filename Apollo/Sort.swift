//
//  SortType.swift
//  AllKindsOfSort
//
//  Created by Mr.LuDashi on 16/11/4.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

protocol SortView {
    func sortFinish(result: Array<Int>)
    func barUpdated(index: Int, value: Int)
}

protocol SortMethod {
    func sort(items: Array<Int>, sortView: SortView) -> Array<Int>
}
