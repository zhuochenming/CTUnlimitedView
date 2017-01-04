//
//  BaseViewController.m
//  CTUnlimitedView
//
//  Created by 酌晨茗 on 16/1/11.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import "BaseViewController.h"

#import "QQViewController.h"
#import "AutolayoutViewController.h"
#import "TextAroundImagesViewController.h"
#import "FPSViewController.h"

#import "CustomHUD.h"

@interface BaseViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"图文处理";
    
    self.titleArray = @[@"图文混排", @"autolayout", @"图片高度自适应", @"文字环绕图片", @"帧数测试", @"清除图片"];
    [self createTableView];
    // Do any additional setup after loading the view.
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        NSInteger type = arc4random() % 11;
        if (type == 0) {
            [CustomHUD showWithStatus:@"活该你就高考啦啦啦啦开始实施"];
        } else if (type == 1) {
            [CustomHUD showError];
        } else if (type == 2) {
            [CustomHUD showErrorWithStatus:@"即打算减肥拉萨"];
        } else if (type == 3) {
            [CustomHUD showSuccess];
        } else if (type == 4) {
            [CustomHUD showSuccessWithStatus:@"将诶感觉你来到"];
        } else if (type == 5) {
            [CustomHUD showProgress];
        } else if (type == 6) {
            [CustomHUD showProgressWithStatus:@"fjishnvglisjgmo;xf"];
        } else if (type == 7) {
            [CustomHUD showIndicator];
        } else if (type == 8) {
            [CustomHUD showIndicatorWithStatus:@"fjidsahgnlfajgo"];
        } else if (type == 9) {
            [CustomHUD showPhysicsProgress];
        } else if (type == 10) {
            [CustomHUD showPhysicsProgressWithStatus:@"埃及个 i 哦桑来到纪念馆 i 拍电视剧那个可怜的娃看见阿MSN看"];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [CustomHUD dismiss];
        });
    self.titleArray = @[@"图文混排", @"autolayout", @"图片高度自适应", @"文字环绕图片", @"帧数测试", @"清除图片"];
        QQViewController *qq = [[QQViewController alloc] init];
        [self.navigationController pushViewController:qq animated:YES];
    } else if (indexPath.row == 1)  {
        AutolayoutViewController *autolayoutvc = [[AutolayoutViewController alloc] init];
        [self.navigationController pushViewController:autolayoutvc animated:YES];
    } else if (indexPath.row == 2) {

    } else if (indexPath.row == 3) {
        TextAroundImagesViewController *textaroundimagesvc = [[TextAroundImagesViewController alloc] init];
        [self.navigationController pushViewController:textaroundimagesvc animated:YES];
    } else if (indexPath.row == 4) {
        FPSViewController *fpsvc = [[FPSViewController alloc] init];
        [self.navigationController pushViewController:fpsvc animated:YES];
    }  else {
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
