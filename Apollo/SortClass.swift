//
//  BubbleSort.swift
//  AllKindsOfSort
//
//  Created by Mr.LuDashi on 16/11/4.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

let SORT_INTEVAL = 0.005

enum SortTypeEnum: String {
    case Bubble         //冒泡排序
    case Select         //选择排序
    case Insert         //插入排序
    case Shell          //希尔排序
    case Heap           //堆排序
    case Merge          //归并排序
    case Quick          //快速排序
    case Radix          //快速排序
}

/// 排序类的简单工厂
class SortFactory {
    static func create(type: SortTypeEnum) -> SortMethod {
        switch type {
        case .Bubble:
            return BubbleSort()
            
        case .Select:
            return SimpleSelectionSort()
            
        case .Insert:
            return InsertSort()
            
        case .Shell:
            return ShellSort()
            
        case .Heap:
            return HeapSort()
            
        case .Merge:
            return MergingSort()
            
        case .Quick:
            return QuickSort()
            
        case .Radix:
            return RadixSort()
        }
    }
}

/// 冒泡排序：时间复杂度----O(n^2)
class BubbleSort: SortMethod {
    func sort(items: Array<Int>, sortView: SortView) -> Array<Int> {
        //print("冒泡排序：")
        var list = items
        for i in 0..<list.count {
            var j = list.count - 1
            while j > i {
                if list[j - 1] > list[j]  { //前边的大于后边的则进行交换
                    let temp = list[j]
                    list[j] = list[j - 1]
                    list[j - 1] = temp
                    
//                    displayResult(index: j, value: list[j])
//                    displayResult(index: j-1, value: list[j-1])
                    sortView.barUpdated(index: j, value: list[j])
                    sortView.barUpdated(index: j-1, value: list[j-1])
                    Thread.sleep(forTimeInterval: SORT_INTEVAL)
                }
                j = j - 1
            }
        }
        sortView.sortFinish(result: list)
        return list
    }
}


/// 插入排序-O(n^2)
class InsertSort: SortMethod{
    func sort(items: Array<Int>, sortView: SortView) -> Array<Int> {
        //print("插入排序")
        var list = items
        for i in 1..<list.count {   //循环无序数列
            //print("第\(i)轮插入：")
            //print("要选择插入的值为：\(list[i])")
            var j = i
            while j > 0 {           //循环有序数列，插入相应的值
                if list[j] < list[j - 1]  {
                    
                    let temp = list[j]
                    list[j] = list[j-1]
                    list[j-1] = temp
                    
                    sortView.barUpdated(index: j, value: list[j])
                    sortView.barUpdated(index: j-1, value: list[j-1])
                    Thread.sleep(forTimeInterval: SORT_INTEVAL)

                    j = j - 1
                } else {
                    break
                }
            }
            //print("插入的位置为：\(j)")
            //print("本轮插入完毕, 插入结果为：\n\(list)\n")
        }
        sortView.sortFinish(result: list)
        return list
    }
}

//希尔排序：时间复杂度----O(n^(3/2))
class ShellSort: SortMethod {
    func sort(items: Array<Int>, sortView: SortView) -> Array<Int> {
        //print("希尔排序")
        var list = items
        var step: Int = list.count / 2
        while step > 0 {
            //print("步长为\(step)的插入排序开始：")
            for i in 0..<list.count {
                var j = i + step
                while j >= step && j < list.count {
                    if list[j] < list[j - step]  {
                        let temp = list[j]
                        list[j] = list[j-step]
                        list[j-step] = temp
                        
                        sortView.barUpdated(index: j, value: list[j])
                        sortView.barUpdated(index: j-step, value: list[j-step])
                        Thread.sleep(forTimeInterval: SORT_INTEVAL)

                        
                        j = j - step
                    } else {
                        break
                    }
                }
            }
            //print("步长为\(step)的插入排序结束")
            //print("本轮排序结果为：\(list)\n")
            step = step / 2     //缩小步长
        }
        sortView.sortFinish(result: list)
        return list
    }
}

