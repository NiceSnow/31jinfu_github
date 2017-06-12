//
//  MainRootViewController.m
//  31jinfu
//
//  Created by 刘厚宽 on 2017/5/5.
//  Copyright © 2017年 刘厚宽. All rights reserved.
//

#import "MainRootViewController.h"
#import <BHInfiniteScrollView/BHInfiniteScrollView.h>//轮播图
#import "WebViewController.h"
#import "CustomColloctionView.h"

@interface MainRootViewController ()<BHInfiniteScrollViewDelegate>
@property (nonatomic, strong)UIScrollView* scrollView;

@property (nonatomic, strong)BHInfiniteScrollView* bannerView;
@property (nonatomic, strong)BHInfiniteScrollView* ADView;
@property (nonatomic, strong)CustomColloctionView* collectionView;

@end

@implementation MainRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录/注册" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftBarbuttonItemAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Qrcode"] style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarButtonItemAction)];
    [self.view addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
//左侧按钮点击方法
- (void)leftBarbuttonItemAction
{
    
}
//NAV右侧按钮点击方法
- (void)rightBarButtonItemAction
{
    
}
- (UIScrollView *)scrollView
{
    if (!_scrollView ) {
        _scrollView = [UIScrollView new];
        //bannerview
        _bannerView = [BHInfiniteScrollView infiniteScrollViewWithFrame:CGRectMake(0, 0, screenWidth, screenHeight/3.0) Delegate:self ImagesArray:@[@"banner1",@"banner2"]];
        _bannerView.dotSpacing = 5;
        _bannerView.scrollTimeInterval = 5;
        _bannerView.tag = 1001;
        _bannerView.delegate = self;
        [_scrollView addSubview:_bannerView];
        
        [_scrollView addSubview:self.collectionView];//collection
        
        UIView * lineView1 = [UIView new];
        lineView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
        lineView1.frame = CGRectMake(0, CGRectGetMaxY(_collectionView.frame), screenWidth, 5);
        [_scrollView addSubview:lineView1];
        
        UIImage * image = [UIImage imageNamed:@"horn"];
        UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
        imageView.frame = (CGRect){CGPointMake(20, CGRectGetMaxY(lineView1.frame)+8),image.size};
        [_scrollView addSubview:imageView];
        
        UIView * lineView2 = [UIView new];
        lineView2.backgroundColor = [UIColor groupTableViewBackgroundColor];
        lineView2.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame)+8, screenWidth, 5);
        [_scrollView addSubview:lineView2];
        
        //广告轮播
        CGFloat Width  = screenWidth- CGRectGetMaxX(imageView.frame) -10;
        CGFloat height = CGRectGetMinY(lineView2.frame)- CGRectGetMaxY(lineView1.frame);
        _ADView = [BHInfiniteScrollView infiniteScrollViewWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10,CGRectGetMaxY(lineView1.frame) ,Width ,height) Delegate:self ImagesArray:[self getImageWihtTextsize:CGSizeMake(Width, height-5)]];
        _ADView.pageControlHidden = YES;
        _ADView.scrollDirection = BHInfiniteScrollViewScrollDirectionVertical;
        _ADView.scrollTimeInterval = 3;
        _ADView.tag = 1002;
        
        [_scrollView addSubview:self.ADView];
        UIImage *interestRateImage = [UIImage imageNamed:@"bili_03"];
        UIImageView * interestRateImageView = [[UIImageView alloc]initWithImage:interestRateImage];//年化利率
        interestRateImageView.frame = CGRectMake((screenWidth - interestRateImage.size.width)/2.0, CGRectGetMaxY(lineView2.frame), interestRateImage.size.width, interestRateImageView.size.height);
        [_scrollView addSubview:interestRateImageView];
        
        UIButton * investmentButton = [UIButton new];//开始投资
        [investmentButton setTitle:@"立即投资" forState:normal];
        investmentButton.backgroundColor = kRedColor;
        investmentButton.frame = CGRectMake(30, CGRectGetMaxY(interestRateImageView.frame)+10, screenWidth - 60, 35);
        investmentButton.layer.cornerRadius = 5;
        investmentButton.layer.masksToBounds = YES;
        [investmentButton addTarget:self action:@selector(investmentButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:investmentButton];
        
        _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(investmentButton.frame)+10);
        
    }
    return _scrollView;
}
//开始投资
- (void)investmentButtonAction
{
    self.tabBarController.selectedIndex = 1;
}
- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didSelectItemAtIndex:(NSInteger)index
{
    WebViewController * webView = [[WebViewController alloc]init];

    if (infiniteScrollView.tag == 1001) {
        if (index == 1) {
            webView.urlString = @"http://www.stsyd.com/wap/Event";
            webView.title = @"活动";
        }
    }else{
        webView.title = @"新闻公告";
        if (index == 0) {
            webView.urlString = @"http://www.stsyd.com/wap/cmsRead.action?id=65&columnId=2";
        }else if (index == 1){
            webView.urlString = @"http://www.stsyd.com/wap/cmsRead.action?id=64&columnId=2";
        }else if (index == 2){
            webView.urlString = @"http://www.stsyd.com/wap/cmsRead.action?id=605&columnId=2";
        }else if (index == 3){
            webView.urlString = @"http://www.stsyd.com/wap/cmsRead.action?id=55&columnId=2";
        }else if (index == 4){
            webView.urlString = @"http://www.stsyd.com/wap/cmsRead.action?id=54&columnId=2";
        }
    }
    
    [self.navigationController pushViewController:webView animated:YES];
    
}
- (NSArray *)getImageWihtTextsize:(CGSize )size
{
    NSMutableArray * imageView = [NSMutableArray array];
    
    NSArray * titleArray = @[
                             @"温情友情月 邀请好友来赚钱”活动红包兑换终止公告",
                             @"五一劳动节放假通知",
                             @"三八妇女节活动公告",
                             @"关于三一金服取得增值电信业务经营许可证（ICP证）的公告",
                             @"关于三一金服正式上线的公告",];
    for (NSString * text in titleArray) {
        [imageView addObject:[ToolsHelper getImage:text size:size font:[UIFont systemFontOfSize:10] backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor]]];
    }
    
    return [imageView copy]; 
}
- (CustomColloctionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[CustomColloctionView alloc]initWithFrame:CGRectMake(0,  CGRectGetMaxY(_bannerView.frame), screenWidth,  screenHeight/9.0) Type:(kCollectionViewMain)];
        MJWeakSelf;
        _collectionView.cBlock = ^(CustomColloctionView *collection, NSIndexPath *indexPath) {

            WebViewController * webView = [[WebViewController alloc]init];
            if (indexPath.row == 0) {
                webView.title = @"充值";
                webView.urlString = @"http://www.stsyd.com/wap/initRecharge";
            }else if (indexPath.row == 1){
                webView.title = @"提现";
                webView.urlString = @"http://www.stsyd.com/wap/withdrawals";
            }else if (indexPath.row == 2){
                webView.title = @"邀请好友";
                webView.urlString = @"http://www.stsyd.com/wap/initMyReward?inviteCode=";
            }else if (indexPath.row == 3){
                weakSelf.tabBarController.selectedIndex = 2;
                return ;
            }else if (indexPath.row == 4){
                webView.title = @"优惠券";
                webView.urlString = @"http://www.stsyd.com/wap/myReward";
            }
            [weakSelf.navigationController pushViewController:webView animated:YES];
        };
        
    }
    return _collectionView;
}
@end
