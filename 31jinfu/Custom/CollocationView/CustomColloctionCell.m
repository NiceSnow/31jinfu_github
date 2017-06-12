//
//  CustomColloctionCell.m
//  31jinfu
//
//  Created by 刘厚宽 on 2017/5/5.
//  Copyright © 2017年 刘厚宽. All rights reserved.
//

#import "CustomColloctionCell.h"
//#import ""
@interface CustomColloctionCell   ()
@property(nonatomic,retain) UIImageView* imageView;
@property(nonatomic,retain) UILabel* titleLabel;
@end
@implementation CustomColloctionCell
+ (instancetype)creatCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"CustomColloctionCell";
    CustomColloctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sizeToFit];
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.mas_equalTo(-10);
        }];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(_titleLabel.mas_top).offset(-10);
        }];
    }
    return self;
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(void)setImageStr:(NSString*)image titleStr:(NSString*)title type:(kCollectionViewType)type
{
   
    _imageView.image = [UIImage imageNamed:image];
    _titleLabel.text = title;
    switch (type) {
        case kCollectionViewMain:
        {
            _titleLabel.textColor = kGrayColor;
        }
            break;
        case kCollectionViewAcssets:
        {
            _titleLabel.textColor = [UIColor blackColor];
        }
            break;
        case kCollectionViewMine:
        {
            _titleLabel.textColor = kRedColor;

        }
            break;
        default:
            break;
    }
}

@end