/// 简单选择排序－O(n^2)
class SimpleSelectionSort: SortMethod {
    func sort(items: Array<Int>, sortView: SortView) -> Array<Int> {
        //print("简单选择排序")
        var list = items
        for i in 0..<list.count {
            //print("第\(i+1)轮选择，选择下标的范围为\(i)----\(list.count)")
            var j = i + 1
            var minValue = list[i]
            var minIndex = i
            
            //寻找无序部分中的最小值
            while j < list.count {
                if minValue > list[j] {
                    minValue = list[j]
                    minIndex = j
                }
                sortView.barUpdated(index: j, value: list[j])
                Thread.sleep(forTimeInterval: SORT_INTEVAL)

                j = j + 1
            }
            //print("在后半部分乱序数列中，最小值为：\(minValue), 下标为：\(minIndex)")
            //与无序表中的第一个值交换，让其成为有序表中的最后一个值
            if minIndex != i {
                //print("\(minValue)与\(list[i])交换")
                let temp = list[i]
                list[i] = list[minIndex]
                list[minIndex] = temp
                
                sortView.barUpdated(index: i, value: list[i])
                sortView.barUpdated(index: minIndex, value: list[minIndex])
                Thread.sleep(forTimeInterval: SORT_INTEVAL)

            }
            //print("本轮结果为：\(list)\n")
        }
        //self.successSort(sortList: list)
        sortView.sortFinish(result: list)
        return list
        
    }
}



/// 堆排序 (O(nlogn))
class HeapSort: SortMethod {
    
    func sort(items: Array<Int>, sortView: SortView) -> Array<Int> {
        //print("堆排序：\(items)")
        var list = items
        var endIndex = items.count - 1
        
        //创建大顶堆，其实就是将list转换成大顶堆层次的遍历结果
        heapCreate(items: &list, sortView: sortView)

        //print("原始堆：\(list)")
        while endIndex >= 0 {
            //将大顶堆的顶点（最大的那个值）与大顶堆的最后一个值进行交换
            //print("将list[0]:\(list[0])与list[\(endIndex)]:\(list[endIndex])交换")
            let temp = list[0]
            list[0] = list[endIndex]
            list[endIndex] = temp
            
            sortView.barUpdated(index: 0, value: list[0])
            sortView.barUpdated(index: endIndex, value: list[endIndex])
            Thread.sleep(forTimeInterval: SORT_INTEVAL)
            endIndex -= 1   //缩小大顶堆的范围
            
            //对交换后的大顶堆进行调整，使其重新成为大顶堆
            heapAdjast(items: &list, startIndex: 0,endIndex: endIndex + 1, sortView: sortView)
            //print("调整后:\(list)\n")
        }
        //self.successSort(sortList: list)
        sortView.sortFinish(result: list)
        return list
    }
    
    
    /// 构建大顶堆的层次遍历序列（f(i) > f(2i), f(i) > f(2i+1) i > 0）
    ///
    /// - parameter items:    构建大顶堆的序列
    func heapCreate(items: inout Array<Int>, sortView: SortView) {
        var i = items.count
        while i > 0 {
            heapAdjast(items: &items, startIndex: i - 1, endIndex:items.count, sortView: sortView )
            i -= 1
        }
    }
    
    /// 对大顶堆的局部进行调整，使其该节点的所有父类符合大顶堆的特点
    ///
    /// - parameter items:    list
    /// - parameter endIndex: 当前要调整的节点
    func heapAdjast(items: inout Array<Int>, startIndex: Int, endIndex: Int, sortView: SortView) {
        let temp = items[startIndex]
        var fatherIndex = startIndex + 1                 //父节点下标
        var maxChildIndex = 2 * fatherIndex //左孩子下标
        while maxChildIndex <= endIndex {
            //比较左右孩子并找出比较大的下标
            if maxChildIndex < endIndex && items[maxChildIndex-1] < items[maxChildIndex] {
                maxChildIndex = maxChildIndex + 1
            }
            
            //如果较大的那个子节点比根节点大，就将该节点的值赋给父节点
            if temp < items[maxChildIndex-1] {
                items[fatherIndex-1] = items[maxChildIndex-1]
                sortView.barUpdated(index: fatherIndex-1, value: items[fatherIndex-1])
                Thread.sleep(forTimeInterval: SORT_INTEVAL)
            } else {
                break
            }
            fatherIndex = maxChildIndex
            maxChildIndex = 2 * fatherIndex
        }
        items[fatherIndex-1] = temp
        sortView.barUpdated(index: fatherIndex-1, value: items[fatherIndex-1])
        Thread.sleep(forTimeInterval: SORT_INTEVAL)
    }

}



