//
//  DXLINVView.m
//  UIGestureRecognizer
//
//  Created by ztc on 16/10/5.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "DXLINVView.h"

@interface DXLINVView()<UIGestureRecognizerDelegate>
{
     UIView       *snapshot ;

}
@end

@implementation DXLINVView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self UIInit];
        [self addGesture];
       
    }
    return self;
}

- (void)UIInit{
    self.clipsToBounds = YES;
    
    _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _imageView.image = [UIImage imageNamed:@"IMG_2388"];
    _imageView.userInteractionEnabled = YES;
    [self addSubview:_imageView];
}

- (void)addGesture{
    //点击手势
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.delegate=self;
    [self.imageView addGestureRecognizer:tap];
    
    //拖动手势
    UIPanGestureRecognizer* pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    pan.delegate=self;
    [self.imageView addGestureRecognizer:pan];
    
    //捏合手势
    UIPinchGestureRecognizer* pinch=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    pinch.delegate=self;
    [self addGestureRecognizer:pinch];
    
    //旋转手势
    UIRotationGestureRecognizer* rotate=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotate:)];
    rotate.delegate=self;
    [self.imageView addGestureRecognizer:rotate];
    
    //轻扫手势
    UISwipeGestureRecognizer* swipeDefault=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDefault:)];
    swipeDefault.delegate=self;
    swipeDefault.direction=UISwipeGestureRecognizerDirectionRight;
    [self.imageView addGestureRecognizer:swipeDefault];
    
    UISwipeGestureRecognizer* swipeLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDefault:)];
    swipeLeft.delegate=self;
    swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.imageView addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer* swipeDown=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDefault:)];
    swipeDown.delegate=self;
    swipeDown.direction=UISwipeGestureRecognizerDirectionDown;
    [self.imageView addGestureRecognizer:swipeDown];
    
    UISwipeGestureRecognizer* swipeUp=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDefault:)];
    swipeUp.delegate=self;
    swipeUp.direction=UISwipeGestureRecognizerDirectionUp;
    [self.imageView addGestureRecognizer:swipeUp];
    
    //长按手势
    UILongPressGestureRecognizer* longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longPress.delegate=self;
    [self.imageView addGestureRecognizer:longPress];

}

-(void)longPress:(UILongPressGestureRecognizer *)longPress{
    //按住的时候回调用一次，松开的时候还会再调用一次
    NSLog(@"长按图片");
    UIGestureRecognizerState state = longPress.state;
    CGPoint location = [longPress locationInView:self.superview];
    switch (state) {
        case UIGestureRecognizerStatePossible: {

            break;
        }
        case UIGestureRecognizerStateBegan: {
            snapshot = [self customSnapshoFromView:self.imageView];
            [self.superview addSubview:snapshot];
            snapshot.bounds = self.imageView.bounds;
            snapshot.center = location;
            
            snapshot.alpha = 1.0;
            // 按下的瞬间执行动画
            [UIView animateWithDuration:0.25 animations:^{
                //                center.y = location.y;
                //                snapshot.center = center;
                //                snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                //                snapshot.alpha = 0.98;
                //                cell.alpha = 0.0;
                
            } completion:^(BOOL finished) {
                
                //                cell.hidden = YES;
                
            }];

            break;
        }
        case UIGestureRecognizerStateChanged: {
            snapshot.center = location;
            break;
        }
        case UIGestureRecognizerStateEnded: {
            [snapshot removeFromSuperview];
            snapshot = nil;
            break;
        }
        case UIGestureRecognizerStateCancelled: {
            [snapshot removeFromSuperview];
            snapshot = nil;
            break;
        }
        case UIGestureRecognizerStateFailed: {
            [snapshot removeFromSuperview];
            snapshot = nil;
            break;
        }
    }

}

-(void)swipeDefault:(UISwipeGestureRecognizer*)swipe{
    if (swipe.direction==UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"向右轻扫");
    }else if(swipe.direction==UISwipeGestureRecognizerDirectionLeft){
        NSLog(@"向左轻扫");
    }else if(swipe.direction==UISwipeGestureRecognizerDirectionUp){
        NSLog(@"向上轻扫");
    }else{
        NSLog(@"向下轻扫");
    }
}

-(void)rotate:(UIRotationGestureRecognizer*)rotate{
    
    self.imageView.transform=CGAffineTransformRotate(self.imageView.transform, rotate.rotation);
    //复位
    rotate.rotation=0;
}

-(void)pinch:(UIPinchGestureRecognizer*)pinch{
    CGFloat scale=pinch.scale;
    
    self.imageView.transform=CGAffineTransformScale(self.imageView.transform, scale, scale);
    
    pinch.scale=1;
}

-(void)pan:(UIPanGestureRecognizer*)pan{
    //    CGPoint transP=[pan locationInView:self.view];
    //    self.center=transP;
    //如果出现复制对象。原view不发生任何变化
    if(snapshot){
        return;
    }
    CGPoint transP=[pan translationInView:self];
    
    self.imageView.transform=CGAffineTransformTranslate(self.imageView.transform, transP.x, transP.y);
    
    [pan setTranslation:CGPointZero inView:self];
    
}

-(void)tap:(UITapGestureRecognizer*)tap{
    NSLog(@"点击了图片");
}

//允许多事件同时发生
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return  YES;
}

- (UIView *)customSnapshoFromView:(UIView *)inputView {
    // 用cell的图层生成UIImage，方便一会显示
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 自定义这个快照的样子（下面的一些参数可以自己随意设置）
    UIView * snapview = [[UIImageView alloc] initWithImage:image];
    snapview.layer.masksToBounds = NO;
    snapview.layer.cornerRadius = 0.0;
    snapview.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapview.layer.shadowRadius = 5.0;
    snapview.layer.shadowOpacity = 0.4;
    return snapview;
}

@end
