//
//  TestOne.m
//  门店级下钻测试 -- 此为题一, 题目在最下面; 
//
//  Created by Jefrl on 2017/8/15.
//  Copyright © 2017年 Jefrl. All rights reserved.
//

#import "TestOne.h"

@implementation TestOne

#pragma mark ===================== 规定的标识 =====================
static NSString * const mainData = @"main_data";
static NSString * const subData = @"sub_data";

#pragma mark ===================== 功能方法区域 =====================
// 通过传入的 指定标题数组与参照数组, 获取分类出来的数组
- (NSArray *)arrayWithTitleArray:(NSArray *)titleArray originArray:(NSArray *)originArray
{
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (NSArray *tempArray in originArray) { // 传入的大数组逆序遍历出一个个单一数组如: @[@"标题6", @x1, @x2, @x3]
    
        for (id objectTitle in titleArray) { // 传入的标题数组如: @[@"标题1", @"标题3", @"标题6"];
        
            if ([tempArray containsObject:objectTitle]) { // 如有包含如: @"标题1"
                [arrayM addObject:tempArray]; // 则加入找到的整个数组如: @[@"标题1", @1, @2, @3]
            }
        }
    }
    
    return arrayM;
}

// 通过传入的 指定标题数组, 下标索引与参照数组, 构造对应键值对的字典
- (NSDictionary *)dictionaryWithTempArray:(NSArray *)tempArray
{
    NSDictionary *dictionary = [NSMutableDictionary dictionary];
    NSArray *previousArray = [NSArray array];
    
    NSInteger index = tempArray.count - 1;
    for (NSInteger i = index; i >= 0; i--) { // 传入的大数组逆序遍历出一个个单一数组如: @[@"标题6", @x1, @x2, @x3]
        NSArray *mainArray = tempArray[i];
        
        // 不断以逆序数组问 mainData 的值, 以上一次记录的数组为 subData 的值, 实现一个有出口的递归
        NSDictionary *dict = @{mainData : mainArray, subData : previousArray};
        NSArray *array = @[dict];
        // 记录新值
        previousArray = array;
        dictionary = dict;
    }
    
    return dictionary;
}

// 将第2组大数组, 将标题5 提出来, 分成3小组
- (NSDictionary *)dictionaryWithTitleArray:(NSArray *)titleArray indexOne:(NSInteger)indexOne indexTwo:(NSInteger)indexTwo originArray:(NSArray *)originArray
{
    
    NSMutableArray *arrayM = [NSMutableArray array];
    NSDictionary *dictTwo = [NSDictionary dictionary];
    NSDictionary *dictFive = [NSDictionary dictionary];
    NSDictionary *dictMix = [NSDictionary dictionary];
    
    for (NSArray *tempArray in originArray) { // 传入的大数组遍历出一个个单一数组如: @[@"标题5", @x1, @x2, @x3]
        if ([tempArray containsObject:titleArray[indexOne]]) { // 如有包含如: @"标题2"
            // 将标题2保存为一个字典
            dictTwo = [self dictionaryWithTempArray:@[tempArray]];
        } else if ([tempArray containsObject:titleArray[indexTwo]]) { // 如有包含如: @"标题5"
            // 将标题5保存为一个字典
            dictFive = [self dictionaryWithTempArray:@[tempArray]];
        } else { // 非标题5 另存一个数组中
            [arrayM addObject:tempArray];
            dictMix = [self dictionaryWithTempArray:arrayM];
        }
    }
    
    NSDictionary *dictionary = @{mainData : dictTwo[mainData], subData : @[dictMix, dictFive]};
//    NSLog(@"%@", dictFive);
//    NSLog(@"%@", dictTwo);
//    NSLog(@"%@", dictMix);
//    NSLog(@"%@", dictionary);
    
    return dictionary;
}

#pragma mark ===================== 程序的主方法区域 =====================
- (NSArray *)handleOriginData:(NSArray *)originArray
{
    // 00. 特定的标识数组
    NSArray *titleArrayOne = @[@"标题1", @"标题3", @"标题6"];
    NSArray *titleArrayTwo = @[@"标题2", @"标题4", @"标题5", @"标题7", @"标题8"];
    
    // 01. 先得到第一层级中的 两组大数组 01, 02;
    NSArray *arrayMFirstOne = [self arrayWithTitleArray:titleArrayOne originArray:originArray];
    NSArray *arrayMFirstTwo = [self arrayWithTitleArray:titleArrayTwo originArray:originArray];

    // 02, 处理大数组中第一组, 对应键值对的字典, 并递归合成目标字典
    NSDictionary *dictOne = [self dictionaryWithTempArray:arrayMFirstOne];
//    NSLog(@"%@", dictOne);
    
    // 03, 处理大数组中第二组, 对应键值对的字典, 并合成目标字典
    NSDictionary *dictTwo = [self dictionaryWithTitleArray:titleArrayTwo indexOne:0 indexTwo:2 originArray:arrayMFirstTwo];

    return @[dictOne, dictTwo];
}

