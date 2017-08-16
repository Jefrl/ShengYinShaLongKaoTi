//
//  NSArray+HXL.m
//  胜因的编程竞赛题
//
//  Created by Jefrl on 2017/8/16.
//  Copyright © 2017年 Jefrl. All rights reserved.
//

#import "NSArray+HXL.h"

@implementation NSArray (HXL)
#pragma mark ===================== 需求一功能实现区域 =====================

/**
 随机生成一个二维数组，行列数 >= 3，行数据项不可重复

 @param dataTDArray 传入的随机的一维数组
 @param rowCount 指定的列数
 @return 返回获得的二维数组
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


#pragma mark ===================== 需求二功能实现区域 =====================


@end
