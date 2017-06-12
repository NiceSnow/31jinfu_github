//
//  ToolsHelper.m
//  31jinfu
//
//  Created by 刘厚宽 on 2017/5/5.
//  Copyright © 2017年 刘厚宽. All rights reserved.
//

#import "ToolsHelper.h"

@implementation ToolsHelper


+ (UIImage *)getImage:(NSString *)name size:(CGSize)size font:(UIFont *)font  backgroundColor:(UIColor *)color textColor:(UIColor *)textColor
{
    CGRect rect = (CGRect){CGPointZero,size};
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *headerimg = [self imageToAddText:img withText:name font:font textColor:textColor];
    return headerimg;
}

//随机颜色
+ (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

//把文字绘制到图片上
+ (UIImage *)imageToAddText:(UIImage *)img withText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor
{
    CGFloat width = img.size.width;
    
    CGFloat height = img.size.height;
    
    CGRect rect = CGRectMake(0,0, width, height);

    //1.获取上下文
    UIGraphicsBeginImageContextWithOptions(img.size,NO,0.0);
    //2.绘制图片
     [img drawAtPoint:CGPointMake(0.0,0.0)];
    //3.绘制文字


    
    //计算文字所占的size,文字居中显示在画布上
    
    CGSize sizeText =[text boundingRectWithSize:rect.size options:NSStringDrawingUsesLineFragmentOrigin
                     
                                     attributes:@{
                                                  NSFontAttributeName:font,
                                                  NSForegroundColorAttributeName:textColor
                                                  } context:nil].size;

    CGRect textRect = CGRectMake(25,(height-sizeText.height)/2, sizeText.width, sizeText.height);
    
    //将文字绘制上去
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentLeft;
    style.lineBreakMode = NSLineBreakByCharWrapping;
    [text drawInRect:textRect withAttributes:@{
                                               NSFontAttributeName:font,
                                               NSParagraphStyleAttributeName:style,
                                               NSForegroundColorAttributeName:textColor
                                               }];
    //4.获取绘制到得图片
    UIImage *watermarkImg = UIGraphicsGetImageFromCurrentImageContext();
    //5.结束图片的绘制
    UIGraphicsEndImageContext();
    
    return watermarkImg;
}
+ (UIImage *) ImageWithColor: (UIColor *) color frame:(CGRect)aFrame
{
    aFrame = CGRectMake(0, 0, aFrame.size.width, aFrame.size.height);
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, aFrame);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}
@end
