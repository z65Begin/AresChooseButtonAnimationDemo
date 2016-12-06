//
//  HomeCollectionViewCell.h
//  AresChooseButtonAnimationDemo
//
//  Created by Admin on 16/12/6.
//  Copyright © 2016年 AresBegin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeBean;
@interface HomeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image_Height;//图片高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageView_Width;//图片宽度

@property (weak, nonatomic) IBOutlet UIImageView *imageView_Cell;//图片
@property (weak, nonatomic) IBOutlet UILabel *text_Label;//字体

@property (nonatomic,strong)HomeBean *homeBean;
@end
