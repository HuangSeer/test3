//
//  SearchViewController.m

#import "SearchViewController.h"
#define Start_X          10.0f      // 第一个按钮的X坐标
#define Start_Y          50.0f     // 第一个按钮的Y坐标
#define Width_Space      10.0f      // 2个按钮之间的横间距
#define Height_Space     20.0f     // 竖间距
#define Button_Height   40.0f    // 高
#define Button_Width    65// 宽
#import "SearchTableViewCell.h"
#import "ZQLNetWork.h"
#import "SSJGViewController.h"
//#import "activityModel.h"
#import "MJExtension.h"
#import "SousuoModel.h"
#import "PchHeader.h"

@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *array;
    UIButton *tempBtn1;
    SearchTableViewCell *cell;
    UIView *allview;
    UIButton *butx;
    NSString *strlex;
    CGFloat h;
}
@property(nonatomic,strong)NSString *setrcode;
@property (strong,nonatomic)UITableView *tableviews;
@property (strong ,nonatomic) NSArray * butTitles;
@property (strong ,nonatomic) NSArray * labtexts;
@property(strong,nonatomic) UISearchBar *searchText;
@property (strong ,nonatomic) NSMutableArray * SousArray;
@property (strong ,nonatomic) NSMutableArray * jilusArray;

@end

@implementation SearchViewController
-(void)viewWillAppear:(BOOL)animated{
        self.tabBarController.tabBar.hidden=YES;
        [self.navigationController.navigationBar setBackgroundImage:
        [UIImage imageNamed:@"bjdhl"] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBarHidden=NO;//隐藏导航栏
        //    self.navigationController.navigationBar.barTintColor=RGB(248, 192, 72);
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        self.view.backgroundColor=[UIColor whiteColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readNSUserDefaults];
    [self search];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"backtwo.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
   
    
    
}
-(void)btnCkmore
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)search{
 

    [self sousuoloade];
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    //        _searchText = [[UISearchBar alloc] init];
    _searchText = [[UISearchBar alloc] init];
    _searchText.delegate = self;
    _searchText.frame = CGRectMake(5, 5, 230,30);
    self.searchText.layer.cornerRadius = 10;
    _searchText.layer.borderWidth = 1;
    _searchText.layer.borderColor = [RGBColor(238, 238, 238) CGColor];
    [_searchText setBackgroundImage:[UIImage new]];
    self.searchText.layer.masksToBounds = YES;
     [titleView addSubview:self.searchText];
        self.navigationItem.titleView = titleView;
    tempBtn1=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width-85,0, 55,40)];

    [tempBtn1 setTitle:@"搜 索" forState:UIControlStateNormal];
    tempBtn1.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    tempBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [tempBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //button点击事件
    [tempBtn1 addTarget:self action:@selector(butToMinePage) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:tempBtn1];
  
    
  
}
-(void)sousuoloade{
    NSString *strurl=[NSString stringWithFormat:@"%@hotSearch.htm",URLds];
 
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
            NSLog(@"%@",data);
            _butTitles=[data objectForKey:@"data"];
            UILabel *labsx=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, Screen_Width-5, 30)];
            labsx.text=@"最近热搜";
            labsx.font=[UIFont systemFontOfSize:14.0f];
            labsx.textColor=[UIColor orangeColor];
            [self.view addSubview:labsx];
            CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
            h= 40;//用来控制button距离父视图的高
            for (int i = 0; i < _butTitles.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.tag =i;
            button.backgroundColor = RGBColor(220, 220, 220);
            [button addTarget:self action:@selector(mapBwtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //根据计算文字的大小
            button.layer.cornerRadius=5;
            button.layer.masksToBounds = YES;
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
            CGFloat length = [_butTitles[i] boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
            //为button赋值
            [button setTitle:_butTitles[i] forState:UIControlStateNormal];
            //设置button的frame
            button.frame = CGRectMake(10 + w, h, length + 15 , 25);
            //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
            if(10 + w + length + 15 > 320){
            w = 0; //换行时将w置为0
            h = h + button.frame.size.height + 10;//距离父视图也变化
            button.frame = CGRectMake(10 + w, h, length + 15, 25);//重设button的frame
            }
            w = button.frame.size.width + button.frame.origin.x;
            [self.view addSubview:button];
            }
            NSLog(@"%f",h);

            _tableviews = [[UITableView alloc] initWithFrame:CGRectMake(0, h+40, Screen_Width, Screen_height-h-100) style:UITableViewStyleGrouped];
            _tableviews.delegate = self;
            _tableviews.dataSource = self;
            [_tableviews registerNib:[UINib nibWithNibName:NSStringFromClass([SearchTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
            _tableviews.backgroundColor=[UIColor whiteColor];
            UIView * viewwei = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_height/1.41, Screen_Width, Screen_height)];
            viewwei.backgroundColor = RGBColor(229, 229, 229);
            [self.view addSubview:viewwei];


            [self.view addSubview:_tableviews];

        
    } failure:^(NSError *error) {
    }];
}

-(void)butToMinePage{
    if (_searchText.text.length!=0) {
      
        NSString *strsearch=[[NSString stringWithFormat:@"%@",self.searchText.text]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *strurl=[NSString stringWithFormat:@"%@search.htm?type=goods&keyword=%@currentPage=1",URLds,strsearch];
        [ZQLNetWork getWithUrlString:strurl success:^(id data) {
            NSLog(@"=====%@",data);
            NSMutableArray *daarray=[data objectForKey:@"data"];
            NSString *statusCode=[NSString stringWithFormat:@"%@",[data objectForKey:@"statusCode"]];
            NSString *msg=[NSString stringWithFormat:@"%@",[data objectForKey:@"msg"]];
            if ([statusCode containsString:@"200"]) {
            SSJGViewController *SSJGVi=[[SSJGViewController alloc]init];
                SSJGVi.strci=strsearch;
                SSJGVi.strdhl=_searchText.text;
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
            [self.navigationController pushViewController:SSJGVi animated:NO];
            }else{
            [SVProgressHUD showErrorWithStatus:msg];

            }
            [self SearchText:self.searchText.text];
            
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"失败!!"];
        }];

    }}
-(void)SearchText:(NSString *)seaTxt
{
    NSMutableArray *searTXT = [[NSMutableArray alloc] init];
    if (self.jilusArray) {
        searTXT = [self.jilusArray mutableCopy];
    }
  BOOL isbool = [searTXT containsObject:seaTxt];
    if (isbool==0) {
        [searTXT addObject:seaTxt];
    }
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:searTXT forKey:@"searchHistory"];
    [self readNSUserDefaults];
}

-(void)readNSUserDefaults
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.jilusArray =[[userDefaultes arrayForKey:@"searchHistory"]  mutableCopy];
    [_tableviews reloadData];
}


