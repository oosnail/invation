//
//  DXLINVManage.h
//  UIGestureRecognizer
//
//  Created by ztc on 16/10/8.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DXLINVView.h"



@class snapShotView;

@protocol DXLINVManageDelegate
@optional
- (void)changeImageClick:(DXLINVView*)invView;
@end

@interface DXLINVManage : UIView

@property(nonatomic,strong)NSMutableArray *invViews;

@property(nonatomic,strong) snapShotView * snapshot;

@property(nonatomic,weak)NSObject<DXLINVManageDelegate> *delegate;

@end

//复制的view
@interface snapShotView : UIImageView
//复制的源view
@property (nonatomic,strong)UIView *parentView;
@end
