//
//  ViewController.m
//  UIGestureRecognizer
//
//  Created by  江苏 on 16/4/20.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import "DXLINVView.h"
@interface ViewController ()<UIGestureRecognizerDelegate>
//@property(nonatomic,strong)DXLINVView* imageView;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];    
    DXLINVView *imageView=[[DXLINVView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    
    DXLINVView *imageView1=[[DXLINVView alloc]initWithFrame:CGRectMake(100, 400, 200, 200)];
    imageView1.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView1];
}

@end
