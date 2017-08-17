//
//  NSArray+HXL.m
//  胜因的编程竞赛题
//
//  Created by Jefrl on 2017/8/16.
//  Copyright © 2017年 Jefrl. All rights reserved.
//

#import "NSArray+HXL.h"

@implementation NSArray (HXL)
//=================================================================
//                       指定的字段
//=================================================================
static NSString * const mainData = @"title";
static NSString * const subData = @"items";


//=================================================================
//                       需求一的功能接口区域
//=================================================================
/**
 随机生成一个二维数组，行数 >= 3，列数3列, 且行数据项不可重复
 @param dataTDArray 传入的随机的一维数组
 @param rowCount 指定的行数
 @return 随机的二维数组
 */
+ (NSArray *)requireOne:(NSArray *)dataTDArray rowCount:(NSInteger)rowCount
{
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (NSInteger i = 0; i < rowCount; i++) {
        
        BOOL flag = YES;
        // 从封装的分类中获取随机行数组;
        NSArray *array = [NSArray arrayWithDataTDArray:dataTDArray];
        
        for (NSArray *arr in arrayM) { // 如果有相同行数据, 不合格, 当次循环重启, 且阀门关闭
            if ([arr isEqual:array]) {
                i--;
                flag = NO;
            }
        }
        
        if (flag) { // 获的二维数组
            [arrayM addObject:array];
        }
    }
    
    // NSLog(@"%@", arrayM);
    return arrayM;
}

/**
 获取随机组成的一维数组
 
 @param dataTDArray 传入的二维数组
 @return  随机的一维数组
 */
+ (NSArray *)arrayWithDataTDArray:(NSArray *)dataTDArray
{
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (NSArray *array in dataTDArray) {
        // 获取随机数的取值范围
        NSInteger randomRangeOne = array.count;
        // 获取随机的索引值
        NSInteger randomIndexOne = arc4random() % randomRangeOne;
        // 获取随机值
        NSString *randomOne = array[randomIndexOne];
        if ([randomOne isEqualToString:@""]) { // 如果是空字符, 则去掉该元素, 直接接店铺
            continue;
        }
        
        [arrayM addObject:randomOne];
    }
    
    return arrayM;
}



//=================================================================
//                       需求二的功能接口区域
//=================================================================

/**
 实现了多行, 但列数暂为 行业--> 区域--> 店铺模式的 3列解析; 
 如果加入街道 行业--> 区域-->街道...-->店铺 变为3列以上的解析, 要手动设置参数;
 暂时没时间了, 下个版本抽时间解析自动到多列;

 @param originArray 传入随机的二维数组
 @return 解析后的数组
 */
+ (NSArray *)requireTwo:(NSArray *)originArray
{
    // 00. 获取 分类后的三维数组
    NSArray *dataThreeDArray = [self getDataThreeDArrayWithTwoDArray:originArray compareIndex:0];
    // 01. 获取 再次分类后的四维数组
    NSArray *dataFourDArray = [self getDataFourDArrayWithThreeDArray:dataThreeDArray compareIndex:1];
    // 02. 获取 解析后的目标数组
    NSArray *targetArray = [self getTargetArrayWithdataFourDArray:dataFourDArray];
    
    return targetArray;
}

/**
 获取 解析数组

 @param dataFourDArray 四维数组
 @return 解析数组
 */