-(void)butqcClick{
    NSString *message = NSLocalizedString(@"确定清空历史搜索吗？", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"取消");
    }];
    
    //确认删除
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSArray * myArray = [userDefaultes arrayForKey:@"searchHistory"];
        NSMutableArray *searTXT = [myArray mutableCopy];
        [searTXT removeAllObjects];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:searTXT forKey:@"searchHistory"];
      [self readNSUserDefaults];
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

//点击按钮方法,这里容易犯错
-(void)mapBwtnClick:(UIButton *)sender{
    NSLog(@"%ld",sender.tag);
    _searchText.text=_butTitles[sender.tag];
    
    
    [self butToMinePage];
}
-(void)textFiledBeganEdting{
    self.view.hidden=NO;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_searchText resignFirstResponder];
}
- (void)keyboardWillHide:(NSNotification *) notification {
    float animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat height = [[[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGRect bottomBarFrame = self.view.frame;
    [UIView beginAnimations:@"bottomBarDown" context:nil];
    [UIView setAnimationDuration: animationDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    bottomBarFrame.origin.y += height;
    [self.view setFrame:bottomBarFrame];
    [UIView commitAnimations];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIButton *butqc=[[UIButton alloc]
    initWithFrame:CGRectMake(5, 0, Screen_Width, Screen_height/12)];
    [butqc setTitle:@"清除历史记录" forState:UIControlStateNormal];
    [butqc setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    butqc.font=[UIFont systemFontOfSize:11];
    butqc.backgroundColor=[UIColor whiteColor];
    [butqc addTarget:self action:@selector(butqcClick) forControlEvents:UIControlEventTouchUpInside];
    [_tableviews addSubview:butqc];
    return butqc;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
        return Screen_height/12;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld",self.jilusArray.count);
    return self.jilusArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return Screen_height/12;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
      
    cell.lab.text=self.jilusArray[indexPath.row];
    cell.lab.font=[UIFont systemFontOfSize:11];
    return cell;
    
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, Screen_Width-50, 30)];
    lab.text=@"  搜素历史";
    lab.textColor=[UIColor orangeColor];
    lab.font=[UIFont systemFontOfSize:14.0f];

    return lab;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
        return  30;
    }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.lab.text=self.jilusArray[indexPath.row];
    _searchText.text=cell.lab.text;
    [self butToMinePage];
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"===%@",indexPath);
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {

            //    删除
        [[self jilusArray] removeObjectAtIndex:indexPath.row]; //[self unArchiverCollectArray]反归档出来的包含收藏数据的数组
        
        //从界面上删除
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.jilusArray forKey:@"searchHistory"];
        [self performSelector:@selector(reloadTable) withObject:nil afterDelay:0.5];
    }
    
}
- (void)reloadTable {
    [_tableviews reloadData];
}

-(void)FiledBeganEdting{

    if ([self.searchText.text isEqualToString:@""]) {
                //        self.loginBtn.backgroundColor = [UIColor grayColor];
                tempBtn1.userInteractionEnabled = NO;
            }else{
                //        self.loginBtn.backgroundColor = [UIColor redColor];
               tempBtn1.userInteractionEnabled = YES;
            }
}

//设置输入框光标颜色
- (void)setCursorColor:(UIColor *)cursorColor
{
    if (cursorColor) {
        _cursorColor = cursorColor;
        //获取输入框
        UITextField *searchField = self.searchText;
        if (searchField) {
            //光标颜色
            [searchField setTintColor:cursorColor];
        }
    }
}
-(void)butxclick{


    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    
    allview= [[UIView alloc]initWithFrame:CGRectMake(10,120,45,83)];
    allview.backgroundColor=[UIColor whiteColor];
    NSArray *array=@[@"宝贝",@"商铺"];
    for (int i=0;i<array.count; i++) {
        int crp=i%2;
        UIButton *butxs=[[UIButton alloc]initWithFrame:CGRectMake(0, crp*41, 45,41)];
        butxs.layer.borderWidth=0.5;
        butxs.tag=i+1;
        [butxs setTitle:[NSString stringWithFormat:@"%@",array[i]] forState:UIControlStateNormal];
        [butxs setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        butxs.font=[UIFont systemFontOfSize:14.0f];
        butxs.layer.masksToBounds = YES;
        butxs.layer.borderColor=RGBColor(86, 86, 86).CGColor;
        [butxs addTarget:self action:@selector(butxclickcon:) forControlEvents:UIControlEventTouchUpInside];
        [allview addSubview:butxs];
        
    }
    [window addSubview:allview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}
@end
