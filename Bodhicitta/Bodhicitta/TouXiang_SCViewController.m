//
//  TouXiang_SCViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/7/9.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "TouXiang_SCViewController.h"


@interface TouXiang_SCViewController ()

@end

@implementation TouXiang_SCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 70)];
    view.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"顶部导航背景"]];
    [self.view addSubview:view];
    //    UIImageView *
    UILabel * title=[[UILabel alloc]initWithFrame:CGRectMake(135, 30, 120, 30)];
    title.text=@"上传圈头像";
    title.font=[UIFont systemFontOfSize:20];
    title.textColor=[UIColor whiteColor];
    [view addSubview:title];
    
    fanhuiBt=[[UIButton alloc]initWithFrame:CGRectMake(6, 33, 25, 25)];
    [fanhuiBt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [fanhuiBt addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhuiBt];
    
    tijiaoBt=[[UIButton alloc]initWithFrame:CGRectMake(285, 33, 100, 25)];
    [tijiaoBt setTitle:@"提交" forState:UIControlStateNormal];
    [tijiaoBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tijiaoBt addTarget:self action:@selector(tijiaoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tijiaoBt];
    
    UIView * background=[[UIView alloc]initWithFrame:CGRectMake(0, 70, 380, self.view.frame.size.height)];
    background.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self.view addSubview:background];
    
    UIImageView * bgIv=[[UIImageView alloc]initWithFrame:CGRectMake(5, 30, 355, 190)];
    bgIv.image=[UIImage imageNamed:@"make_circle_name"];
    [background addSubview:bgIv];
    
    touxiangIv=[[UIImageView alloc]initWithFrame:CGRectMake(155, 100, 50, 50)];
    touxiangIv.image=[UIImage imageNamed:@"circle_photo_default"];
    touxiangIv.layer.masksToBounds = YES;
    touxiangIv.layer.cornerRadius = 25;
    [background addSubview:touxiangIv];
    
    UILabel * tishiLa=[[UILabel alloc]initWithFrame:CGRectMake(100, 210, 200, 20)];
    tishiLa.text=@"上传精美头像和圈友分享";
    tishiLa.font=[UIFont systemFontOfSize:16];
    tishiLa.textColor=[UIColor grayColor];
    [background addSubview:tishiLa];
    
    shangchuanBt=[[UIButton alloc]initWithFrame:CGRectMake(25, 275, 320, 50)];
    [shangchuanBt setBackgroundImage:[UIImage imageNamed:@"pay_nornal"] forState:UIControlStateNormal];
    [shangchuanBt setTitle:@"上传头像" forState:UIControlStateNormal];
    [shangchuanBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shangchuanBt addTarget:self action:@selector(shangchuanButton) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:shangchuanBt];
    
}
-(void)backclick{
    
    [self.sideMenuViewController
     setContentViewController:[[TouXiang_GXViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
}
-(void)tijiaoClick{
   
    [self.sideMenuViewController
     setContentViewController:[[ShanYou_DTViewController alloc] init]animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
-(void)shangchuanButton{

    UIActionSheet * sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相机", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if( buttonIndex ==0){
        
        //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
        [shangchuanBt setTitle:@"修改头像" forState:UIControlStateNormal];
    }else if( buttonIndex ==1){
        
        
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            
        }
        pickerImage.delegate = self;
        pickerImage.allowsEditing = NO;
        [self presentModalViewController:pickerImage animated:YES];
        
        [shangchuanBt setTitle:@"修改头像" forState:UIControlStateNormal];
    }

}
- (void) imagePickerController:(UIImagePickerController *)picker    didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [touxiangIv setImage:image];
    
   
    [picker dismissModalViewControllerAnimated:YES];
}

-(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
