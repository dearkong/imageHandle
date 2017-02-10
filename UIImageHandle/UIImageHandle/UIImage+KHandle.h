//
//  UIImage+KHandle.h
//  UIImageHandle
//
//  Created by cheyipai.com on 16/12/21.
//  Copyright © 2016年 kong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KHandle)
/**
* 对指定的UI控件进行截图
*/
+ (UIImage *)captureView:(UIView *)targetView;
/**
 * 截屏
 */
+ (UIImage *)captureScreen;
/**
 * 挖取图片的指定区域
 */
- (UIImage *)imageAtRect:(CGRect)rect;
/**
 *保持图片纵横比缩放，最短边缩放后必须匹配targetSize的大小,长边截取
 */
- (UIImage *)imageByScalingAspectToMinSize:(CGSize)targetSize;
/**
 *保持图片纵横比缩放，最短长边缩放后必须匹配targetSize的大小,短边留白
 */
- (UIImage *)imageByScalingAspectToMaxSize:(CGSize)targetSize;
/**
 * 不保持图片的纵横比缩放
 */
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
/**
 * 对图片按弧度执行旋转
 */
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
/**
 * 对图片按角度执行旋转
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
/**
 *保存图片
 */
- (void)saveToDocuments:(NSString *)fileName;

@end
