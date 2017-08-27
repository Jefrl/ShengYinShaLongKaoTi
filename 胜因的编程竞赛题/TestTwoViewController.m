//
//  TestTwoViewController.m
//  门店级下钻测试 ---- 趣味沙龙编程考核题 之门店级下钻, 题目在最下面;
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

// 指定的行数
static NSInteger const rowCount = 3;

/** 个人文件说明:
 
 // 任意假定数据源 商家-->区域-->店铺;
 // 目前版本设为 0.1.0 以实现 多行3列 的随机生成二维数组, 并成功解析 2017.08.17
 // 计划下一个版本 0.2.0 实现 多行多列 如: 商家-->区域-->街道-->店铺; >=4 列以上;
 // 没想的那么容易的感觉; 先缓缓;
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark =========== 方便测试需求二多行情况, 假设获得的随机数据如下 =====================
    NSArray *testTwoDArray = @[
                               
                               @[@"商行", @"农行"],
                               @[@"华北", @"华东", @""],
                               @[@"宝山街", @"宝菊街", @"顾村街"],
                               @[@"龙华西路店", @"龙华北路店", @"总店"]
                               
                               ];
#pragma mark ==========================================================================
    NSArray *dataTwoDArray = @[
                               
                             @[@"商行", @"农行"],
                             @[@"华北", @"华东", @""],
                             @[@"龙华西路店", @"龙华北路店", @"总店"]
                             
                             ];
    // 00. 任意行数数, 随便指定为 3;
    NSInteger count = rowCount;
    
    // 01. 调用需求一的接口, 获得目标数组
    NSArray *array = [NSArray requireOne:dataTwoDArray rowCount:count];
    NSLog(@"%@", array);
    
#pragma mark =========== 方便测试需求二多行情况, 假设获得的随机数据如下 =====================
    // 任意行数数, 测试指定为 10 行;
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wunused-variable"
    NSArray *arrayTest = @[
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
#pragma clang diagnostic pop
    
    // 02. 调用需求二的接口, 获得目标数组,
      NSArray *arrayTwo =  [NSArray requireTwo:arrayTest];
    NSLog(@"%@", arrayTwo);
    
    // 03. 并写入 plist 文件
    // BOOL flag = [arrayTwo writeToFile:@"/Users/Jefrl/Desktop/MenDianJiRequireTwo.plist" atomically:YES];
    // if (flag) NSLog(@"写入成功");
    
}


#pragma mark ===================== 趣味沙龙编程考核题 之门店级下钻 题目 =====================

/*
 * 随机生成一个二维数组，行列数 >= 3，行数据项不可重复（编程）
 * 文字描述数据结构转化的编程思路
 * 把 1 中生成的二维数组转化为期望的哈希-数组混合数据结构（编程）（若实现不了，尽可能地做出些效果）
 * 在自己能力范围内尽可能的去实现，提交源代码文件名称格式: 解决方案 - 提交者.编程语言，项目名称格式：解决方案 - 编程语言
 */

- (void)testQuestions
{
    // 初始数据结构(随机), 若情况如下
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wunused-variable"
    
    NSArray *originArray = @[
                             @[@"商行", @"华北", @"龙华西路店"],
                             @[@"商行", @"华北", @"龙华北路店"],
                             @[@"农行", @"华东", @"龙华北路店"],
                             @[@"农行", @"总店"]
                             
                             ];
#pragma clang diagnostic pop
    
    
// ------------------> 解析需要达到的需求 样例 <----------------------------
    
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
    
    
}
@end
