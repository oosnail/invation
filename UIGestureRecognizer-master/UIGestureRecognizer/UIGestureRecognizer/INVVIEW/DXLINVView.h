//
//  DXLINVView.h
//  UIGestureRecognizer
//
//  Created by ztc on 16/10/5.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class DXLINVView;
@protocol DXLINVViewDelegate
@optional
- (void)changeBtnClick:(DXLINVView*)invView;
@end

typedef NS_ENUM (int,INVViewtatus) {
    INVViewtatusNone,//没有状态
    INVViewtatusEdit,//编辑状态
    INVViewtatusChange,//可替换
};

@interface DXLINVView : UIView
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImage *image;

@property(nonatomic,assign)INVViewtatus invViewtatus;
@property(nonatomic,weak)NSObject<DXLINVViewDelegate> *delegate;
- (void)resetWithimage:(UIImage*)image;
@end

