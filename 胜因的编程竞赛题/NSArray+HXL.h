//
//  NSArray+HXL.h
//  门店级下钻测试
//
//  Created by Jefrl on 2017/8/16.
//  Copyright © 2017年 Jefrl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (HXL)
//=================================================================
//                       需求一的功能接口区域
//=================================================================
/**
 随机生成一个二维数组，行数 >= 3，列数3列, 且行数据项不可重复
 @param dataTDArray 传入的随机的一维数组
 @param rowCount 指定的行数
 @return 随机的二维数组
 */
+ (NSArray *)requireOne:(NSArray *)dataTDArray rowCount:(NSInteger)rowCount;

/**
 获取随机组成的一维数组
 
 @param dataTDArray 传入的二维数组
 @return  随机的一维数组
 */
+ (NSArray *)arrayWithDataTDArray:(NSArray *)dataTDArray;

//=================================================================
//                       需求二的功能接口区域
//=================================================================
/**
 该接口说明:
 1. 实现了多行, 但列数暂为 行业--> 区域--> 店铺模式的 3列解析;
 2. 如果加入街道 行业--> 区域-->街道...-->店铺 变为3列以上的解析, 要手动设置参数;
 3. 暂时没时间了, 下个版本抽时间解析自动到多列; 如有问题, 请各种联系我;
 
 @param originArray 传入源数据, 此题中为随机的二维数组
 @return 解析后的数组
 */
+ (NSArray *)requireTwo:(NSArray *)originArray;

/**
 解析四维数组
 
 @param fourDArray 传入四维数组
 @return 解析好的数组 (内部类似四级字典)
 */
+ (NSArray *)arrayAnalyzedWithFourDArray:(NSArray *)fourDArray;

/**
 三维转四维
 获得二级分类的四维数组 (此题为区域分类)
 
 @param dataThreeDArray 三维数组
 @param compareIndex 做判断的下标值
 @return 四维数组
 */
+ (NSArray *)getDataFourDArrayWithThreeDArray:(NSArray *)dataThreeDArray compareIndex:(NSInteger)compareIndex;

/**
 二维转三维
 
 @param originArray 传入的二维原数组
 @param compareIndex 指定数组的下标值, 用以比较元素
 @return 分好类别的三维数组
 */
+ (NSArray *)getDataThreeDArrayWithTwoDArray:(NSArray *)originArray compareIndex:(NSInteger)compareIndex;





@end
