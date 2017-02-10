//
//  ViewController.m
//  UIImageHandle
//
//  Created by cheyipai.com on 16/12/21.
//  Copyright © 2016年 kong. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+KHandle.h"
@interface ViewController () {

    UIImage *rawImage;


}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    //获取原始的UIImage对象
    rawImage = [UIImage imageNamed:@"CYP_ComplaintsSuccess.png"];
    NSLog(@"%@",NSStringFromCGSize(rawImage.size));
    
    //原图
    UIImageView *imageView = [[UIImageView alloc] initWithImage:rawImage];
    imageView.frame = CGRectMake(0, 0, rawImage.size.width, rawImage.size.height);
    imageView.center = CGPointMake(100, 300);
    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 62, 52)];
     imageView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageView1];
    [imageView1 setImage:[rawImage imageRotatedByDegrees:30]];
   
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 30, 100, 100)];
    imageView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageView2];
    [imageView2  setImage:[rawImage imageByScalingToSize:imageView2.frame.size]];
    
    
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(220, 30, 100, 100)];
    imageView3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageView3];
    [imageView3  setImage:[rawImage imageByScalingAspectToMaxSize:imageView3.frame.size]];
    
    
    
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 200, 20, 20)];
    imageView4.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageView4];
    [imageView4  setImage:[rawImage imageAtRect:CGRectMake(20, 20, 20, 20)]];
    
    
    
    UIImageView *imageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(220, 170, 100, 100)];
    imageView5.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageView5];
    [imageView5  setImage:[rawImage imageByScalingAspectToMinSize:imageView5.frame.size]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
