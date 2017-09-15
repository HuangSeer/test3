//
//  ShengHuoViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/24.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "ShengHuoViewController.h"
#import "PchHeader.h"
#import "FaTieViewController.h"
#import "CBHeaderChooseViewScrollView.h"
#import "TouTiaoModel.h"
#import "ShengHuoTableViewCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"
@interface ShengHuoViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *_saveArray;
    NSMutableArray *titleArray;
    
    NSString *aaid;
    NSMutableDictionary *userInfo;
    NSString *key;
    NSString *deptid;
    NSString *pandid;
    NSString *tvinfoId;
    NSMutableArray *sqshArray2;
    //    YJSegmentedControl * segment;
}
@property(assign,nonatomic) NSInteger currentPage;
@end

@implementation ShengHuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    titleArray=[NSMutableArray arrayWithCapacity:0];
    sqshArray2=[NSMutableArray arrayWithCapacity:0];
    _saveArray=[NSMutableArray arrayWithCapacity:0];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 44, Screen_Width, Screen_height-64)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.showsVerticalScrollIndicator =NO;
    _tableView.backgroundColor=[UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
    key=[userDefaults objectForKey:Key];
    deptid=[userDefaults objectForKey:DeptId];
    tvinfoId=[userDefaults objectForKey:TVInfoId];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userInfo objectForKey:@"Data"];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
    
    [self fatie];
}
-(void)daohang{
    self.navigationItem.title=@"社区生活";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    UIButton * backFen = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 44, 18)];
    [backFen setTitle:@"发帖" forState:UIControlStateNormal];
    [backFen addTarget:self action:@selector(fatieClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backFen];
    
    UIBarButtonItem *RigeItemBar = [[UIBarButtonItem alloc] initWithCustomView:backFen];
    [self.navigationItem setRightBarButtonItem:RigeItemBar];
    
    CBHeaderChooseViewScrollView *headerView=[[CBHeaderChooseViewScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    [self.view addSubview:headerView];
    [headerView setUpTitleArray:titleArray titleColor:nil titleSelectedColor:[UIColor greenColor] titleFontSize:0];
    headerView.btnChooseClickReturn = ^(NSInteger x){
        [_saveArray removeAllObjects];
        NSLog(@"点击了第%ld个按钮",x+1);
        
        if (x==0) {
            _currentPage=1;
            pandid=@"";
            [self SheQuShengHuo:pandid];
            //            [titleArray removeAllObjects];
            //            self.currentPage=1;
            //            [self SheQuShengHuo];
            
        }else{
            _currentPage=1;
            pandid=[NSString stringWithFormat:@"%ld",x-1];
        
            [self SheQuShengHuo:pandid];
            
            
        }
    };
}
-(void)fatie{
    NSString *strurl=[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=ModnewpostsType&TVInfoId=%@&Key=%@",URL,tvinfoId,key];
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"%@",data);
        NSArray *neiArray=[data objectForKey:@"Data"];
        for (int i=0; i<neiArray.count; i++) {
            [titleArray addObject:[[neiArray objectAtIndex:i] valueForKey:@"type"]];
        }
        [titleArray insertObject:@"全部" atIndex:0];
        if (titleArray.count>0) {
            [self daohang];
            pandid=@"";
            [self setupRefresh];
        }
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"失败!!"];
    }];
}

//社区生活
-(void)SheQuShengHuo:(NSString *)sender
{
    
    NSString *strurl=[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=allpost&TVInfoId=%@&Key=%@&DeptId=%@&Uid=3%@&Page=%ld&PageSize=10&typeid=%@",URL,tvinfoId,key,deptid,aaid,_currentPage,pandid];
    NSLog(@"%@",strurl);
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"%@",data);
        NSArray *saveay=[TouTiaoModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"Data"]];
        NSArray *sqshay=[[data objectForKey:@"Data"] valueForKey:@"title"];
        if (_currentPage==1) {
            [_saveArray removeAllObjects];
            [sqshArray2 removeAllObjects];
        }
        [_saveArray addObjectsFromArray:saveay];
        [sqshArray2 addObjectsFromArray:sqshay];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"失败!!"];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _saveArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShengHuoTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"ShengHuoTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    
    TouTiaoModel *mode=[_saveArray objectAtIndex:indexPath.item];
    
    [cell.imgVie sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,mode.url]] placeholderImage:[UIImage imageNamed:@"默认图片"]];
    cell.lab_tit.text=[NSString stringWithFormat:@"%@",[sqshArray2 objectAtIndex:indexPath.row]];
    cell.lab_time.text=[NSString stringWithFormat:@"%@  %@",mode.type,mode.time];
    return  cell;
}
//表格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选了了第%ld行",indexPath.row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)fatieClick
{
    FaTieViewController *FaTie=[[FaTieViewController alloc] init];
    [self.navigationController pushViewController:FaTie animated:NO];
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    self.currentPage=1;
    // 1.数据操作
    [self SheQuShengHuo:pandid];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_tableView.mj_header endRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.数据操作
    self.currentPage++;
    [self SheQuShengHuo:pandid];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_tableView reloadData];
        [_tableView.mj_footer endRefreshing];
    });
}



/**
 *  集成刷新控件
 */
-(void)setupRefresh{
    
    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        tableView.mj_footer.hidden = YES;
        [self headerRereshing];
    }];
    
#warning 自动刷新(一进入程序就下拉刷新)
    
    [_tableView.mj_header beginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    
}

@end
