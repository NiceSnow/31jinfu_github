//
//  CustomColloctionView.m
//  31jinfu
//
//  Created by 刘厚宽 on 2017/5/5.
//  Copyright © 2017年 刘厚宽. All rights reserved.
//

#import "CustomColloctionView.h"
#import "CustomColloctionCell.h"

@interface CustomColloctionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    kCollectionViewType tempType;
}
@property(nonatomic,retain) UICollectionView* collectionView;
@property(nonatomic,retain) NSMutableArray* imageArray;
@property(nonatomic,retain) NSMutableArray* titleArray;
@end
@implementation CustomColloctionView
- (instancetype)initWithFrame:(CGRect)frame Type:(kCollectionViewType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        self.backgroundColor = [UIColor whiteColor];
        tempType = type;
        switch (type) {
            case kCollectionViewMain:
            {
                _imageArray = [@[@"recharge",@"withdrawal",@"gift",@"record",@"vouchers"] mutableCopy];
                _titleArray = [@[@"充值",@"提现",@"邀请有礼",@"投资记录",@"优惠券"] mutableCopy];
            }
                break;
            case kCollectionViewAcssets:
            {
                _imageArray = [@[@"recharge",@"withdrawal"] mutableCopy];
                _titleArray = [@[@"充值",@"提现"] mutableCopy];
            }
                break;
            case kCollectionViewMine:
            {
                _imageArray = [@[@"account",@"CustomerServiceTelephone",@"help",@"about"] mutableCopy];
                _titleArray = [@[@"账户",@"专属客服",@"新手帮助",@"关于我们"] mutableCopy];
            }
                break;
            default:
            {
                [_collectionView reloadData];
            }
                break;
        }
    }
    return self;
}


#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomColloctionCell * cell = [CustomColloctionCell creatCollectionView:collectionView indexPath:indexPath];
    [cell setImageStr:self.imageArray[indexPath.row] titleStr:self.titleArray[indexPath.row] type:tempType];
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake(selfWidth/self.imageArray.count, selfHeight);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    if ([self.delegate respondsToSelector:@selector(customCollectionView:indexPath:)]) {
        [self.delegate customCollectionView:self indexPath:indexPath];
    }
    if (self.cBlock) {
        self.cBlock(self, indexPath);
    }
}

-(void)reloadCollectionView{
    [self.collectionView reloadData];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, selfWidth, selfHeight) collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CustomColloctionCell class] forCellWithReuseIdentifier:@"CustomColloctionCell"];
    }
    return _collectionView;
}

@end
