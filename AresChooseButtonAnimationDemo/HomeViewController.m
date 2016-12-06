//
//  HomeViewController.m
//  AresChooseButtonAnimationDemo
//
//  Created by Admin on 16/12/6.
//  Copyright © 2016年 AresBegin. All rights reserved.
//

#import "HomeViewController.h"

#import "Path_NSObject.h"
#import "HomeBean.h"

#import "LoveViewController.h"
#import "HomeCollectionViewCell.h"

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollisionBehaviorDelegate,UINavigationBarDelegate,LoveViewController_reloadData>
@property (weak, nonatomic) IBOutlet UICollectionView *huangYiHuang;//换一换功能
//@property (nonatomic,assign) int renwu ;
@property (nonatomic,strong) NSMutableArray *array;

@end

 static NSString *CellIdentifier = @"CollectionCell";
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.huangYiHuang.backgroundColor = [UIColor whiteColor];
    //自动布局，自己定义的高度
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //代理
    self.huangYiHuang.delegate = self;
    self.huangYiHuang.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.huangYiHuang reloadData];
}

#pragma mark ColllectionView delegate && datasource 

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *dic = self.array[indexPath.row];
    HomeBean *homeBean = [HomeBean homeBeanWithDict:dic];
    cell.homeBean = homeBean;//在cell里面已经封装
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
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

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(30, 10, 10, 10);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    int a = (int)indexPath.row;
    NSDictionary *dic = self.array[a];
    NSString *string_dic_text = dic[@"text"];
    if([string_dic_text isEqualToString:@"换一换"]){
        [self performSegueWithIdentifier:@"loveCollection" sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSString *string_segue = segue.identifier;
    
    if ([string_segue isEqualToString:@"loveCollection"]) {
        LoveViewController *tr = segue.destinationViewController;
        tr.delegate = self;
    }
}

- (void)LoveViewController_reloadData{
    _array = nil;
    [self array];
    [self.huangYiHuang reloadData];

}


#pragma mark -- LoveViewController的代理方法

- (void) reloadData_HomeArray:(NSMutableArray *)array{
    _array = array;
    //没有时，只有“换一换”
    if (_array.count == 0) {
        NSDictionary *dic_01 = [NSDictionary dictionaryWithObjectsAndKeys:@"换一换",@"text",@"a16",@"image", nil];
        self.array[0] = dic_01;
    }else{
        //其实就是把“换一换”删除。不能用迭代
        for (int i = 0; i <_array.count ; i ++) {
            NSDictionary *dic = _array[i];
            if ([dic[@"text"] isEqualToString:@"换一换"]) {
                [self.array removeObject:dic];
            }
        }
        //其实就是把“换一换”删除。不能用迭代
        NSDictionary *dic_01 = [NSDictionary dictionaryWithObjectsAndKeys:@"换一换",@"text",@"a16",@"image", nil];
        //self.array[0] = dic_01;
        [self.array addObject:dic_01];
    }
    [self.huangYiHuang reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSMutableArray *)array{
    if(_array == nil){
         Path_NSObject * shaXiang = [[Path_NSObject alloc] init];
        NSString *dataFile=[[shaXiang docPath] stringByAppendingPathComponent:@"one.plist"];
        _array = [NSMutableArray arrayWithContentsOfFile:dataFile];
        
        //其实就是把“换一换”删除。不能用迭代
        for (int i = 0; i <_array.count ; i ++) {
            
            NSDictionary *dic = _array[i];
            
            if ([dic[@"text"] isEqualToString:@"换一换"]) {
                
                [self.array removeObject:dic];
                
                int a = (int)[_array count];
                self.array[a] = dic;
            }else{
                int a = (int)[_array count];
                NSDictionary *dic_01 = [NSDictionary dictionaryWithObjectsAndKeys:@"换一换",@"text",@"a16",@"image", nil];
                self.array[a] = dic_01;
            }
        }
    }
    return _array;
}


@end
