//
//  LoveViewController.h
//  AresChooseButtonAnimationDemo
//
//  Created by Admin on 16/12/6.
//  Copyright © 2016年 AresBegin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoveViewController_reloadData <NSObject>

- (void)LoveViewController_reloadData;

@end

@interface LoveViewController : UICollectionViewController
@property (nonatomic, weak) id<LoveViewController_reloadData> delegate;

@end