#pragma mark ===================== 初始化区域 =====================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始数据结构
    NSArray *originArray = @[
                             @[@"标题1", @1, @2, @3],
                             @[@"标题2", @4, @5, @6],
                             @[@"标题3", @7, @8, @9],
                             @[@"标题4", @10, @11, @12],
                             @[@"标题5", @13, @14, @15],
                             @[@"标题6", @16, @17, @18],
                             @[@"标题7", @19, @20, @21],
                             @[@"标题8", @22, @23, @24]
                             
                             ];
    
    // 开始处理原始数据
    NSArray * getTagetArray = [self handleOriginData:originArray];
    NSLog(@"%@",getTagetArray);
    
    BOOL flag = [getTagetArray writeToFile:@"/Users/Jefrl/Desktop/getTagetArray.plist" atomically:YES];
    if (flag) {
        NSLog(@"写入成功");
    }
    
}


@end

#pragma mark ===================== 编程考核题一 题目 =====================
// 已经将原题目转为对应的 OC 语言编程试题
/*
// 初始数据结构
NSArray *originArray = @[
                         @[@"标题1", @1, @2, @3],
                         @[@"标题2", @4, @5, @6],
                         @[@"标题3", @7, @8, @9],
                         @[@"标题4", @10, @11, @12],
                         @[@"标题5", @13, @14, @15],
                         @[@"标题6", @16, @17, @18],
                         @[@"标题7", @19, @20, @21],
                         @[@"标题8", @22, @23, @24]
                         
                         ];

// 需要获得的数据结构
NSArray *arrTest = @[
                     
                     @{
                         @"main_data": @[@"标题1", @1, @2, @3],
                         @"sub_data" : @[
                                 @{
                                     @"main_data": @[@"标题3", @7, @8, @9],
                                     @"sub_data" : @[
                                             @{
                                                 @"main_data": @[@"标题6", @16, @17, @18],
                                                 @"sub_data" : @[]
                                                 }]
                                     }]
                         },
                     
                     @{
                         @"main_data": @[@"标题2", @4, @5, @6],
                         @"sub_data" : @[
                                 @{
                                     @"main_data": @[@"标题4", @10, @11, @12],
                                     @"sub_data" : @[
                                             @{
                                                 @"main_data": @[@"标题7", @19, @20, @21],
                                                 @"sub_data" : @[
                                                         @{
                                                             @"main_data": @[@"标题8", @22, @23, @24],
                                                             @"sub_data" : @[]
                                                             }]
                                                 }]
                                     },
                                 @{
                                     @"main_data": @[@"标题5", @13, @14, @15],
                                     @"sub_data" : @[]
                                     }]
                         }
                     
                     ];

*/

#pragma mark ===================== 控制台输出 =====================
/*
[
	{
        main_data : [
                     标题1,
                     1,
                     2,
                     3
                     ],
        sub_data : [
                    {
                        main_data : [
                                     标题3,
                                     7,
                                     8,
                                     9
                                     ],
                        sub_data : [
                                    {
                                        main_data : [
                                                     标题6,
                                                     16,
                                                     17,
                                                     18
                                                     ],
                                        sub_data : [
                                        ]
                                    }
                                    ]
                    }
                    ]
    },
	{
        main_data : [
                     标题2,
                     4,
                     5,
                     6
                     ],
        sub_data : [
                    {
                        main_data : [
                                     标题4,
                                     10,
                                     11,
                                     12
                                     ],
                        sub_data : [
                                    {
                                        main_data : [
                                                     标题7,
                                                     19,
                                                     20,
                                                     21
                                                     ],
                                        sub_data : [
                                                    {
                                                        main_data : [
                                                                     标题8,
                                                                     22,
                                                                     23,
                                                                     24
                                                                     ],
                                                        sub_data : [
                                                        ]
                                                    }
                                                    ]
                                    }
                                    ]
                    },
                    {
                        main_data : [
                                     标题5,
                                     13,
                                     14,
                                     15
                                     ],
                        sub_data : [
                        ]
                    }
                    ]
    }
 ]
 */
