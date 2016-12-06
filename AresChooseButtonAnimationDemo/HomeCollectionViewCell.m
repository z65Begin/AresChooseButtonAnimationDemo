//
//  HomeCollectionViewCell.m
//  AresChooseButtonAnimationDemo
//
//  Created by Admin on 16/12/6.
//  Copyright © 2016年 AresBegin. All rights reserved.
//

#import "HomeCollectionViewCell.h"

#import "HomeBean.h"

@implementation HomeCollectionViewCell

- (void)setHomeBean:(HomeBean *)homeBean{
    
    _homeBean = homeBean;
    
    [self addCellHomeBean:homeBean];
}

/**
 *  添加数据，修改cell
 */
- (void)addCellHomeBean:(HomeBean *)homeBean{
    NSString *image = homeBean.image;
    NSString *text = homeBean.text;
    self.imageView_Cell.image = [UIImage imageNamed:image];
    self.text_Label.text = text;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.height;
    
    int width_int = (int) width;
    
    if(480 == width_int){
        
        self.imageView_Width.constant = 46;
        self.image_Height.constant = 48;
    }
}


@end
