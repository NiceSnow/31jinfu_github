//
//  CustomColloctionView.h
//  31jinfu
//
//  Created by 刘厚宽 on 2017/5/5.
//  Copyright © 2017年 刘厚宽. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomColloctionView;

@protocol CustomCollectionViewDelegate <NSObject>

- (void)customCollectionView:(CustomColloctionView *)collection indexPath:(NSIndexPath *)indexPath;

@end

typedef void(^CustomCollectionViewBlock)(CustomColloctionView *collection,NSIndexPath *indexPath);

@interface CustomColloctionView : UIView

- (instancetype)initWithFrame:(CGRect)frame  Type:(kCollectionViewType)type;


@property (nonatomic)id<CustomCollectionViewDelegate>delegate;

@property (nonatomic, copy)CustomCollectionViewBlock cBlock;


@end
