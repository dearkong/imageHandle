//
//  UIImage+KHandle.m
//  UIImageHandle
//
//  Created by cheyipai.com on 16/12/21.
//  Copyright © 2016年 kong. All rights reserved.
//

#import "UIImage+KHandle.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIImage (KHandle)
+ (UIImage *)captureView:(UIView *)targetView {

    //获取目标UIView所在的区域
    CGRect rect = targetView.frame;
    //开始绘图
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //调用CALayer的方法将当前控件绘制到绘图ctx中
    [targetView.layer renderInContext:ctx];
    //获取该绘图ctx中的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();\
    UIGraphicsEndImageContext();
    return newImage;
    
}
+ (UIImage *)captureScreen {
    
    UIWindow*screenWindow = [[UIApplication sharedApplication]keyWindow];
    return [self captureView:screenWindow];

}
- (UIImage *)imageAtRect:(CGRect)rect {

    //获取UIImage图片对应的CGImageRef对象
    CGImageRef srcImage = [self CGImage];
    //从srcImage中挖取rect区域
    CGImageRef imageRef = CGImageCreateWithImageInRect(srcImage, rect);
    //将挖取到的CGImageRef转化为UIImage对象
    UIImage *subImage = [UIImage imageWithCGImage:imageRef];
    return subImage;

}
- (UIImage *)imageByScalingAspectToMinSize:(CGSize)targetSize {

    //获取源图片的宽和高
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    //获取图片缩放目标大小的宽和高
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    //定义图片缩放后的宽度
    CGFloat scaledWidth = targetWidth;
    //定义图片缩放后的高度
    CGFloat scaledHeight = targetHeight;
    CGPoint anchorPoint = CGPointZero;
    //如果源图片的大小于缩放的目标大小不相等
    if (!CGSizeEqualToSize(imageSize, targetSize)) {
        
        //计算水平方向上的缩放因子
        CGFloat xFactor = targetHeight/width;
        //计算垂直方向上的缩放因子
        CGFloat yFactor = targetHeight/height;
        //定义缩放因子scaleFactor为两个缩放因子中较大的一个
        CGFloat scaleFactor = xFactor>yFactor?xFactor:yFactor;
        //根据缩放因子计算图片缩放后的高度和宽度
        scaledWidth = width* scaleFactor;
        scaledHeight = height *scaleFactor;
        //如果横向上的缩放因子大于纵向上的缩放因子，那么图片在纵向上需要裁剪
        if (xFactor>yFactor) {
            anchorPoint.y = (targetHeight - scaledHeight)/2.0;
        }else if (xFactor < yFactor) {
        
            anchorPoint.x = (targetWidth - scaledWidth)/2.0;
        
        
        }
        
    }
    //开始绘图
    UIGraphicsBeginImageContext(targetSize);
    //定义图片缩放后的区域
    CGRect anchorRect = CGRectZero;
    anchorRect.origin = anchorPoint;
    anchorRect.size.width = scaledWidth;
    anchorRect.size.height = scaledHeight;
    //将图片本身绘制到anchorRect区域中
    [self drawInRect:anchorRect];
    
    //获取绘制后生成的新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (UIImage *)imageByScalingAspectToMaxSize:(CGSize)targetSize {

    //获取源图片的宽和高
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    //获取图片缩放目标大小的宽和高
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    //定义图片缩放后的宽度
    CGFloat scaledWidth = targetWidth;
    //定义图片缩放后的高度
    CGFloat scaledHeight = targetHeight;
    CGPoint anchorPoint = CGPointZero;
    //如果源图片的大小于缩放的目标大小不相等
    if (!CGSizeEqualToSize(imageSize, targetSize)) {
        
        //计算水平方向上的缩放因子
        CGFloat xFactor = targetHeight/width;
        //计算垂直方向上的缩放因子
        CGFloat yFactor = targetHeight/height;
        //定义缩放因子scaleFactor为两个缩放因子中较小的一个
        CGFloat scaleFactor = xFactor<yFactor?xFactor:yFactor;
        //根据缩放因子计算图片缩放后的高度和宽度
        scaledWidth = width* scaleFactor;
        scaledHeight = height *scaleFactor;
        //如果横向上的缩放因子小于纵向上的缩放因子，那么图片上下留空白
        if (xFactor<yFactor) {
            anchorPoint.y = (targetHeight - scaledHeight)/2.0;
        }else if (xFactor > yFactor) {
            
            anchorPoint.x = (targetWidth - scaledWidth)/2.0;
            
            
        }
        
    }
    //开始绘图
    UIGraphicsBeginImageContext(targetSize);
    //定义图片缩放后的区域
    CGRect anchorRect = CGRectZero;
    anchorRect.origin = anchorPoint;
    anchorRect.size.width = scaledWidth;
    anchorRect.size.height = scaledHeight;
    //将图片本身绘制到anchorRect区域中
    [self drawInRect:anchorRect];
    
    //获取绘制后生成的新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;

}
//不保持图片缩放比
- (UIImage *)imageByScalingToSize:(CGSize)targetSize {
    
    //开始绘图
    UIGraphicsBeginImageContext(targetSize);
    //定义图片缩放后的区域，无需保持纵横比，所以直接缩放
    CGRect anchorRect = CGRectZero;
    anchorRect.origin = CGPointZero;
    anchorRect.size = targetSize;
    [self drawInRect:anchorRect];
    //获取绘制后生成的新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;

}
//图片旋转角度
- (UIImage *)imageRotatedByRadians:(CGFloat)radians {

    //定义一个执行旋转的CGAffineTransform结构体
    CGAffineTransform t = CGAffineTransformMakeRotation(radians);
    //对图片的原始区域执行旋转，获取旋转后的区域
    CGRect rotateRect = CGRectApplyAffineTransform(CGRectMake(0, 0, self.size.width, self.size.height), t);
    //获取图片旋转后的大小
    CGSize rotatedSize = rotateRect.size;
    //创建绘制位图的上下文
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //指定坐标变换，将坐标中心平移到图片中心
    CGContextTranslateCTM(ctx, rotatedSize.width/2.0, rotatedSize.height/2.0);
    //执行坐标变换，旋转过radians弧度
    CGContextRotateCTM(ctx, radians);
    //执行坐标变换，执行缩放
    CGContextScaleCTM(ctx, 1.0, -1.0);
    //绘制图片
    CGContextDrawImage(ctx, CGRectMake(-self.size.width/2.0, -self.size.height/2.0, self.size.width, self.size.height), self.CGImage);
    //获取绘制后生成的新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees {

    return [self imageRotatedByRadians:degrees*M_PI/180.0];
}
- (void)saveToDocuments:(NSString *)fileName {

    //获取当前应用路径中Documents目录下的指定文件名对应的文件路径
    
    NSString*path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:fileName];
    //保存PNG图片
    [UIImagePNGRepresentation(self) writeToFile:path atomically:YES];
    


}
@end
