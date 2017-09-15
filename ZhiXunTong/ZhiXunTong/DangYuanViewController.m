////  DangYuanViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/1.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "DangYuanViewController.h"
#import "DangyTableViewCell.h"
#import "PchHeader.h"
#import "ZIchaungModel.h"
#import "DyWebViewController.h"
#import "DYziyemViewController.h"

@interface DangYuanViewController ()<UITableViewDelegate, UITableViewDataSource>{

   UITableView *_tableView;
    UIButton *button;
    NSMutableArray  *modeArray;
    NSMutableDictionary *userinfo;
    NSString *aakey;
    NSString *aatvinfo;
    NSString *Deptid;
}
@property(nonatomic,strong)UIButton *button;
@end

@implementation DangYuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"党员管理";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    aatvinfo=[userDefaults objectForKey:TVInfoId];
    aakey=[userDefaults objectForKey:Key];
    Deptid=[userDefaults objectForKey:DeptId];
    //返回按钮
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    backItem.tag=110;
    [backItem addTarget:self action:@selector(buttondesire) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    [self initTableView];
    // Do any additional setup after loading the view.
}


- (void)initTableView {
    NSString *strurlphone=[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=partytitle&TVInfoId=%@&key=%@&DeptId=%@",URL,aatvinfo,aakey,Deptid];
    NSLog(@"%@",strurlphone);
    [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
     NSLog(@"%@",data);
        modeArray=[ZIchaungModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"Data"]];
        NSLog(@"%@",modeArray);
        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
    }];
//
    
    UIView *viewbut=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/6)];
//    viewbut.backgroundColor=[UIColor redColor];
    [self.view addSubview:viewbut];
    NSArray *titleArray=@[@"入党申请",@"流动党员管理",@"党员关系转接",@"党费查询"];
    NSArray *imagearray=@[@"py2",@"流动党员管理",@"党员关系转接",@"py1"];
    
    for (int i = 0 ; i < titleArray.count; i++) {
        button = [[UIButton alloc]initWithFrame:CGRectMake( viewbut.frame.size.width/titleArray.count*i+10, 5,viewbut.frame.size.width/titleArray.count-10, viewbut.frame.size.height-5)];
        UIImage *image = [UIImage imageNamed:imagearray[i]];
         [button setFont: [UIFont systemFontOfSize: 11.0]];
        [button setTitle:titleArray[i]  forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(70.0, -image.size.width, 0.0, 0.0);
        button.imageEdgeInsets = UIEdgeInsetsMake(10.0, (button.frame.size.width-55)/2,button.frame.size.height-65,
                                                  (button.frame.size.width-55)/2);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i+1;
        NSLog(@"%ld",(long)button.tag);
          [button addTarget:self action:@selector(mapBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [viewbut addSubview:button];

        
    }
        UIView *viewxian=[[UIView alloc]initWithFrame:CGRectMake(0, viewbut.frame.size.height-1, self.view.frame.size.width, 1)];
    viewxian.backgroundColor=[UIColor grayColor];
    [viewbut addSubview:viewxian];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/6,self.view.frame.size.width, self.view.frame.size.height-self.view.frame.size.height/4) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DangyTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  modeArray.count;

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DangyTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
    _tableView.separatorStyle = NO;
    cell.ZIchaungM=modeArray[indexPath.row];
    return cell;
  
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        DyWebViewController *DyWebV = [[DyWebViewController alloc] init];
    
        ZIchaungModel *typeShop=modeArray[indexPath.row];
        DyWebV.webid=typeShop.id;
        [self.navigationController pushViewController:DyWebV animated:YES];
}
//点击按钮方法,这里容易犯错
-(void)mapBtnClick:(UIButton *)sender{
    //记住,这里不能写成"mapBtn.tag",这样你点击任何一个button,都只能获取到最后一个button的值,因为前边的按钮都被最后一个button给覆盖了
    DYziyemViewController *DYziyemV = [[DYziyemViewController alloc] init];
    if (sender.tag==1) {
        DYziyemV.dystr=@"3";
        [self.navigationController pushViewController:DYziyemV animated:YES];
    }else if(sender.tag==2){
        DYziyemV.dystr=@"1";
        [self.navigationController pushViewController:DYziyemV animated:YES];
        
    }else if(sender.tag==3){
        DYziyemV.dystr=@"4";
        [self.navigationController pushViewController:DYziyemV animated:YES];
        
        
    }else{
        DYziyemV.dystr=@"2";
        [self.navigationController pushViewController:DYziyemV animated:YES];
    
    }
    NSLog(@"%ld",sender.tag);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buttondesire{
    [self.navigationController popViewControllerAnimated:NO];
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
