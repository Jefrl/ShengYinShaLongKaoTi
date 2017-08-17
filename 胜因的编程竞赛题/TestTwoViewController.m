//
//  TestTwoViewController.m
//  胜因的编程竞赛题
//
//  Created by Jefrl on 2017/8/16.
//  Copyright © 2017年 Jefrl. All rights reserved.
//

#import "TestTwoViewController.h"
#import "NSArray+HXL.h"
#import "NSDictionary+HXL.h"


@interface TestTwoViewController ()

@end

@implementation TestTwoViewController

#pragma mark ===================== 规定的标识 =====================
static NSString * const mainData = @"title";
static NSString * const subData = @"items";

// 指定的行数
static NSInteger const rowCount = 5;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 任意假定数据源 商家-->区域-->店铺;
    // 目前版本设为 0.1.0 以实现 多行3列 的随机生成二维数组, 并成功解析 2017.08.17
    // 计划下一个版本 0.2.0 实现 多行多列 如: 商家-->区域-->街道-->店铺; >=4 列以上;
    // 没想的那么容易的感觉; 先缓缓;
    NSArray *dataTwoDArray = @[
                               
                             @[@"商行", @"农行"],
                             @[@"华北", @"华东", @""],
                             @[@"龙华西路店", @"龙华北路店", @"总店"]
                             
                             ];
    // 任意行数数, 随便指定为 5;
    NSInteger count = rowCount;
    // 01. 调用需求一的方法接口
//    NSArray *array = [NSArray requireOne:dataTwoDArray rowCount:count];
    
#pragma mark ===================== 假设获得的随机数据如下, 方便测试需求二 =====================
    // 任意行数数, 测试指定为 10 行;
    NSArray *array = @[
                       @[@"农行", @"华北", @"龙华西路店"],
                       
                       @[@"商行", @"华北", @"龙华北路店"],
                       @[@"商行", @"华北", @"龙华西路店"],
                       @[@"商行", @"华北", @"总店"],
                       
                       @[@"商行", @"华东", @"总店"],
                       
                       @[@"商行", @"总店"],
                       
                       @[@"建行", @"华北", @"龙华北路店"],
                       @[@"建行", @"华北", @"龙华西路店"],
                       
                       @[@"央行", @"华东", @"总店"],
                       
                       @[@"央行", @"总店"]
                       
                       
                       ];
    
    // 02. 调用需求二的方法, 获得目标数组,
      NSArray *arrayTwo =  [self requireTwo:array];
    NSLog(@"%@", arrayTwo);
    
    // 03. 并写入 plist 文件
    BOOL flag = [arrayTwo writeToFile:@"/Users/Jefrl/Desktop/MenDianJiRequireTwo.plist" atomically:YES];
    if (flag) NSLog(@"写入成功");
    
}

#pragma mark ===================== 需求02 的实现 =====================
- (NSArray *)requireTwo:(NSArray *)originArray
{
    // 获取 分类后的三维数组
    NSArray *dataThreeDArray = [self getDataThreeDArrayWithTwoDArray:originArray compareIndex:0];
    NSLog(@"%@", dataThreeDArray);
    
    // 获取 再次分类后的四维数组
    NSArray *dataFourDArray = [self getDataFourDArrayWithThreeDArray:dataThreeDArray compareIndex:1];
    
    NSLog(@"%@", dataFourDArray);
    
    // 获取 解析后的目标数组
    NSArray *targetArray = [self getTargetArrayWithdataFourDArray:dataFourDArray];
    //NSLog(@"%@", targetArray);
    
    return targetArray;
}

#pragma mark ===================== 功能模块 =====================
// 对区域相同的进行了再次分类
- (NSArray *)getDataFourDArrayWithThreeDArray:(NSArray *)dataThreeDArray compareIndex:(NSInteger)compareIndex
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSArray *array in dataThreeDArray) { // 遍历出二维数组, 再次对比第二级, 进行区域再次分类
        NSLog(@"%@", array);
        
        // 获得第二级也相同的新的三维数组
        NSArray *newThreeDArray = [self getDataThreeDArrayWithTwoDArray:array compareIndex:1];
        
        // 这里由于只有三列, 银行--> 区域--> 店铺; 所以依然有局限性,
        // 如果加上街道, 就会有四列 银行--> 区域--> 街道--> 店铺;
        // 这样我就需要多一层比较 compareIndex 等于 2 时情况, 但是此为手动赋值, 后期迭代看怎么改为, 扩展性更强的接口;
        
        [arrayM addObject:newThreeDArray]; // 获得四维数组
    }
    return arrayM;
}