+ (NSArray *)getTargetArrayWithdataFourDArray:(NSArray *)dataFourDArray
{
    NSMutableArray *containBankArray = [NSMutableArray array];
    
    for (NSArray *threeDArray in dataFourDArray) { // 4->3
        
        // 记录性字符串
        NSString *bankTitle;
        NSString *zoneTitle;
        
        // 包含了区域的数组
        NSMutableArray *containZoneArray = [NSMutableArray array];
        
#pragma mark ===================== 解析开始中 ===============================================================
        if (threeDArray.count == 1) { // 分支 3W-01 如果三维数组, 只有一个子集
            
            for (NSArray *twoDArray in threeDArray) {
                
                if (twoDArray.count == 1) { // 分支2W-01 如果 二维数组内, 也只有一个子集
                    // 初始的空数组
                    NSArray *previousArray = [NSArray array];
                    
                    NSDictionary *onlyBankSameZoneDictM = [NSDictionary dictionary];
                    for (NSArray *array in twoDArray) { // 2-> 1
                        
                        NSInteger index = array.count - 1;
                        // 倒数第三个(这里也就是第一个) 元素的值;
                        bankTitle = array[0];
                        
                        for (NSInteger i = index; i >= 1; i--) { // 保留银行名等合并
                            NSString *mainString = array[i];
                            
                            // 不断以逆序数组问 mainData 的值, 以上一次记录的数组为 subData 的值, 实现一个有出口的递归
                            NSDictionary *dict = @{mainData : mainString, subData : previousArray};
                            NSArray *array = @[dict];
                            // 记录新值
                            previousArray = array;
                            onlyBankSameZoneDictM = dict;
                        }
                    }
                    // 保存字典
                    [containZoneArray addObject:onlyBankSameZoneDictM];
                    
#pragma mark ===================== 小 if 的结束 ===============================================================
                    
                } else { // 分支2W-02 如果二维数组内, 有多个子集(银行, 区域都相同, 只有店铺不相同的二维数组)
                    // 初始的空数组
                    NSArray *emptyArray = [NSArray array];
                    
                    NSDictionary *bankZoneSameDictM = [NSDictionary dictionary];
                    NSMutableArray *containStoreArrayM = [NSMutableArray array];
                    for (NSArray *array in twoDArray) { // 2 -> 1维
                        
                        NSInteger index = array.count - 1;
                        NSString *mainString = array[index];
                        NSDictionary *dict = @{mainData : mainString, subData : emptyArray};
                        // 将循环的末尾字典, 全加入数组
                        [containStoreArrayM addObject:dict];
                        
                        // 记录下倒数第二个, 倒数第三个(这里也就是第一个) 元素的值;
                        if (array.count < 3) {
                            zoneTitle = array[1];
                            bankTitle = array[0];
                        } else {
                            zoneTitle = array[index - 1];
                            bankTitle = array[index - 2];
                        }
                        
                    }
                    
                    // 合并小字典成区域字典;
                    NSString *mainString = zoneTitle;
                    NSDictionary *dict = @{mainData : mainString, subData : containStoreArrayM};
                    // 有两个区域相同的字典保存
                    bankZoneSameDictM = dict;
                    
                    // 区域字典全都, 保存到数组;
                    [containZoneArray addObject:bankZoneSameDictM];
                    
                } // 上一层的 小 else 结束 而已
                
            } // 分支 3W-01 如果三维数组, 只有一个子集 的 for 循环而已
#pragma mark ===================== 最大的 if 的结束 ===============================================================
        } else { // 分支 3W-02 如果三维数组内, 有多个子集(二维数组)
            
            for (NSArray *twoDArray in threeDArray) { // 3->2
                
                // 分支01, 只有银行相同, 区域跟店铺不同的二维数组
                if (twoDArray.count == 1) { //  又一个 分支2W-01 如果 二维数组内, 也只有一个子集
                    // 初始的空数组
                    NSArray *previousArray = [NSArray array];
                    
                    NSDictionary *onlyBankSameZoneDictM = [NSDictionary dictionary];
                    for (NSArray *array in twoDArray) { // 2-> 1
                        
                        NSInteger index = array.count - 1;
                        // 倒数第三个(这里也就是第一个) 元素的值;
                        bankTitle = array[0];
                        
                        for (NSInteger i = index; i >= 1; i--) { // 保留银行名等合并
                            NSString *mainString = array[i];
                            
                            // 不断以逆序数组问 mainData 的值, 以上一次记录的数组为 subData 的值, 实现一个有出口的递归
                            NSDictionary *dict = @{mainData : mainString, subData : previousArray};
                            NSArray *array = @[dict];
                            // 记录新值
                            previousArray = array;
                            onlyBankSameZoneDictM = dict;
                        }
                    } // for 循环结束
                    
                    // 保存字典
                    [containZoneArray addObject:onlyBankSameZoneDictM];
                    
#pragma mark ===================== 小 if 的结束 ===============================================================
                    
                } else { // 分支2W-02 如果二维数组内, 有多个子集(银行, 区域都相同, 只有店铺不相同的二维数组)
                    // 初始的空数组
                    NSArray *emptyArray = [NSArray array];
                    
                    NSDictionary *bankZoneSameDictM = [NSDictionary dictionary];
                    NSMutableArray *containStoreArrayM = [NSMutableArray array];
                    for (NSArray *array in twoDArray) { // 2 -> 1维
                        
                        NSInteger index = array.count - 1;
                        NSString *mainString = array[index];
                        NSDictionary *dict = @{mainData : mainString, subData : emptyArray};
                        // 将循环的末尾字典, 全加入数组
                        [containStoreArrayM addObject:dict];
                        
                        // 记录下倒数第二个, 倒数第三个(这里也就是第一个) 元素的值;
                        // 记录下倒数第二个, 倒数第三个(这里也就是第一个) 元素的值;
                        if (array.count < 3) {
                            zoneTitle = array[1];
                            bankTitle = array[0];
                        } else {
                            zoneTitle = array[index - 1];
                            bankTitle = array[index - 2];
                        }
                        
                    }
                    
                    // 合并小字典成区域字典;
                    NSString *mainString = zoneTitle;
                    NSDictionary *dict = @{mainData : mainString, subData : containStoreArrayM};
                    // 有两个区域相同的字典保存
                    bankZoneSameDictM = dict;
                    
                    // 区域字典全都, 保存到数组;
                    [containZoneArray addObject:bankZoneSameDictM];
                    
                } // 分支 3W-02 中的 小 else 结束而已
                
            }  // 分支 3W-02 如果三维数组内, 有多个子集(二维数组) 的 for 循环而已
            
#pragma mark ===================== 最大的 else 的结束 =====================
        } // 3w - 02 的 else 而已
        
        // 将银行相同的字典合并为数组;
        NSString *mainString = bankTitle;
        NSDictionary *containBankdict = @{mainData : mainString, subData : containZoneArray};
        
        [containBankArray addObject:containBankdict];
        
    } // 4w 的循环 而已
    
    return containBankArray;
}