/// 归并排序O(nlogn)
class MergingSort: SortMethod {
    var tempArray: Array<Array<Int>> = []
    func sort(items: Array<Int>, sortView: SortView) -> Array<Int> {
        tempArray.removeAll()
        //将数组中的每一个元素放入一个数组中
        for item in items {
            var subArray: Array<Int> = []
            subArray.append(item)
            tempArray.append(subArray)
        }
        
        //对这个数组中的数组进行合并，直到合并完毕为止
        while tempArray.count != 1 {
            var i = 0
            while i < tempArray.count - 1 {
                //print("将\(tempArray[i])与\(tempArray[i+1])合并")
                tempArray[i] = mergeArray(firstList: tempArray[i], secondList: tempArray[i + 1])
                tempArray.remove(at: i + 1)
                for subIndex in 0..<tempArray[i].count{
                    let index = self.countSubItemIndex(endIndex: i, subItemIndex: subIndex)
                    sortView.barUpdated(index: index, value: tempArray[i][subIndex])
                    Thread.sleep(forTimeInterval: SORT_INTEVAL)
                    
                    
                }
                i = i + 1
            }
        }
        //self.successSort(sortList: tempArray.first!)
        sortView.sortFinish(result: tempArray.first!)
        return tempArray.first!
    }
    
    
    /// 归并排序中的“并”--合并：将两个有序数组进行合并
    ///
    /// - parameter firstList:  第一个有序数组
    /// - parameter secondList: 第二个有序数组
    ///
    /// - returns: 返回排序好的数组
    func mergeArray(firstList: Array<Int>, secondList: Array<Int>) -> Array<Int> {
        var resultList: Array<Int> = []
        var firstIndex = 0
        var secondIndex = 0
        
        while firstIndex < firstList.count && secondIndex < secondList.count {
            if firstList[firstIndex] < secondList[secondIndex] {
                resultList.append(firstList[firstIndex])
                firstIndex += 1
            } else {
                resultList.append(secondList[secondIndex])
                secondIndex += 1
            }
        }
        
        while firstIndex < firstList.count {
            resultList.append(firstList[firstIndex])
            firstIndex += 1
        }
        
        while secondIndex < secondList.count {
            resultList.append(secondList[secondIndex])
            secondIndex += 1
        }
        
        return resultList
    }
    
    func countSubItemIndex(endIndex: Int, subItemIndex: Int) -> Int {
        var sum = 0
        for i in 0..<endIndex {
            sum += tempArray[i].count
        }
        
        return sum + subItemIndex
    }
}


/// 快速排序O(nlogn)
class QuickSort: SortMethod {
    func sort(items: Array<Int>, sortView: SortView) -> Array<Int> {
        var list = items
        //print("快速排序开始：")
        quickSort(list: &list, low: 0, high: list.count-1, sortView: sortView)
        //print("快速排序结束！")
        //self.successSort(sortList: list)
        sortView.sortFinish(result: list)
        return list
    }
    
    
    /// 快速排序
    ///
    /// - parameter list: 要排序的数组
    /// - parameter low: 数组的上界
    /// - parameter high: <#high description#>
    private func quickSort(list: inout Array<Int>, low: Int, high: Int,  sortView: SortView) {
        if low < high {
            let mid = partition(list: &list, low: low, high: high, sortView: sortView)
            quickSort(list: &list, low: low, high: mid - 1, sortView: sortView)   //递归前半部分
            quickSort(list: &list, low: mid + 1, high: high, sortView: sortView)  //递归后半部分
        }
    }
    
