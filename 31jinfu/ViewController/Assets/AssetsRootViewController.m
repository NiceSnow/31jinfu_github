//
//  AssetsRootViewController.m
//  31jinfu
//
//  Created by 刘厚宽 on 2017/5/5.
//  Copyright © 2017年 刘厚宽. All rights reserved.
//

#import "AssetsRootViewController.h"
#import "WebViewController.h"
#import "CustomColloctionView.h"

@interface AssetsRootViewController ()
{
      BOOL isHedden;
}

@property (nonatomic, strong)UILabel* totalMoneyLabel;//总金额
@property (nonatomic, strong)UILabel* canUseMoneyrLabel; //可用金额
@property (nonatomic, strong)UILabel* waitTakeBackMoneyLabel;//待收金额
@property (nonatomic, strong)UILabel* waitEarningsMoneyLabel;//待收收益
@property (nonatomic, strong)UIView * topView;//上面红色的view

@property (nonatomic, strong)CustomColloctionView* collectionView;

@end

@implementation AssetsRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(screenHeight*.32);
    }];
    [self.view addSubview:self.collectionView];
    UILabel * alertLabel = [UILabel new];
    alertLabel.textColor = kGrayColor;
    alertLabel.text = @"暂无投资记录哦~";
    [self.view addSubview:alertLabel];
    [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_collectionView.mas_bottom).offset(50);
    }];
}
-(UIView *)topView
{
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = kRedColor;
        _topView.alpha = .8;
        UIImage * image =[UIImage imageNamed:@"assetsReport"];
        UIImageView * icon = [[UIImageView alloc]initWithImage:image];
        [_topView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(20);
            make.size.sizeOffset(image.size);
        }];
        
        UILabel * iconLabel = [UILabel new];
        iconLabel.text = @"资产明细";
        iconLabel.font = [UIFont systemFontOfSize:8];
        iconLabel.textColor = kGrayColor;
        [_topView addSubview:iconLabel];
        [iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(icon.mas_bottom).offset(2);
            make.centerX.equalTo(icon);
        }];
        
        UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zichang102"]];
        [_topView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(_topView);
        }];
        
        _totalMoneyLabel = [UILabel new];
        _totalMoneyLabel.text = @"0.0";
        _totalMoneyLabel.font = [UIFont systemFontOfSize:24];
        _totalMoneyLabel.adjustsFontSizeToFitWidth = YES;
        _totalMoneyLabel.textColor = [UIColor whiteColor];
        _totalMoneyLabel.textAlignment = NSTextAlignmentCenter;
        [_topView addSubview:_totalMoneyLabel];
        [_totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_topView);
            make.top.equalTo(iconLabel.mas_bottom).offset(5);
        }];
        
        UILabel * totalTitle = [UILabel new];
        totalTitle.text = @"资产总计（元）";
        totalTitle.font = [UIFont systemFontOfSize:12];
        totalTitle.adjustsFontSizeToFitWidth = YES;
        totalTitle.textColor = [UIColor whiteColor];
        totalTitle.textAlignment = NSTextAlignmentCenter;
        [_topView addSubview:totalTitle];
        [totalTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_topView);
            make.top.equalTo(_totalMoneyLabel.mas_bottom).offset(5);
        }];
        
        _canUseMoneyrLabel = [UILabel new];
        _canUseMoneyrLabel.textColor = [UIColor whiteColor];
        _canUseMoneyrLabel.textAlignment = NSTextAlignmentCenter;
        _canUseMoneyrLabel.font = [UIFont systemFontOfSize:12];
        _canUseMoneyrLabel.text = @"0.00";
        _canUseMoneyrLabel.adjustsFontSizeToFitWidth = YES;
        [_topView addSubview:_canUseMoneyrLabel];
        [_canUseMoneyrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(_topView);
            make.width.mas_equalTo(screenWidth/3.0);
        }];
        
        UILabel * canTitle = [UILabel new];
        canTitle.text = @"可用金额（元）";
        canTitle.textColor = kYellowColor;
        canTitle.textAlignment = NSTextAlignmentCenter;
        canTitle.font = [UIFont systemFontOfSize:14];
        canTitle.adjustsFontSizeToFitWidth = YES;
        [_topView addSubview:canTitle];
        [canTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_topView);
            make.width.mas_equalTo(screenWidth/3.0);
            make.bottom.equalTo(_canUseMoneyrLabel.mas_top).offset(-15);
        }];
        
        _waitTakeBackMoneyLabel = [UILabel new];
        _waitTakeBackMoneyLabel.textColor = [UIColor whiteColor];
        _waitTakeBackMoneyLabel.textAlignment = NSTextAlignmentCenter;
        _waitTakeBackMoneyLabel.font = [UIFont systemFontOfSize:12];
        _waitTakeBackMoneyLabel.text = @"0.00";
        _waitTakeBackMoneyLabel.adjustsFontSizeToFitWidth = YES;
        [_topView addSubview:_waitTakeBackMoneyLabel];
        [_waitTakeBackMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_topView);
            make.width.mas_equalTo(screenWidth/3.0);
            make.centerX.equalTo(_topView);
        }];
        
        UILabel * takeBackTitle = [UILabel new];
        takeBackTitle.text = @"待收本金（元）";
        takeBackTitle.textColor = kYellowColor;
        takeBackTitle.textAlignment = NSTextAlignmentCenter;
        takeBackTitle.font = [UIFont systemFontOfSize:14];
        takeBackTitle.adjustsFontSizeToFitWidth = YES;
        [_topView addSubview:takeBackTitle];
        [takeBackTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.left.equalTo(_waitTakeBackMoneyLabel);
            make.bottom.equalTo(_waitTakeBackMoneyLabel.mas_top).offset(-15);
        }];
        
        _waitEarningsMoneyLabel = [UILabel new];
        _waitEarningsMoneyLabel.textColor = [UIColor whiteColor];
        _waitEarningsMoneyLabel.textAlignment = NSTextAlignmentCenter;
        _waitEarningsMoneyLabel.font = [UIFont systemFontOfSize:12];
        _waitEarningsMoneyLabel.text = @"0.00";
        _waitEarningsMoneyLabel.adjustsFontSizeToFitWidth = YES;
        [_topView addSubview:_waitEarningsMoneyLabel];
        [_waitEarningsMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(_topView);
            make.width.mas_equalTo(screenWidth/3.0);
        }];
        
        UILabel * earningsTitle = [UILabel new];
        earningsTitle.text = @"待收收益（元）";
        earningsTitle.textColor = kYellowColor;
        earningsTitle.textAlignment = NSTextAlignmentCenter;
        earningsTitle.font = [UIFont systemFontOfSize:14];
        earningsTitle.adjustsFontSizeToFitWidth = YES;
        [_topView addSubview:earningsTitle];
        [earningsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(screenWidth/3.0);
            make.right.equalTo(_topView);
            make.bottom.equalTo(_waitEarningsMoneyLabel.mas_top).offset(-15);
        }];
    }
    return _topView;
}
- (CustomColloctionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[CustomColloctionView alloc]initWithFrame:CGRectMake(0,  screenHeight*.32, screenWidth,  screenHeight/9.0) Type:(kCollectionViewAcssets)];
        MJWeakSelf;
        _collectionView.cBlock = ^(CustomColloctionView *collection, NSIndexPath *indexPath) {
            
            WebViewController * webView = [[WebViewController alloc]init];
            if (indexPath.row == 0) {
                webView.title = @"充值";
                webView.urlString = @"http://www.stsyd.com/wap/initRecharge";
            }else if (indexPath.row == 1){
                webView.title = @"提现";
                webView.urlString = @"http://www.stsyd.com/wap/withdrawals";
            }
            [weakSelf.navigationController pushViewController:webView animated:YES];
        };
        
    }
    return _collectionView;
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:[ToolsHelper ImageWithColor:[UIColor clearColor] frame:CGRectMake(0, 0, screenWidth, 64)] forBarMetrics:(UIBarMetricsDefault)];
    [self.navigationController.navigationBar setShadowImage:[ToolsHelper ImageWithColor:[UIColor clearColor] frame:CGRectMake(0, 0, screenWidth, 64)]];
    isHedden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    isHedden = NO;
}
- (BOOL)prefersStatusBarHidden
{
    return isHedden;
}

@end