/**
 三维转四维
 获得二级分类的四维数组 (此题为区域分类)
 
 @param dataThreeDArray 三维数组
 @param compareIndex 做判断的下标值
 @return 四维数组
 */
+ (NSArray *)getDataFourDArrayWithThreeDArray:(NSArray *)dataThreeDArray compareIndex:(NSInteger)compareIndex
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSArray *array in dataThreeDArray) { // 遍历出二维数组, 再次对比第二级, 进行区域再次分类
        
        // 获得第二级也相同的新的三维数组
        NSArray *newThreeDArray = [self getDataThreeDArrayWithTwoDArray:array compareIndex:1];
        
        // 这里由于只有三列, 银行--> 区域--> 店铺; 所以依然有局限性,
        // 如果加上街道, 就会有四列 银行--> 区域--> 街道--> 店铺;
        // 这样我就需要多一层比较 compareIndex 等于 2 时情况, 但是此为手动赋值, 后期迭代看怎么改为, 扩展性更强的接口;
        
        [arrayM addObject:newThreeDArray]; // 获得四维数组
    }
    return arrayM;
}


/**
 二维转三维
 
 @param originArray 传入的二维原数组
 @param compareIndex 指定数组的下标值, 用以比较元素
 @return 分好类别的三维数组
 */
+ (NSArray *)getDataThreeDArrayWithTwoDArray:(NSArray *)originArray compareIndex:(NSInteger)compareIndex
{
    // 失效跳出无限循环的标识
    NSInteger invalidCount = 0;
    
    NSMutableArray *originArrayM = [NSMutableArray arrayWithArray:originArray];
    
    // 00. 三维数组;
    NSMutableArray *threeDArray = [NSMutableArray array];
    
    while (1) {
        
        // 跳出无限循环的校验 02
        NSInteger count = originArrayM.count;
        
        if (invalidCount != count) {
            invalidCount = count;
        } else {
            //  不再有相同类别, 将刷新的原数组包含的不相同二维数组保存到三维数组中, 并返回 新获得的数组
            for (NSArray *array in originArrayM) { // 将子集大于1的数组拆分, 并分别包装成相同层级关系, 加入三维数组
                NSArray *twoDArray = @[array];
                
                [threeDArray addObject:twoDArray];
            }
            return threeDArray;
        }
        
        // 00. 拿出每行的第 compareIndex 个元素, 分别于后面比较
        BOOL flag = NO;
        NSMutableArray *collectArrayM = [NSMutableArray array];
        
        for (NSInteger j = 0; j< count - 1; j++) {
            
            NSString *title = originArrayM[j][compareIndex];
            for (NSInteger i = j+1 ; i< count; i++) { // 从1 开始不能跟自己对比, 不然所有元素都成对了;
                
                NSArray *array = originArrayM[i];
                NSString *compareTitle = array[compareIndex];
                if ([compareTitle isEqualToString:title]) { // 如果包含第一级元素; 如商行, 重新生成二维数组
                    [collectArrayM addObject:array];
                    flag = YES; // 获取到同一类别, 打开阀门
                }
                
                if (flag && i == count - 1) { // 同一对比元素下, 第一个元素只增加一次;
                    
                    // 检测阀门如果打开了, 要把第一个做对比的元素加入
                    [collectArrayM addObject:originArrayM[j]];
                }
                
            }
            
            if (flag) { // 检查阀门
                // 01. 并且原数组移除分好类的数组;
                for (NSArray *array in collectArrayM) {
                    [originArrayM removeObject:array];
                }
                // 02. 添加分好类别的二维数组 到三维数组中
                [threeDArray addObject:collectArrayM];
                
                // 跳出无限循环的校验 01
                if (originArrayM.count == 0 || originArrayM.count == 1) {
                    if (originArrayM.count != 0) {
                        [threeDArray addObject:originArrayM];
                        return threeDArray;
                    } else {
                        return threeDArray;
                    }
                }
                
                // 源数组改变打破循环
                break;
            }
        }
        
        
    }  // while 循环;
    
    return threeDArray;
}


@end
