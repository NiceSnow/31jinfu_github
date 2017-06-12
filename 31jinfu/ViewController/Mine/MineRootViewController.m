//
//  MineRootViewController.m
//  31jinfu
//
//  Created by 刘厚宽 on 2017/5/5.
//  Copyright © 2017年 刘厚宽. All rights reserved.
//

#import "MineRootViewController.h"
#import "WebViewController.h"
#import "CustomColloctionView.h"

@interface MineRootViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL isHedden;
}
@property (nonatomic, strong)UIImageView* headImageView;
@property (nonatomic, strong)UILabel    * nameLabel;
@property (nonatomic, strong)UIImageView* topBackImageView;
@property (nonatomic, strong)CustomColloctionView* collectionView;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * titleArray;
@property (nonatomic, strong)NSMutableArray * imageArray;
@property (nonatomic, strong)UIView * headerView;


@end

@implementation MineRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topBackImageView];
    
    [_topBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo((CGRectGetHeight(_topBackImageView.frame)/CGRectGetWidth(_topBackImageView.frame))*screenWidth);
    }];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_collectionView.mas_bottom);
    }];
}

- (UIImageView *)topBackImageView
{
    if (!_topBackImageView) {
        _topBackImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mcback"]];
        _topBackImageView.userInteractionEnabled = YES;
        
        _headImageView  = [UIImageView new];
        _headImageView.image = [UIImage imageNamed:@"timg"];
        _headImageView.layer.cornerRadius = 33.0;
        _headImageView.layer.masksToBounds = YES;
        [_topBackImageView addSubview:self.headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_topBackImageView);
            make.centerY.equalTo(_topBackImageView).offset(-10);
            make.size.sizeOffset(CGSizeMake(66, 66));
        }];
        
        _nameLabel = [UILabel new];
        _nameLabel.text = @"123123123123";
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:14.0f];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        
        [_topBackImageView addSubview:self.nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_topBackImageView);
            make.top.equalTo(_headImageView.mas_bottom).offset(10);
        }];
    }
    return _topBackImageView;
}
- (CustomColloctionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[CustomColloctionView alloc]initWithFrame:CGRectMake(0,  ((CGRectGetHeight(_topBackImageView.frame)/CGRectGetWidth(_topBackImageView.frame))*screenWidth), screenWidth,  screenHeight/9.0) Type:(kCollectionViewMine)];
        MJWeakSelf;
        _collectionView.cBlock = ^(CustomColloctionView *collection, NSIndexPath *indexPath) {
            
            WebViewController * webView = [[WebViewController alloc]init];
            if (indexPath.row == 0) {
                weakSelf.tabBarController.selectedIndex = 2;
                return ;
            }else if (indexPath.row == 1){
                webView.title = @"微信客服";
                webView.urlString = @"http://www.stsyd.com/wap/wechatkf";
            }else if (indexPath.row == 2){
                webView.title = @"新手客服";
                webView.urlString = @"http://www.stsyd.com/wap/newplayerhelp";
            }else if (indexPath.row == 3){
                weakSelf.tabBarController.selectedIndex = 2;
                return ;
            }else if (indexPath.row == 4){
                webView.title = @"关于我们";
                webView.urlString = @"http://www.stsyd.com/wap/aboutUs";
            }
            [weakSelf.navigationController pushViewController:webView animated:YES];
        };
        
    }
    return _collectionView;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;

        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        _tableView.rowHeight = 60;
        UIView * footerView = [UIView new];
        footerView.frame = CGRectMake(0, 0, screenWidth, 60);
        UIButton * button = [UIButton new];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitle:@"退出登录" forState:normal];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.backgroundColor = kRedColor;
        [button addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(screenWidth -30);
        }];
        _tableView.tableFooterView = footerView;
    }
    return _tableView;
}
- (void)logoutAction
{
    
}
#pragma mark -
#pragma mark - 修改头像
- (void)changeHeaderImageAction
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"相册", nil];
    [sheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    
    switch (buttonIndex) {
        case 0:
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                picker.sourceType=UIImagePickerControllerSourceTypeCamera;
            } else {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"本设备不支持相机模式" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            break;
            
        case 1:
            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            break;
            
        case 2:
            return;
            break;
            
        default:
            break;
    }
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    UIImage *image= [info objectForKey:@"UIImagePickerControllerEditedImage"];
//    UIImage * thumbnail  = [ToolsHelper thumbnailWithImage:image size:CGSizeMake(320, 320)];
//    __weak typeof(self)weekSelf = self;
//    [picker dismissViewControllerAnimated:YES completion:^{
//        [weekSelf uploadSavatarWithImage:thumbnail];
//    }];
}
- (void)uploadSavatarWithImage:(UIImage * )image
{
//    [UserInfoRequest CreatrUserHeaderImage:image succeed:^(id obj) {
//        BOOL code = [[obj objectForKey:@"code"] boolValue];
//        if (code) {
//            BOOL status = [[[obj objectForKey:@"ret"]objectForKey:@"status"] boolValue];
//            if (status) {
//                [UserHelper instance].user.pic = [[obj objectForKey:@"ret"]objectForKey:@"url"];
//                [UserHelper insertUserInfo];
//                NSData* data = UIImageJPEGRepresentation(image, 1.0);
//                [self.headerImageButton setImage:image forState:UIControlStateNormal];
//                [data writeToFile:HeaderImage atomically:YES];
//            }
//            [ToolsHelper showSuccessMessage:@"上传成功"];
//        }else{
//            [ToolsHelper showErrorMessage:@"上传失败"];
//        }
//    } failed:^(id obj) {
//        
//    }];
}

-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [@[@"我的消息",@"我的优惠券",@"账户信息",@"安全保障"] mutableCopy];
    }
    return _titleArray;
}
-(NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [@[@"message",@"coupons",@"accountInformation",@"safe"] mutableCopy];
    }
    return _imageArray;
}
 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:nil];
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.textColor = kGrayColor;
    NSString* imageString = self.imageArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imageString];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:16];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WebViewController * webView = [[WebViewController alloc]init];
    webView.title = _titleArray[indexPath.row];
    if (indexPath.row == 0) {
        webView.urlString = @"http://www.stsyd.com/wap/queryMessageManagerWap";
    }else if (indexPath.row == 1){
        webView.urlString = @"http://www.stsyd.com/wap/myReward";
    }else if (indexPath.row == 2){
        webView.urlString = @"http://www.stsyd.com/wap/initMyReward?inviteCode=";
    }else if (indexPath.row == 3){
        webView.urlString = @"http://www.stsyd.com/wap/userCenter";
    }else if (indexPath.row == 4){
        webView.urlString = @"http://www.stsyd.com/wap/safeguard";
    }
    [self.navigationController pushViewController:webView animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
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
