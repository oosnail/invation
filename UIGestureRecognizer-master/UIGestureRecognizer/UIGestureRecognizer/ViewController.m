//
//  ViewController.m
//  UIGestureRecognizer
//
//  Created by  ztc on 16/4/20.
//  Copyright © 2016年 ztc. All rights reserved.
//

#import "ViewController.h"
#import "DXLINVView.h"
#import "DXLINVManage.h"
@interface ViewController ()<DXLINVManageDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
//@property(nonatomic,strong)DXLINVView* imageView;
@property (strong, nonatomic) UIAlertController *actionSheet;
@property (strong, nonatomic) DXLINVView *chooseINView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];    
    DXLINVView *imageView=[[DXLINVView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    imageView.backgroundColor = [UIColor redColor];
    imageView.image = [UIImage imageNamed:@"dog"];
    [self.view addSubview:imageView];
    
    DXLINVView *imageView1=[[DXLINVView alloc]initWithFrame:CGRectMake(100, 400, 200, 200)];
    imageView1.backgroundColor = [UIColor redColor];
    imageView1.image = [UIImage imageNamed:@"cat"];
    [self.view addSubview:imageView1];
    
    DXLINVManage * manage = [[DXLINVManage alloc]init];
    manage.backgroundColor = [UIColor redColor];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:@[imageView,imageView1]];
    [manage setInvViews:arr];
    [self.view addSubview:manage];
    manage.delegate = self;
}


- (void)changeImageClick:(DXLINVView*)invView{
    NSLog(@"修改图片");
    self.chooseINView = invView;
    [self callActionSheetFunc];

}

/**
 @ 调用ActionSheet
 */
- (void)callActionSheetFunc{
    self.actionSheet = [UIAlertController alertControllerWithTitle:@"选择图像" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"使用相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self actionSheetClick:0];
    }];
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"使用相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self actionSheetClick:1];
    }];
    UIAlertAction * act3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];

    [self.actionSheet addAction:act1];
    [self.actionSheet addAction:act2];
    [self.actionSheet addAction:act3];


    [self presentViewController: self.actionSheet animated:YES completion:nil];
}

- (void)actionSheetClick:(int)actionIndex{
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    switch (actionIndex) {
        case 0:
            //来源:相机
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            //来源:相册
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 2:
            return;
    }
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.chooseINView resetWithimage:image];
//    self.headImage.image = image;
}

@end
