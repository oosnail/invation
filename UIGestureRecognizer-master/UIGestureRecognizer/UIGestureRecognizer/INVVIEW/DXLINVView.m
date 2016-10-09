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
     UIView       *bordView ;//边界view
     UIButton     *changePicBtn ;//边界view
}
@end

@implementation DXLINVView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self UIInit];
    }
    return self;
}

- (void)setNeedsLayout{

}

- (void)UIInit{
    self.clipsToBounds = YES;
    _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _imageView.userInteractionEnabled = YES;
    [self addSubview:_imageView];
    
    changePicBtn = [[UIButton alloc]init];
    [changePicBtn setImage:[UIImage imageNamed:@"changeBtn"] forState:UIControlStateNormal];
    changePicBtn.bounds = CGRectMake(0, 0, 20, 20);
    changePicBtn.center = _imageView.center;
    changePicBtn.hidden = YES;
    [changePicBtn addTarget:self action:@selector(changePic:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:changePicBtn];

}

- (void)resetWithimage:(UIImage*)image{
    _image = image;
    [_imageView removeFromSuperview];
    _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _imageView.image = image;
    [self addSubview:_imageView];
    [self bringSubviewToFront:changePicBtn];
    [self setInvViewtatus:INVViewtatusNone];
}

- (void)setImage:(UIImage *)image{
    [self resetWithimage:image];
}

- (void)setInvViewtatus:(INVViewtatus)invViewtatus{
    
    if(_invViewtatus == invViewtatus){
        return;
    }
    _invViewtatus = invViewtatus;
    
    if(!bordView){
        CGRect rect = [self.superview convertRect:self.frame toView:self.superview];
        bordView = [[UIView alloc]init];
        bordView.frame =rect;
        bordView.backgroundColor = [UIColor clearColor];
        bordView.userInteractionEnabled = NO;
        [self.superview addSubview:bordView];
    }
    changePicBtn.hidden = YES;

    switch (invViewtatus) {
        case INVViewtatusNone:
        {
            bordView.layer.borderColor = [UIColor clearColor].CGColor;
            bordView.layer.borderWidth = 0.5;
            break;
        }
        case INVViewtatusEdit:
        {
            changePicBtn.hidden = NO;
            bordView.layer.borderColor = [UIColor blueColor].CGColor;
            bordView.layer.borderWidth = 0.5;
            
            break;
        }
        case INVViewtatusChange:
        {
            bordView.layer.borderColor = [UIColor blueColor].CGColor;
            bordView.layer.borderWidth = 0.5;
            break;
        }
        default:
            break;
    }

}

- (void)changePic:(UIButton*)btn{
    if(self.delegate && [_delegate respondsToSelector:@selector(changeBtnClick:)]){
        [self.delegate changeBtnClick:self];
    }
}

@end
