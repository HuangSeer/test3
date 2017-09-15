//
//  DyWebViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/3.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "BangzhuViewController.h"
#import "PchHeader.h"
@interface BangzhuViewController ()<UIWebViewDelegate>{
    NSMutableDictionary *userinfo;
    NSString *aakey;
    NSString *aatvinfo;
    NSString *Deptid;
}
@property(strong ,nonatomic) UIWebView * webView;

@end

@implementation BangzhuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    aatvinfo=[userinfo objectForKey:@"TVInfoId"];
    aakey=[userinfo objectForKey:@"Key"];
    Deptid=[[arry objectAtIndex:0] objectForKey:@"Deptid"];
    self.navigationItem.title=@"帮助中心";
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height)];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:[URL stringByAppendingString:[NSString stringWithFormat:@"/Seehelp.html"]]]];
    //           NSURLRequest * request = [NSURLRequest requestWithURL:request]];
    self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    backItem.tag=110;
    [backItem addTarget:self action:@selector(buttondesire) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    // Do any additional setup after loading the view.
}
-(void)buttondesire{
    [self.navigationController popViewControllerAnimated:NO];
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
