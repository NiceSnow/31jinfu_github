//
//  DefineClass.h
//  YLHospital_2.0
//
//  Created by AMed on 15/11/12.
//  Copyright © 2015年 博睿精实. All rights reserved.
//

#ifndef DefineClass_h
#define DefineClass_h




#endif /* DefineClass_h */

#define DOCPATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo.plist"]
//测试
//#define testWithURL(url) [@"http://test.api.drresource.com/v1/" stringByAppendingString:url]
//生产
#define testWithURL(url) [@"http://api.drresource.com/v1/" stringByAppendingString:url]



#define systemValue [[[UIDevice currentDevice] systemVersion] floatValue]
#define selfHeight   self.frame.size.height
#define selfWidth    self.frame.size.width

#define screenWidth  [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenBounds [UIScreen mainScreen].bounds

#define kDocumentsPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
#define versionKey  (NSString *)kCFBundleVersionKey
#define oldVersion [[NSUserDefaults standardUserDefaults] objectForKey:versionKey]
#define newVersion [NSBundle mainBundle].infoDictionary[versionKey]
#define showNewFeature  ![oldVersion isEqualToString:newVersion]
#define UserDefault [NSUserDefaults standardUserDefaults]
#define WS(weakSelf)     __weak typeof(self) weakSelf = self;

#define HeaderImage [kDocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[UserHelper instance].UID]]
#define headerURL @"headerURL"


#define UserInfo @"userInfo"
#define UserID @"uid"

#define UICOLOR_RGB_Alpha(_color,_alpha) [UIColor colorWithRed:((_color>>16)&0xff)/255.0f green:((_color>>8)&0xff)/255.0f blue:(_color&0xff)/255.0f alpha:_alpha]

#define kRedColor       UICOLOR_RGB_Alpha(0xd81e06,1)
#define kGrayColor      UICOLOR_RGB_Alpha(0xdbdbdb,1)
#define kYellowColor    UICOLOR_RGB_Alpha(0xf4c900,1)

#define openScreen [[UIApplication sharedApplication] setIdleTimerDisabled:YES]
#define closeScreen [[UIApplication sharedApplication] setIdleTimerDisabled:NO]

typedef enum : NSUInteger {
    kCollectionViewMain,//首页
    kCollectionViewAcssets,//资产
    kCollectionViewMine,//个人中心
} kCollectionViewType;


