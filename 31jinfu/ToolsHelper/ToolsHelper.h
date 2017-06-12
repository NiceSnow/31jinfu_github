//
//  ToolsHelper.h
//  31jinfu
//
//  Created by 刘厚宽 on 2017/5/5.
//  Copyright © 2017年 刘厚宽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefineClass.h"

@interface ToolsHelper : NSObject

//根据文字生成 文字图片
+ (UIImage *)getImage:(NSString *)name size:(CGSize)size font:(UIFont *)font  backgroundColor:(UIColor *)color textColor:(UIColor *)textColor;
//随机颜色
+ (UIColor *)randomColor;
//把文字绘制到图片上
+ (UIImage *)imageToAddText:(UIImage *)img withText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;

//根据UIColor生成图片
+ (UIImage *) ImageWithColor: (UIColor *) color frame:(CGRect)aFrame;
@end