- (NSArray *)getTargetArrayWithdataFourDArray:(NSArray *)dataFourDArray
{
    NSLog(@"%@", dataFourDArray);
    
    NSMutableArray *containBankArray = [NSMutableArray array];
    
    for (NSArray *threeDArray in dataFourDArray) { // 4->3  2农加1农
        NSLog(@"%@", threeDArray);
        
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
                        NSLog(@"%@", array);
                        
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
                NSLog(@"%@", twoDArray);
                
                // 进入的二维数组有区分的解析
                
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
                        NSLog(@"%@", array);
                        
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

#pragma mark ===================== 解析模块区域 =====================

// 通过传入的 指定标题数组, 下标索引与参照数组, 构造对应键值对的字典
- (NSDictionary *)dictionaryWithTempArray:(NSArray *)tempArray
{
    
    return @{};
}

#pragma mark ===================== 类别的(如银行)分类接口 =====================
/**
 获得分好类别的三维数组

 @param originArray 传入的原数组
 @param compareIndex 比较的元素的下标值
 @return 分好类的三维数组
 */

- (NSArray *)getDataThreeDArrayWithTwoDArray:(NSArray *)originArray compareIndex:(NSInteger)compareIndex
{
    // 失效跳出无限循环的标识
    NSInteger invalidCount = 0;
    
    NSMutableArray *originArrayM = [NSMutableArray arrayWithArray:originArray];
    
    // 00. 三维数组;
    NSMutableArray *threeDArray = [NSMutableArray array];
    
    while (1) {
        
        // 跳出无限循环的校验 02
        NSInteger count = originArrayM.count;
        NSLog(@"%ld -- %ld", invalidCount, count);
        
        if (invalidCount != count) {
            invalidCount = count;
        } else {
            NSLog(@"%@", originArrayM);
            NSLog(@"%@", threeDArray);
            
            
            //  不再有相同类别, 将刷新的原数组包含的不相同二维数组保存到三维数组中, 并返回 新获得的数组
            for (NSArray *array in originArrayM) { // 将子集大于1的数组拆分, 并分别包装成相同层级关系, 加入三维数组
                NSArray *twoDArray = @[array];
                
                NSLog(@"%@", array);
                NSLog(@"%@", twoDArray);
                
                [threeDArray addObject:twoDArray];
            }
            return threeDArray;
        }
        
        // 00. 拿出每行的第一个元素, 分别于后面比较
        BOOL flag = NO;
        NSMutableArray *collectArrayM = [NSMutableArray array];
        
        for (NSInteger j = 0; j< count - 1; j++) {
            
            NSString *title = originArrayM[j][compareIndex];
            NSLog(@"count= %ld, j= %ld, title= %@", count, j, originArrayM[j][compareIndex]);
            
            
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
                NSLog(@"%@", collectArrayM);
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

#pragma mark ===================== 原题目 =====================
- (void)testQuestions
{
    // 初始数据结构(随机), 若情况如下
    NSArray *originArray = @[
                             @[@"商行", @"华北", @"龙华西路店"],
                             @[@"商行", @"华北", @"龙华北路店"],
                             @[@"农行", @"华东", @"龙华北路店"],
                             @[@"农行", @"总店"]
                             
                             ];

   /* 
    * 随机生成一个二维数组，行列数 >= 3，行数据项不可重复（编程）
    * 文字描述数据结构转化的编程思路
    * 把 1 中生成的二维数组转化为期望的哈希-数组混合数据结构（编程）（若实现不了，尽可能地做出些效果）
    * 在自己能力范围内尽可能的去实现，提交源代码文件名称格式: 解决方案 - 提交者.编程语言，项目名称格式：解决方案 - 编程语言
    */
// =============> 需要达到的需求
#pragma mark ===================== TableView Delegate or DataSource =====================
  /*
    [
     {
         title : 商行,
         items : [
                  {
                      title : 华北,
                      items : [
                               {
                                   title : 龙华西路店,
                                   items : [
                                   ]
                               }
                               ]
                  },
                  
                  {
                      title : 华东,
                      items : [
                               {
                                   title : 总店,
                                   items : [
                                   ]
                               }
                               ]
                  },
                  
                  {
                      title : 总店,
                      items : [
                      ]
                  },
                  {
                      title : 华北,
                      items : [
                               {
                                   title : 龙华北路店,
                                   items : [
                                   ]
                               }
                               ]
                  }
                  ]
     },
     {
         title : 农行,
         items : [
                  {
                      title : 华北,
                      items : [
                               {
                                   title : 龙华西路店,
                                   items : [
                                   ]
                               }
                               ]
                  }
                  ]
     }
     ]*/
    
// ======================= 无敌分割线 ============================================
    
}
@end
