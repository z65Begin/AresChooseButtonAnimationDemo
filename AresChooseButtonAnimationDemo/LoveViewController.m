//
//  LoveViewController.m
//  AresChooseButtonAnimationDemo
//
//  Created by Admin on 16/12/6.
//  Copyright © 2016年 AresBegin. All rights reserved.
//

#import "LoveViewController.h"

#import "ReusableView.h"
#import "XLPlainFlowLayout.h"
//#import "HomeCollectionViewCell.h"
#import "HomeBean.h"
#import "Path_NSObject.h"

#import "LoveCollectionViewCell.h"
@interface LoveViewController ()<UINavigationControllerDelegate>

@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,strong) NSMutableArray *array_02;
@property (nonatomic,strong) Path_NSObject *shaXiang;

@end

static NSString *cellID = @"CollectionCell2";
static NSString *headerID = @"headerID";
static NSString *footerID = @"footerID";

@implementation LoveViewController

/**
 *  开始启动的时候调用，把init换掉
 *
 *  @param coder <#coder description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithCoder:(NSCoder *)coder
{
    
    self = [super initWithCoder:coder];
    
    if (self) {
        XLPlainFlowLayout *layout = [XLPlainFlowLayout new];
        layout.itemSize = CGSizeMake(100, 100);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.naviHeight = 44.0;
        
        return [self initWithCollectionViewLayout:layout];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[LoveCollectionViewCell  class] forCellWithReuseIdentifier:cellID];
    [self.collectionView registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:headerID];
    [self.collectionView registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter  withReuseIdentifier:footerID];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

/**
 *  一组有多少个
 *
 *  @param collectionView <#collectionView description#>
 *  @param section        <#section description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return  (0 == section) ? self.array.count : self.array_02.count;
}

/**
 *  cell里面的数据
 *
 *  @param collectionView <#collectionView description#>
 *  @param indexPath      <#indexPath description#>
 *
 *  @return <#return value description#>
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LoveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    NSMutableDictionary *dic = nil;
    if(0 == indexPath.section){
        dic = self.array[indexPath.row];
    }else{
        dic = self.array_02[indexPath.row];
    }
    HomeBean *homeBean = [HomeBean homeBeanWithDict:dic];
    cell.homeBean = homeBean;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind==UICollectionElementKindSectionFooter) {
        ReusableView *footer = [collectionView  dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerID forIndexPath:indexPath];
        return footer;
    }
    if (indexPath.section >-1) {
        ReusableView *header = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        
        header.backgroundColor = [UIColor colorWithRed:0/255.0 green:153/255.0 blue:204/255.0 alpha:1];
        
        NSString *name = @"";
        
        if(0 == indexPath.section){
            name = @"点击添加";
        }else{
            name = @"选择功能";
        }
        header.text = name;
        
        return header;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.height;
    
    int width_int = (int) width;
    
    if(480 == width_int){
        
        return CGSizeMake(60, 70);
    }else{
        
        return CGSizeMake(60, 90);
    }
}

/**
 *  点击单元格
 *
 *  @param collectionView <#collectionView description#>
 *  @param indexPath      <#indexPath description#>
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    int a = (int)indexPath.section;
    
    //其实，是沙箱之间的数据的删除和添加。(不能用self.shaXiang 没有数据。不知道为啥)
    NSMutableArray  *array_02 = nil;
    NSMutableArray  *array_01 = nil;
    Path_NSObject *shaXiang = [[Path_NSObject alloc] init];
    NSString *dataFile_02 = [[shaXiang docPath] stringByAppendingPathComponent:@"two.plist"];//第二个沙箱
    NSString *dataFile_01 = [[shaXiang docPath] stringByAppendingPathComponent:@"one.plist"];//第一个沙箱
    if (0 == a) {
        
        // dataFile_01 =[[shaXiang docPath] stringByAppendingPathComponent:@"one.plist"];
        //NSMutableDictionary *dic = [[[NSMutableDictionary alloc]initWithContentsOfFile:dataFile]mutableCopy];
        //读取所有内容
        array_01 = [[NSMutableArray arrayWithContentsOfFile:dataFile_01] mutableCopy];
        [array_01 removeObjectAtIndex:(int)indexPath.row];
        //写入文件
        [array_01 writeToFile:dataFile_01 atomically:YES];
        NSMutableArray *array_03 = [[[NSMutableArray alloc] initWithContentsOfFile:dataFile_01]mutableCopy];
        
        //第二个沙箱，加数据
        // dataFile_02 =[[shaXiang docPath] stringByAppendingPathComponent:@"two.plist"];
        array_02 = [[[NSMutableArray alloc] initWithContentsOfFile:dataFile_02]mutableCopy];
        
        NSDictionary *dic = self.array[indexPath.row];
        [array_02 addObject:dic];
        [array_02 writeToFile:dataFile_02 atomically:YES];
        
        [self.array_02 addObject:dic];
        [self.array removeObjectAtIndex:indexPath.row];
        
        
        //到缓存里面去看，如果有，说明不是第一次。然后在删除。
        NSUserDefaults *as = [NSUserDefaults standardUserDefaults];
        if([as stringForKey:@"text"] ==nil){
            
            NSString *huanCuanFile_01 = [[shaXiang docPath] stringByAppendingPathComponent:@"one.plist"];
            NSMutableArray *huanCuan_01 = [[NSMutableArray arrayWithContentsOfFile:huanCuanFile_01] mutableCopy];
            [huanCuan_01 removeObjectAtIndex:(huanCuan_01.count-1)];
            //写入文件
            [huanCuan_01 writeToFile:huanCuanFile_01 atomically:YES];
            
            [as setObject:@"1" forKey:@"text"];
            //放到磁盘里面
            [as synchronize];
        }
    }else{
        
        //第一个沙箱，加数据
        // dataFile_01=[[shaXiang docPath] stringByAppendingPathComponent:@"one.plist"];
        array_01 = [[[NSMutableArray alloc] initWithContentsOfFile:dataFile_01] mutableCopy];
        
        NSDictionary *dic = self.array_02[indexPath.row];
        [array_01 addObject:dic];
        [array_01 writeToFile:dataFile_01 atomically:YES];
        
        // dataFile_02=[[shaXiang docPath] stringByAppendingPathComponent:@"two.plist"];
        //NSMutableDictionary *dic = [[[NSMutableDictionary alloc]initWithContentsOfFile:dataFile];
        //读取所有内容
        // NSArray* dic = [NSArray dictionaryWithContentsOfFile:dataFile];
        array_02 = [NSMutableArray arrayWithContentsOfFile:dataFile_02];
        [array_02 removeObjectAtIndex:indexPath.row];
        //写入文件
        [array_02 writeToFile:dataFile_02 atomically:YES];
        
        [self.array_02 removeObjectAtIndex:indexPath.row];
        [self.array addObject:dic];
    }
    
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(0, 44);
}

/**
 *  这个是尾巴的距离（如果想隐藏就改成（0，0））
 *
 *  @param collectionView       <#collectionView description#>
 *  @param collectionViewLayout <#collectionViewLayout description#>
 *  @param section              <#section description#>
 *
 *  @return <#return value description#>
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void) doAdd{
//    Path_NSObject *shaXiang = [[Path_NSObject alloc] init];
//    NSString *docPath=[shaXiang docPath];
//    NSLog(@"当前docment路径：\n%@",docPath);
//    
//    NSString *dataFile=[docPath stringByAppendingPathComponent:@"one.plist"];
//    
//    if (YES==[shaXiang isFileNeedCreate:dataFile]) {
//        NSLog(@"文件原先不存在，现已新建空文件！");
//    }else{
//        NSLog(@"文件已存在，无需创建！");
//    }
//    
//    NSMutableArray *plistDic = [[NSMutableArray alloc ] init];
//    // 添加字典
//    [plistDic addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"用款计划",@"text",@"a0",@"image",nil]];
//    [plistDic addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"采购预算",@"text",@"a1",@"image",nil]];
//    [plistDic addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"通知收文",@"text",@"a2",@"image",nil]];
//    [plistDic addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"用款申请",@"text",@"a3",@"image",nil]];
//    [plistDic addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"财政缴款",@"text",@"a4",@"image",nil]];
//    [plistDic addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"市财政收入",@"text",@"a5",@"image",nil]];
//    [plistDic addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"市区收入",@"text",@"a6",@"image",nil]];
//    [plistDic addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"消息",@"text",@"a7",@"image",nil]];
//    [plistDic addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"换一换",@"text",@"a8",@"image",nil]];
//    
//    [plistDic writeToFile:dataFile atomically:YES];//完全覆盖
//    NSLog(@"添加内容完成！！");
//    
//    //添加第二个数据plist
//    NSString *dataFile_02=[docPath stringByAppendingPathComponent:@"two.plist"];
//    NSMutableArray *plistDic_02 = [[NSMutableArray alloc ] init];
//    // 添加字典
//    [plistDic_02 addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"请假审核",@"text",@"a9",@"image",nil]];
//    [plistDic_02 addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"已预公文",@"text",@"a10",@"image",nil]];
//    [plistDic_02 addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"已读公文",@"text",@"a11",@"image",nil]];
//    [plistDic_02 addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"未读通知",@"text",@"a12",@"image",nil]];
//    [plistDic_02 addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"已读通知",@"text",@"a13",@"image",nil]];
//    
//    [plistDic_02 writeToFile:dataFile_02 atomically:YES];//完全覆盖
//    NSLog(@"添加内容完成！！ plistDic_02");
//}
//
///**
// *  读取数据
// */
//-(void) doRead{
//    
//    Path_NSObject *shaXiang = [[Path_NSObject alloc] init];
//    
//    NSString *dataFile=[[shaXiang docPath] stringByAppendingPathComponent:@"one.plist"];
//    
//    //读取所有内容
//    // NSArray* dic = [NSArray dictionaryWithContentsOfFile:dataFile];
//    NSArray *dic = [NSArray arrayWithContentsOfFile:dataFile];
//    
//    
//    NSString *dataFile_02=[[shaXiang docPath] stringByAppendingPathComponent:@"two.plist"];
//    
//    //读取所有内容
//    NSArray *dic_02 = [NSArray arrayWithContentsOfFile:dataFile_02];
//    // NSArray *dic_02 = [NSArray arrayWithContentsOfFile:dataFile_02];
//}
//
///**
// *  修改数据
// */
//-(void) doModify{
//    
//    Path_NSObject *shaXiang = [[Path_NSObject alloc] init];
//    
//    NSString *dataFile=[[shaXiang docPath] stringByAppendingPathComponent:@"one.plist"];
//    NSMutableDictionary *dic = [[[NSMutableDictionary alloc]initWithContentsOfFile:dataFile]mutableCopy];
//    
//    //修改“单条记录”
//    NSString *city = [dic objectForKey:@"recordKey001"];
//    city = @"shanghai-new";
//    [dic setObject:city forKey:@"recordKey001"];
//    //修改“字典记录”
//    NSMutableDictionary *personInfo = [dic objectForKey:@"dicKey001"];
//    NSString *name = [dic objectForKey:@"name"];
//    name = @"Jack-new";
//    [personInfo setValue:name forKey:@"name"];
//    [dic setValue:personInfo forKey:@"dicKey001"];
//    //写入文件
//    [dic writeToFile:dataFile atomically:YES];
//    
//    NSDictionary* dicResult = [NSDictionary dictionaryWithContentsOfFile:dataFile];
//    NSLog(@"修改结果:\n%@",dicResult);
//}
//
///**
// *  删除数据
// */
//-(void) doDelete{
//    
//    Path_NSObject *shaXiang = [[Path_NSObject alloc] init];
//    
//    NSString *dataFile=[[shaXiang docPath] stringByAppendingPathComponent:@"docData.plist"];
//    NSMutableDictionary *dic = [[[NSMutableDictionary alloc]initWithContentsOfFile:dataFile]mutableCopy];
//    //删除“单条记录”
//    [dic removeObjectForKey:@"recordKey001"];
//    [dic removeObjectForKey:@"dicKey001"];
//    //删除“字典记录”
//    
//    //写入文件
//    [dic writeToFile:dataFile atomically:YES];
//    
//    NSDictionary* dicResult = [NSDictionary dictionaryWithContentsOfFile:dataFile];
//    NSLog(@"修改结果:\n%@",dicResult);
//}


- (NSMutableArray *) array{
    Path_NSObject *shaXiang = [[Path_NSObject alloc] init];
    if(nil == _array){
        NSString *dataFile=[[shaXiang docPath] stringByAppendingPathComponent:@"one.plist"];
        _array = [NSMutableArray arrayWithContentsOfFile:dataFile];
        //其实就是把“换一换”删除。不能用迭代
        for (int i = 0; i <_array.count ; i ++) {
            NSDictionary *dic = _array[i];
            if ([dic[@"text"] isEqualToString:@"换一换"]) {
                [_array removeObject:dic];
            }
        }
    }
    return  _array;
}

- (NSMutableArray *)array_02{
    
    Path_NSObject *shaXiang = [[Path_NSObject alloc] init];
    if(nil == _array_02){
        NSString *dataFile=[[shaXiang docPath] stringByAppendingPathComponent:@"two.plist"];
        _array_02 = [NSMutableArray arrayWithContentsOfFile:dataFile];
    }
    return  _array_02;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.delegate) {
        [self.delegate LoveViewController_reloadData];
    }
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