    /// 将数组以第一个值为准分成两部分，前半部分比该值要小，后半部分比该值要大
    ///
    /// - parameter list: 要二分的数组
    /// - parameter low:  数组的下界
    /// - parameter high: 数组的上界
    ///
    /// - returns: 分界点

    private func partition(list: inout Array<Int>, low: Int, high: Int,  sortView: SortView) -> Int {
        var low = low
        var high = high
        let temp = list[low]
        //print("low[\(low)]:\(list[low]), high[\(high)]:\(list[high])")
        while low < high {
            
            while low < high && list[high] >= temp {
                high -= 1
            }
            list[low] = list[high]
            sortView.barUpdated(index: low, value: list[low])
            
            while low < high && list[low] <= temp {
                low += 1
            }
            list[high] = list[low]
            sortView.barUpdated(index: high, value: list[high])
            Thread.sleep(forTimeInterval: SORT_INTEVAL)
        }
        list[low] = temp
        sortView.barUpdated(index: low, value: list[low])
        Thread.sleep(forTimeInterval: SORT_INTEVAL)
        //print("mid[\(low)]:\(list[low])")
        //print("\(list)\n")
        sortView.sortFinish(result: list)
        return low
    }
}

//基数排序
class RadixSort: SortMethod {
    func sort(items: Array<Int>, sortView: SortView) -> Array<Int> {
        var list = items
        if list.count > 0 {
            radixSort(list: &list, sortView: sortView)
        }
        //self.successSort(sortList: list)
        sortView.sortFinish(result: list)
        return list
    }
    
    private func radixSort(list: inout Array<Int>, sortView: SortView) {
        var bucket = createBucket()
        let maxNumber = listMaxItem(list: list)
        let maxLength = numberLength(number: maxNumber)
        
        for digit in 1...maxLength {
            //入桶
            for item in list {
                let baseNumber = fetchBaseNumber(number: item, digit: digit)
                bucket[baseNumber].append(item) //根据基数入桶
            }
            
            //出桶
            var index = 0
            for i in 0..<bucket.count {
                while !bucket[i].isEmpty {
                    list[index] = bucket[i].remove(at: 0)
                    sortView.barUpdated(index: index, value: list[index])
                    Thread.sleep(forTimeInterval: SORT_INTEVAL)
                    index += 1
                }
            }
        }
        
        
        
    }
    
    /// 创建10个桶
    ///
    /// - returns: 返回创建好的桶子
    private func createBucket() -> Array<Array<Int>> {
        var bucket: Array<Array<Int>> = []
        for _ in 0..<10 {
            bucket.append([])
        }
        return bucket
    }
    
    
    /// 计算序列中最大的那个数
    ///
    /// - parameter list: 数列
    ///
    /// - returns: 返回该数列中最大的值
    private func listMaxItem(list: Array<Int>) -> Int {
        var maxNumber = list[0]
        for item in list {
            if maxNumber < item {
                maxNumber = item
            }
        }
        return maxNumber
    }
    
    
    /// 获取数字的长度
    ///
    /// - parameter number: 该数字
    ///
    /// - returns: 返回该数字的长度
    func numberLength(number: Int) -> Int {
        return "\(number)".characters.count
    }
    
    
    /// 获取相应位置的数字
    ///
    /// - parameter number: 操作的数字
    /// - parameter digit:  位数
    ///
    /// - returns: 返回该位数上的数字
    func fetchBaseNumber(number: Int, digit: Int) -> Int{
        if digit > 0 && digit <= numberLength(number: number) {
            var numbersArray: Array<Int> = []
            for char in "\(number)".characters {
                numbersArray.append(Int("\(char)")!)
            }
            return numbersArray[numbersArray.count - digit]
        }
        return 0
    }
    
}




