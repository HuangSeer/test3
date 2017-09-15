//
//  GRRuanJianViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/18.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "GRRuanJianViewController.h"
#import "YiJianViewController.h"
#import "BangzhuViewController.h"

@interface GRRuanJianViewController ()
@end

@implementation GRRuanJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"软件设置";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (IBAction)butyijian:(UIButton *)sender {
    NSLog(@"=================================");
    BangzhuViewController *BangzhuV=[[BangzhuViewController alloc] init];
    [self.navigationController pushViewController:BangzhuV animated:NO];
    self.navigationController.navigationBarHidden=NO;
    self.tabBarController.tabBar.hidden=YES;
    
}
- (IBAction)butbangz:(UIButton *)sender {
    NSLog(@"=================================");
    YiJianViewController *YiJianV=[[YiJianViewController alloc] init];
    [self.navigationController pushViewController:YiJianV animated:NO];
    self.navigationController.navigationBarHidden=NO;
    self.tabBarController.tabBar.hidden=YES;
    
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
