//
//  NSArray+HXL.h
//  胜因的编程竞赛题
//
//  Created by Jefrl on 2017/8/16.
//  Copyright © 2017年 Jefrl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (HXL)
#pragma mark ===================== 需求一功能实现区域 =====================

/**
 随机生成一个二维数组，行列数 >= 3，行数据项不可重复
 
 @param dataTDArray 传入的随机的一维数组
 @param rowCount 指定的列数
 @return 返回获得的二维数组
 */
+ (NSArray *)requireOne:(NSArray *)dataTDArray rowCount:(NSInteger)rowCount;

/**
 获取随机组成的一维数组
 
 @param dataTDArray 传入的二维数组
 @return  随机的一维数组
 */
+ (NSArray *)arrayWithDataTDArray:(NSArray *)dataTDArray;

#pragma mark ===================== 需求二功能实现区域 =====================


@end
