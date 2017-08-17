# ShengYinShaLongKaoTi

# 08 - 16
# 学习篇 
#### 摘要:

* [linksAndPicturePreview](#lapp) -- <span id="bk-lapp"> bk-lapp </span>
* [00. 碎碎念](#00) -- <span id="bk00"> bk00 </span> 
* [01. 自写暴力接口预览](#01) -- <span id="bk01"> bk01 </span> 
 

### <span id="00"> 00. titleName </span> ==[bk00](#bk00)==
* 有幸, 获得胜因沙龙的趣味试题, 谢过胜因, 好久没锻炼过了, 哈哈, 代码有点暴力, 小白一枚, 见谅 ! 附上[门级店下钻编程原作者链接](http://www.jianshu.com/p/566c416f113b)

### <span id="01"> 01. 自写暴力接口预览 </span> ==[bk01](#bk01)==

```

#import <Foundation/Foundation.h>

@interface NSArray (HXL)
//=================================================================
//                       需求一的功能接口区域
//=================================================================
/**
 随机生成一个二维数组，行数 >= 3，且行数据项不可重复 (需求一可以多行多列, 但对应需求二的接口实现, 暂不能解析超过3列, 可以多行)
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
 0. 行数上实现了多行, 暂用 10行测试过; 
 1. 但列数暂为 行业--> 区域--> 店铺 模式的解析;
 2. 如果加入街道 行业--> 区域-->街道...-->店铺 变为 3列以上的解析, 要手动设置参数;
 3. 暂时没时间了, 下个版本抽时间解析自动到多列; 如有问题, 请各种联系我;
 
 @param originArray 传入源数据, 此题中为随机的二维数组
 @return 解析后的数组
 */
+ (NSArray *)requireTwo:(NSArray *)originArray;

/**
 获取 解析数组
 
 @param dataFourDArray 四维数组
 @return 解析数组
 */
+ (NSArray *)getTargetArrayWithdataFourDArray:(NSArray *)dataFourDArray;

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

```