//
//  DYziyemViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/3.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "DYziyemViewController.h"
#import "LMJDropdownMenu.h"
#import "WebClient.h"
#import "PchHeader.h"
#import "DyMAFANViewController.h"
#import "DfcxTableViewCell.h"
#import "WSDatePickerView.h"
#import "PchHeader.h"

@interface DYziyemViewController ()<UITextViewDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    UILabel *_placeholderLabel;
    NSString *ddtvinfo;
    NSString *ddkey;
    NSString *aaid;
    NSString *Deptid;
    UIButton *butyzm;
    UIButton *buttj;
    NSString *Status;
    UITableView *tableView;
    NSMutableArray *_dataArray;
    NSMutableArray *addmoArray;
    NSInteger page;
    NSInteger cellheigh;
    NSArray *arrayone;
    UIButton *butxiala;UIButton *butxiala2;UIButton *butxb;
    NSString *date2;NSString *strcx;
    NSDate *datas;
    NSArray *aray; UIView  *views; UIView *allview;NSString *sex;
    float zj;
    UILabel *labprice;

}
@property (strong ,nonatomic)UITextView *textView;
@property (strong ,nonatomic)UITextField *textFile;
@property (strong ,nonatomic)UITextField *textFile1;
@property (strong ,nonatomic)UITextField *textFile2;
@property (strong ,nonatomic)UITextField *textFile3;
@property (strong ,nonatomic)UITextField *textFile4;
@property (strong ,nonatomic)UITextField *textFile5;
@property (strong ,nonatomic)UITextField *textFile6;
@property (strong ,nonatomic)UITextField *textFile7;

@end

@implementation DYziyemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    ddtvinfo=[userDefaults objectForKey:TVInfoId];
    ddkey=[userDefaults objectForKey:Key];
    Deptid=[userDefaults objectForKey:DeptId];
   
    
    if ([_dystr containsString:@"1"]) {
      
        self.navigationItem.title=@"流动党员管理";
        arrayone=@[@"姓名",@"手机号",@"民族",@"身份证号",@"入党时间",@"党费缴纳截止",@"原支部",@"新支部",@"其他情况说明"];
        cellheigh=arrayone.count*46+100;
    [self buttjview];
        
    }else if ([_dystr containsString:@"2"]) {
        self.navigationItem.title=@"党费查询";
        arrayone=@[@"姓名",@"身份证号"];
        cellheigh=arrayone.count*46+80;
        UIView *viewdi=[[UIView alloc]initWithFrame:CGRectMake(0, Screen_height/1.22,Screen_Width,Screen_height-Screen_height/1.22)];
        [self.view addSubview:viewdi];
        UILabel *labzj=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, Screen_Width/3,30)];
        labzj.text=@"党费小计:";
        labzj.textColor=[UIColor blackColor];
        [viewdi addSubview:labzj];
        labprice=[[UILabel alloc]initWithFrame:CGRectMake(Screen_Width-(Screen_Width/3+5), 5, Screen_Width/3, 30)];
        labprice.text=@"0";
        labprice.textColor=[UIColor blackColor];
        labprice.textAlignment = NSTextAlignmentRight;
        [viewdi addSubview:labprice];

      
    }else if ([_dystr containsString:@"3"]) {
        self.navigationItem.title=@"入党申请";
          arrayone=@[@"姓    名",@"性    别",@"出生日期",@"手机号",@"身份证号",@"学    历",@"工作单位",@"职   务",@"户籍地址",@"现居地址",@"特长爱好",@"民    族",@"留    言"];
        cellheigh=arrayone.count*46+100;
      [self buttjview];
        
    }else{
        self.navigationItem.title=@"党员关系转接";
        arrayone=@[@"姓名",@"手机号",@"民族",@"身份证号",@"入党时间",@"党费缴纳截止",@"原支部",@"现支部",@"档案归属地"];
        cellheigh=arrayone.count*46+100;
        [self buttjview];

        
    }
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
-(void)buttjview{
    buttj=[[UIButton alloc]initWithFrame:CGRectMake((Screen_Width-100)/2, Screen_height-100, 100, 35)];
    buttj.backgroundColor=[UIColor redColor];
    
    [buttj.layer setMasksToBounds:YES];
    [buttj setTitle:@"提   交" forState:UIControlStateNormal];
    //  [login setFont:[UIFont systemFontOfSize:13]];
    buttj.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    buttj.backgroundColor=[UIColor redColor];
    [buttj.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
    [buttj addTarget:self action:@selector(loginyuan) forControlEvents:UIControlEventTouchUpInside];
    [buttj setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:buttj];

}
-(void)buttondesire{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)loginyuan{
    
    if ([_dystr containsString:@"1"]) {
        if (_textFile.text.length!=0 &&_textFile1.text.length!=0 &&_textFile3.text.length!=0&&_textView.text.length!=0 && _dropdownMenu2.BoM.id.length!=0 &&_dropdownMenu1.BoM.id.length!=0&&[butxiala currentTitle].length!=0&&[butxiala currentTitle].length!=0) {
            
            if (_textFile3.text.length != 18){
                [SVProgressHUD showErrorWithStatus:@"你的身份证输入有误"];
                
            }else{
                // 正则表达式判断基本 身份证号是否满足格式
                NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
                //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
                NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
                //如果通过该验证，说明身份证格式正确，但准确性还需计算
                if([identityStringPredicate evaluateWithObject:_textFile3.text]){
                    //** 开始进行校验 *//
                    
                    //将前17位加权因子保存在数组里
                    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
                    
                    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
                    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
                    
                    //用来保存前17位各自乖以加权因子后的总和
                    NSInteger idCardWiSum = 0;
                    for(int i = 0;i < 17;i++) {
                        NSInteger subStrIndex = [[_textFile3.text substringWithRange:NSMakeRange(i, 1)] integerValue];
                        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                        idCardWiSum+= subStrIndex * idCardWiIndex;
                    }
                    
                    //计算出校验码所在数组的位置
                    NSInteger idCardMod=idCardWiSum%11;
                    //得到最后一位身份证号码
                    NSString *idCardLast= [_textFile3.text substringWithRange:NSMakeRange(17, 1)];
                    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
                    NSLog(@"idCardMod==%ld",idCardMod);
                    //if(idCardMod==2) {
                        if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
                                            NSString *strurlpl=[[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=floatingparty&TVInfoId=%@&key=%@&DeptId=%@&name=%@&nation=%@&idcard=%@&joiningTime=%@&formerid=%@&newid=%@&dues=%@&phone=%@&remarks=%@",URL,ddtvinfo,ddkey,Deptid,_textFile.text,_dropdownMenu.NationM.NationId,_textFile3.text,[butxiala currentTitle],_dropdownMenu2.BoM.id,_dropdownMenu1.BoM.id,[butxiala2 currentTitle],_textFile1.text,_textView.text]  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                                            NSLog(@"%@",strurlpl);
                                            [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
                                                NSString *Message=[data objectForKey:@"Message"];
                                                NSLog(@"%@",data);
                                                [SVProgressHUD showSuccessWithStatus:Message];
                                            } failure:^(NSError *error) {
                                                NSLog(@"---------------%@",error);
                                                [SVProgressHUD showErrorWithStatus:@"失败!!"];
                                            }];
                        
                    }
                    else{
                        
                                        NSString *strurlpl=[[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=floatingparty&TVInfoId=%@&key=%@&DeptId=%@&name=%@&nation=%@&idcard=%@&joiningTime=%@&formerid=%@&newid=%@&dues=%@&phone=%@&remarks=%@",URL,ddtvinfo,ddkey,Deptid,_textFile.text,_dropdownMenu.NationM.NationId,_textFile3.text,[butxiala currentTitle],_dropdownMenu2.BoM.id,_dropdownMenu1.BoM.id,[butxiala2 currentTitle],_textFile1.text,_textView.text]  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                                        NSLog(@"%@",strurlpl);
                                        [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
                                            NSString *Message=[data objectForKey:@"Message"];
                                            NSLog(@"%@",data);
                                            [SVProgressHUD showSuccessWithStatus:Message];
                                        } failure:^(NSError *error) {
                                            NSLog(@"---------------%@",error);
                                            [SVProgressHUD showErrorWithStatus:@"失败!!"];
                                        }];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"你的身份证输入有误"];
                    
                }
                
                
            }
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"请检查"];
            
        }
    }else  if ([_dystr containsString:@"2"]) {
        if (_textFile.text.length!=0) {
            if (_textFile1.text.length != 18){
                [SVProgressHUD showErrorWithStatus:@"你的身份证输入有误"];
                
            }else{
                // 正则表达式判断基本 身份证号是否满足格式
                NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
                //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
                NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
                //如果通过该验证，说明身份证格式正确，但准确性还需计算
                if([identityStringPredicate evaluateWithObject:_textFile1.text]){
                    //** 开始进行校验 *//
                    
                    //将前17位加权因子保存在数组里
                    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
                    
                    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
                    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
                    
                    //用来保存前17位各自乖以加权因子后的总和
                    NSInteger idCardWiSum = 0;
                    for(int i = 0;i <17;i++) {
                        NSInteger subStrIndex = [[_textFile1.text substringWithRange:NSMakeRange(i, 1)] integerValue];
                        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                        idCardWiSum+= subStrIndex * idCardWiIndex;
                    }
                    
                    //计算出校验码所在数组的位置
                    NSInteger idCardMod=idCardWiSum%11;
                    //得到最后一位身份证号码
                    NSString *idCardLast= [_textFile1.text substringWithRange:NSMakeRange(17, 1)];
                    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
                    NSLog(@"idCardMod==%ld",idCardMod);

                        if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
                            
                            [[WebClient sharedClient] interface:ddtvinfo Keys:ddkey idcard:_textFile1.text name:_textFile.text ResponseBlock:^(id resultObject, NSError *error) {
                                strcx=@"pass";
                                NSLog(@"resultObject==%@",resultObject);
                                NSString *Message=  [resultObject objectForKey:@"Message"];
                               [SVProgressHUD showSuccessWithStatus:Message];
                                    _dataArray=[DfcxModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]];
                                addmoArray=[[resultObject objectForKey:@"Data"] valueForKey:@"Payable"];
                            
                                for(int i=0;i<addmoArray.count;i++)
                                {
                                    zj=[addmoArray[i] floatValue];
                                    for(int j=0;j<i;j++)
                                    {
                                        zj=zj+ [addmoArray[j] floatValue];
                                        
                                    }
                                    
                                }
                                labprice.text=[NSString stringWithFormat:@"¥%.2f",zj];
                                NSLog(@"=====%@====%.2f",addmoArray,zj);
                                [tableView reloadData];
                          
                                
                            }];

    
                    }else{
                        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
//                        if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
                        
                        [[WebClient sharedClient] interface:ddtvinfo Keys:ddkey idcard:_textFile1.text name:_textFile.text ResponseBlock:^(id resultObject, NSError *error) {
                             strcx=@"pass";
                            NSLog(@"resultObject==%@",resultObject);
                            addmoArray=[[resultObject objectForKey:@"Data"] valueForKey:@"Payable"];
                            
                            for(int i=0;i<addmoArray.count;i++)
                            {
                                zj=[addmoArray[i] floatValue];
                                for(int j=0;j<i;j++)
                                {
                                    zj=zj+ [addmoArray[j] floatValue];
                                    
                                }
                                
                            }
                            NSLog(@"=====%@====%.2f",addmoArray,zj);
                             labprice.text=[NSString stringWithFormat:@"¥%.2f",zj];
                            NSString *Message=  [resultObject objectForKey:@"Message"];
                            [SVProgressHUD showSuccessWithStatus:Message];
                            _dataArray=[DfcxModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]];
                            [tableView reloadData];
                            
                            
                        }];
                        
                     
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"你的身份证输入有误"];
                    
                }
                
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"你的姓名输入有误"];
        }
        
    }else  if ([_dystr containsString:@"3"]) {
     if (_textFile.text.length!=0 &&_textFile1.text.length!=0 && _textFile2.text.length!=0 &&_textFile3.text.length!=0  &&_textFile4.text.length!=0  &&_textView.text.length!=0 &&_textFile5.text.length!=0 && _dropdownMenu1.LecwM.levelId.length!=0 &&_dropdownMenu.NationM.NationId.length!=0&&_textFile6.text.length!=0&&_textFile7.text.length!=0&&sex.length!=0&&[butxiala currentTitle].length!=0) {
            
            if (_textFile4.text.length!= 18){
                [SVProgressHUD showErrorWithStatus:@"你的身份证输入有误"];
                
            }else{
                // 正则表达式判断基本 身份证号是否满足格式
                NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
                //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
                NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
                //如果通过该验证，说明身份证格式正确，但准确性还需计算
                if([identityStringPredicate evaluateWithObject:_textFile4.text]){
                    //** 开始进行校验 *//
                    
                    //将前17位加权因子保存在数组里
                    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
                    
                    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
                    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
                    
                    //用来保存前17位各自乖以加权因子后的总和
                    NSInteger idCardWiSum = 0;
                    for(int i = 0;i < 17;i++) {
                        NSInteger subStrIndex = [[_textFile4.text substringWithRange:NSMakeRange(i, 1)] integerValue];
                        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                        idCardWiSum+= subStrIndex * idCardWiIndex;
                    }
                    
                    //计算出校验码所在数组的位置
                    NSInteger idCardMod=idCardWiSum%11;
                    //得到最后一位身份证号码
                    NSString *idCardLast= [_textFile4.text substringWithRange:NSMakeRange(17, 1)];
                    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
                 
                    if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
                        NSString *strurlpl=[[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=party_application&TVInfoId=%@&key=%@&DeptId=%@&name=%@&sex=%@&birthday=%@&idcard=%@&phone=%@&levelId=%@&unit=%@&job=%@&idcardaddress=%@&address=%@&content=%@&nationId=%@&hobby=%@",URL,ddtvinfo,ddkey,Deptid,_textFile.text,sex,[butxiala currentTitle],_textFile4.text,_textFile2.text,_dropdownMenu1.LecwM.levelId,_textFile1.text,_textFile5.text,_textFile2.text,_textFile6.text,_textFile7.text,_dropdownMenu.NationM.NationId,_textView.text]  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                        NSLog(@"%@",strurlpl);
                        [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
                            NSString *Message=[data objectForKey:@"Message"];
                            NSLog(@"%@",data);
                            [SVProgressHUD showWithStatus:Message];
                        } failure:^(NSError *error) {
                            NSLog(@"---------------%@",error);
                            [SVProgressHUD showErrorWithStatus:@"失败!!"];
                        }];
                        
                        
                    }else{
                    
                        NSString *strurlpl=[[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=party_application&TVInfoId=%@&key=%@&DeptId=%@&name=%@&sex=%@&birthday=%@&idcard=%@&phone=%@&levelId=%@&unit=%@&job=%@&idcardaddress=%@&address=%@&content=%@&nationId=%@&hobby=%@",URL,ddtvinfo,ddkey,Deptid,_textFile.text,sex,[butxiala currentTitle],_textFile4.text,_textFile2.text,_dropdownMenu1.LecwM.levelId,_textFile1.text,_textFile5.text,_textFile2.text,_textFile6.text,_textFile7.text,_dropdownMenu.NationM.NationId,_textView.text]  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                        [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
                            NSString *Message=[data objectForKey:@"Message"];
                            NSLog(@"%@",data);
                        [SVProgressHUD showSuccessWithStatus:Message];
                            
                        } failure:^(NSError *error) {
                            NSLog(@"---------------%@",error);
                            [SVProgressHUD showErrorWithStatus:@"失败!!"];
                        }];
                        
                        
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"你的身份证输入有误"];
                    
                }
                
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"不能为空，请检查！！"];
        }
        
    }else{
        if (_textFile.text.length!=0 &&_textFile1.text.length!=0 &&_textFile3.text.length!=0&&_textFile4.text.length!=0 && _dropdownMenu2.BoM.id.length!=0 &&_dropdownMenu1.BoM.id.length!=0&&[butxiala currentTitle].length!=0&&[butxiala currentTitle].length!=0) {
            
            if (_textFile3.text.length != 18){
                [SVProgressHUD showErrorWithStatus:@"你的身份证输入有误"];
                
            }else{
                // 正则表达式判断基本 身份证号是否满足格式
                NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
                //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
                NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
                //如果通过该验证，说明身份证格式正确，但准确性还需计算
                if([identityStringPredicate evaluateWithObject:_textFile3.text]){
                    //** 开始进行校验 *//
                    
                    //将前17位加权因子保存在数组里
                    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
                    
                    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
                    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
                    
                    //用来保存前17位各自乖以加权因子后的总和
                    NSInteger idCardWiSum = 0;
                    for(int i = 0;i < 17;i++) {
                        NSInteger subStrIndex = [[_textFile3.text substringWithRange:NSMakeRange(i, 1)] integerValue];
                        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                        idCardWiSum+= subStrIndex * idCardWiIndex;
                    }
                    
                    //计算出校验码所在数组的位置
                    NSInteger idCardMod=idCardWiSum%11;
                    //得到最后一位身份证号码
                    NSString *idCardLast= [_textFile3.text substringWithRange:NSMakeRange(17, 1)];
                    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
                    NSLog(@"idCardMod==%ld",idCardMod);
                    //if(idCardMod==2) {
                    if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
//                        String url =Url.URL_PT  + "method=switching"
//                        + "&TVInfoId=" + SharedPrefsUtil.getString(this, "TVInfoId")
//                        + "&key=" + SharedPrefsUtil.getString(this, "Key")
//                        + "&DeptId=" + SharedPrefsUtil.getString(this, "DeptId")
//                        + "&name=" + etUserName.getText().toString().trim()
//                        + "&nationId=" + choseMinzuId//民族id
//                        + "&idCard=" + etCardNum.getText().toString().trim()//身份证
//                        + "&organizationName=" + OpinionClassId_zb[checkedItem_zb_old]//原支部
//                        + "&noworganiza=" + OpinionClassId_zb[checkedItem_zb_now]//现支部
//                        + "&phone=" + etPhone.getText().toString()//手机号
//                        + "&joinPatyDate=" + tvRdDate.getText().toString().trim()//入党时间
//                        + "&attribution=" + etContent.getText().toString().trim()//档案归属地
//                        + "&dues=" + tvJfDate.getText().toString().trim();//党费缴纳时间
                        NSString *strurlpl=[[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=switching&TVInfoId=%@&key=%@&DeptId=%@&name=%@&nationId=%@&idCard=%@&joinPatyDate=%@&organizationName=%@&noworganiza=%@&dues=%@&phone=%@&attribution=%@",URL,ddtvinfo,ddkey,Deptid,_textFile.text,_dropdownMenu.NationM.NationId,_textFile3.text,[butxiala currentTitle],_dropdownMenu2.BoM.id,_dropdownMenu1.BoM.id,[butxiala2 currentTitle],_textFile1.text,_textFile4.text]  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                        NSLog(@"%@",strurlpl);
                        [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
                            NSString *Message=[data objectForKey:@"Message"];
                            NSLog(@"%@",data);
                            [SVProgressHUD showSuccessWithStatus:Message];
                        } failure:^(NSError *error) {
                            NSLog(@"---------------%@",error);
                            [SVProgressHUD showErrorWithStatus:@"失败!!"];
                        }];
                        
                    }
                    else{
                    NSString *strurlpl=[[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=switching&TVInfoId=%@&key=%@&DeptId=%@&name=%@&nationId=%@&idCard=%@&joinPatyDate=%@&organizationName=%@&noworganiza=%@&dues=%@&phone=%@&attribution=%@",URL,ddtvinfo,ddkey,Deptid,_textFile.text,_dropdownMenu.NationM.NationId,_textFile3.text,[butxiala currentTitle],_dropdownMenu2.BoM.id,_dropdownMenu1.BoM.id,[butxiala2 currentTitle],_textFile1.text,_textFile4.text]  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                        NSLog(@"%@",strurlpl);
                        [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
                            NSString *Message=[data objectForKey:@"Message"];
                            NSLog(@"%@",data);
                            [SVProgressHUD showSuccessWithStatus:Message];
                        } failure:^(NSError *error) {
                            NSLog(@"---------------%@",error);
                            [SVProgressHUD showErrorWithStatus:@"失败!!"];
                        }];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"你的身份证输入有误"];
                    
                }
                
                
            }
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"请检查！！"];
            
        }

    }
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"开始编辑。");
    _placeholderLabel.text = @"";
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"结束编辑。");
    
    //模仿UTextField的placeholder属性
    if (self.textView.text.length == 0) {
        _placeholderLabel.text = @"请输入内容";
    }else{
        _placeholderLabel.text = @"";
    }
}
- (void)initTableView {
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,Screen_Width,Screen_height-100) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DfcxTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];

   
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   
    if (section==0) {
        return 1;
    }else{
        return _dataArray.count;
        
        
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"=========================%ld",cellheigh);
    if (indexPath.section==0) {
         return cellheigh;
    }else{
        return 44;
    
    
    }
   

    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
   
    static NSString *CellIdenti =@"Cellh";
    //定义cell的复用性当处理大量数据时减少内存开销
    UITableViewCell *cellsw = [tableView  dequeueReusableCellWithIdentifier:CellIdenti];
    
    if (cellsw ==nil)
    {
        cellsw = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdenti];
    }
    [cellsw setSelectionStyle:UITableViewCellSelectionStyleNone];
    //判断传过来的值是否为1，如果是加载1对应的页面
    if ([_dystr containsString:@"1"]) {
       
        for (int i=0; i<arrayone.count; i++) {
             page= i/1;
            UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (45)+10, Screen_Width/4, 35)];
            labzhum.textColor=[UIColor blackColor];
            labzhum.font=[UIFont systemFontOfSize:12.0f];
            labzhum.text=arrayone[i];
            labzhum.textAlignment = UITextAlignmentCenter;
            [cellsw addSubview:labzhum];
        }
        _textFile= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/3.8+10,10, Screen_Width/1.6 ,35)];
        _textFile.backgroundColor = [UIColor whiteColor];
        _textFile.font = [UIFont systemFontOfSize:14.f];
        _textFile.textColor = [UIColor blackColor];
        _textFile.textAlignment = NSTextAlignmentLeft;
        _textFile.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile.placeholder = @"请输入姓名";
        _textFile.layer.borderWidth= 1.0f;
        [cellsw addSubview:_textFile];
        _textFile1= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/3.8+10,55, Screen_Width/1.6 ,35)];
        _textFile1.backgroundColor = [UIColor whiteColor];
        _textFile1.font = [UIFont systemFontOfSize:14.f];
        _textFile1.textColor = [UIColor blackColor];
        _textFile1.textAlignment = NSTextAlignmentLeft;
        _textFile1.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile1.placeholder = @"请输入手机号";
        _textFile1.layer.borderWidth= 1.0f;
        [cellsw addSubview:_textFile1];
        [[WebClient sharedClient] nation:ddtvinfo Keys:ddkey deptid:Deptid ResponseBlock:^(id resultObject, NSError *error) {
            
            NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
            NSMutableArray *muarray=[resultObject objectForKey:@"Data" ];
            NSLog(@"%@",muarray);
            
            _dropdownMenu= [[LMJDropdownMenu alloc] init];
            [_dropdownMenu setFrame:CGRectMake( Screen_Width/3.8+10,100, Screen_Width/1.6, 35)];
            [_dropdownMenu setMenuTitles:muarray rowHeight:30];
            _dropdownMenu.layer.borderColor=RGBColor(230, 233, 233).CGColor;
            NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu.mainBtn.currentTitle );
            _dropdownMenu.layer.borderWidth= 1.0f;
            //传值到_dropdownMenu页面判断
            _dropdownMenu.strpand=@"Nation";
            _dropdownMenu.delegate = self;
            [cellsw addSubview:_dropdownMenu];
        }];
        _textFile3= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/3.8+10, 145, Screen_Width/1.6 ,35)];
        _textFile3.backgroundColor = [UIColor whiteColor];
        _textFile3.font = [UIFont systemFontOfSize:14.f];
        _textFile3.textColor = [UIColor blackColor];
        _textFile3.textAlignment = NSTextAlignmentLeft;
        _textFile3.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile3.placeholder = @"请输入身份证号";
        _textFile3.layer.borderWidth= 1.0f;
        
        [cellsw addSubview:_textFile3];
        butxiala=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/3.8+10, 190,Screen_Width/1.6, 35)];
        butxiala.backgroundColor=[UIColor whiteColor];
        [butxiala setImageEdgeInsets:UIEdgeInsetsMake(5, butxiala.frame.size.width-25, 5, 5)];
        [butxiala setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
        [butxiala setImage:[UIImage imageNamed:@"2"]forState:UIControlStateNormal];
        [butxiala setTitle:@"请选择" forState:UIControlStateNormal];
        butxiala.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [butxiala setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        butxiala.font=[UIFont systemFontOfSize:14.0f];
        [butxiala.layer setBorderWidth:1.0];   //边框宽度
        [butxiala addTarget:self action:@selector(butxialaClick) forControlEvents:UIControlEventTouchUpInside];
        [butxiala.layer setBorderColor:RGBColor(238, 238, 238).CGColor];//边框颜色
        [cellsw addSubview:butxiala];
        butxiala2=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/3.8+10, 235,Screen_Width/1.6, 35)];
        butxiala2.backgroundColor=[UIColor whiteColor];
        [butxiala2 setImageEdgeInsets:UIEdgeInsetsMake(5, butxiala.frame.size.width-25, 5, 5)];
        [butxiala2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
        [butxiala2 setImage:[UIImage imageNamed:@"2"]forState:UIControlStateNormal];
        [butxiala2 setTitle:@"请选择" forState:UIControlStateNormal];
        butxiala2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [butxiala2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        butxiala2.font=[UIFont systemFontOfSize:14.0f];
        [butxiala2.layer setBorderWidth:1.0];   //边框宽度
        [butxiala2 addTarget:self action:@selector(butxiala2Click) forControlEvents:UIControlEventTouchUpInside];
        [butxiala2.layer setBorderColor:RGBColor(238, 238, 238).CGColor];//边框颜色
        [cellsw addSubview:butxiala2];
        
        
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10,arrayone.count*45, Screen_Width-20, 100)];
        [cellsw addSubview:self.textView];
        self.textView.delegate = self;
        //设置文本
        //    self.textView.text = @"我是UITextView，大家欢迎使用。";
        //设置文字对齐方式属性
        self.textView.textAlignment = NSTextAlignmentLeft;
        //设置文字对齐方
        //设置文字颜色属性
        self.textView.textColor = [UIColor blackColor];
        //设置文字字体属性
        self.textView.font = [UIFont systemFontOfSize:12.0f];
        //设置编辑使能属性,是否允许编辑（=NO时，只用来显示，依然可以使用选择和拷贝功能）
        self.textView.editable = YES;
        //设置圆角、边框属性
        self.textView.layer.cornerRadius = 1.0f;
        self.textView.layer.borderWidth = 1;
        self.textView.layer.borderColor =[UIColor grayColor].CGColor;
        
        //模仿UTextField的placeholder属性
        _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.textView.frame), 20)];
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.textColor = [UIColor grayColor];
        _placeholderLabel.text = @"请输入内容";
        _placeholderLabel.font = self.textView.font;
        [self.textView addSubview:_placeholderLabel];
        NSString *strurlpl=[[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=branch&TVInfoId=%@&key=%@&DeptId=%@",URL,ddtvinfo,ddkey,Deptid]  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
            NSLog(@"%@",data);
            NSMutableArray *muarraydsa=[data objectForKey:@"Data" ];
              NSLog(@"====%@",muarraydsa);
            _dropdownMenu2= [[LMJDropdownMenu alloc] init];
            
            [_dropdownMenu2 setFrame:CGRectMake( Screen_Width/3.8+10,280, Screen_Width/1.6, 35)];
            [_dropdownMenu2 setMenuTitles:muarraydsa rowHeight:30];
            _dropdownMenu2.layer.borderColor=RGBColor(230, 233, 233).CGColor;
            NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu2.mainBtn.currentTitle );
            _dropdownMenu2.layer.borderWidth= 1.0f;
            //传值到_dropdownMenu页面判断
            _dropdownMenu2.strpand=@"organize";
            _dropdownMenu2.delegate = self;
            [cellsw addSubview:_dropdownMenu2];
            
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"失败!!"];
        }];
        NSString *strurlpl2=[[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=branch&TVInfoId=%@&key=%@&DeptId=%@",URL,ddtvinfo,ddkey,Deptid]  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [ZQLNetWork getWithUrlString:strurlpl2 success:^(id data) {
            NSMutableArray *muarraycer=[data objectForKey:@"Data" ];
            NSLog(@"%@",muarraycer);
            
            _dropdownMenu1= [[LMJDropdownMenu alloc] init];
            [_dropdownMenu1 setFrame:CGRectMake(10+Screen_Width/3.8,325, Screen_Width/1.6, 35)];
            [_dropdownMenu1 setMenuTitles:muarraycer rowHeight:30];
            _dropdownMenu1.layer.borderColor=RGBColor(230, 233, 233).CGColor;
            //            NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu.mainBtn.currentTitle );
            _dropdownMenu1.layer.borderWidth= 1.0f;
            //传值到_dropdownMenu页面判断
            _dropdownMenu1.strpand=@"organize";
            _dropdownMenu1.delegate = self;
            [cellsw addSubview:_dropdownMenu1];
            
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"失败!!"];
        }];

  


        
    }else if ([_dystr containsString:@"2"])
    {
        for (int i=0; i<arrayone.count; i++) {
            NSInteger page = i/1;
            UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (45)+10, Screen_Width/4.5, 35)];
            labzhum.textColor=[UIColor blackColor];
            labzhum.font=[UIFont systemFontOfSize:14.0f];
            labzhum.text=arrayone[i];
            labzhum.textAlignment = NSTextAlignmentCenter;
            [cellsw addSubview:labzhum];
        }
        _textFile= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/3.8+10,10, Screen_Width/1.6 ,35)];
        _textFile.backgroundColor = [UIColor whiteColor];
        _textFile.font = [UIFont systemFontOfSize:14.f];
        _textFile.textColor = [UIColor blackColor];
        _textFile.textAlignment = NSTextAlignmentLeft;
        _textFile.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile.placeholder = @"请输入姓名";
        _textFile.layer.borderWidth= 1.0f;
        [cellsw addSubview:_textFile];
        _textFile1= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/3.8+10,55, Screen_Width/1.6 ,35)];
        _textFile1.backgroundColor = [UIColor whiteColor];
        _textFile1.font = [UIFont systemFontOfSize:14.f];
        _textFile1.textColor = [UIColor blackColor];
        _textFile1.textAlignment = NSTextAlignmentLeft;
        _textFile1.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile1.placeholder = @"请输入身份证号";
        _textFile1.layer.borderWidth= 1.0f;
        [cellsw addSubview:_textFile1];
        buttj=[[UIButton alloc]initWithFrame:CGRectMake((Screen_Width-100)/2,110,100, 30)];
        buttj.backgroundColor=[UIColor redColor];
        
        [buttj.layer setMasksToBounds:YES];
        [buttj setTitle:@"查    询" forState:UIControlStateNormal];
        //  [login setFont:[UIFont systemFontOfSize:13]];
        buttj.titleLabel.font = [UIFont systemFontOfSize: 13.0];
        buttj.backgroundColor=[UIColor redColor];
        [buttj.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
        [buttj addTarget:self action:@selector(loginyuan) forControlEvents:UIControlEventTouchUpInside];
        [buttj setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cellsw addSubview:buttj];
        
    }else if ([_dystr containsString:@"3"])
    {
        for (int i=0; i<arrayone.count; i++) {
            NSInteger page = i/1;
            UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (45)+10, Screen_Width/4.5, 35)];
            labzhum.textColor=[UIColor blackColor];
            labzhum.font=[UIFont systemFontOfSize:13.0f];
            labzhum.text=arrayone[i];
            labzhum.textAlignment = NSTextAlignmentCenter;
            [cellsw addSubview:labzhum];
        }
        _textFile= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,10, Screen_Width/1.6 ,35)];
        _textFile.backgroundColor = [UIColor whiteColor];
        _textFile.font = [UIFont systemFontOfSize:14.f];
        _textFile.textColor = [UIColor blackColor];
        _textFile.textAlignment = NSTextAlignmentLeft;
        _textFile.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile.placeholder = @"请输入姓名";
        _textFile.layer.borderWidth= 1.0f;
        [cellsw addSubview:_textFile];
        butxiala=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/4.3+10, 100,Screen_Width/1.6, 35)];
        butxiala.backgroundColor=[UIColor whiteColor];
        [butxiala setImageEdgeInsets:UIEdgeInsetsMake(5, butxiala.frame.size.width-25, 5, 5)];
        [butxiala setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
        [butxiala setImage:[UIImage imageNamed:@"2"]forState:UIControlStateNormal];
        [butxiala setTitle:@"请选择" forState:UIControlStateNormal];
        butxiala.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [butxiala setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        butxiala.font=[UIFont systemFontOfSize:14.0f];
        [butxiala.layer setBorderWidth:1.0];   //边框宽度
        [butxiala addTarget:self action:@selector(butxialaClick) forControlEvents:UIControlEventTouchUpInside];
        [butxiala.layer setBorderColor:RGBColor(238, 238, 238).CGColor];//边框颜色
        [cellsw addSubview:butxiala];
        _textFile1= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,280, Screen_Width/1.6 ,35)];
        _textFile1.backgroundColor = [UIColor whiteColor];
        _textFile1.font = [UIFont systemFontOfSize:14.f];
        _textFile1.textColor = [UIColor blackColor];
        _textFile1.textAlignment = NSTextAlignmentLeft;
        _textFile1.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile1.placeholder = @"请输入工作单位";
        _textFile1.layer.borderWidth= 1.0f;
        [cellsw addSubview:_textFile1];
        butxb=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/4.3+10, 55,Screen_Width/1.6, 35)];
        butxb.backgroundColor=[UIColor whiteColor];
        [butxb setImageEdgeInsets:UIEdgeInsetsMake(5, butxiala.frame.size.width-20, 5, 5)];
        [butxb setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 40)];
        [butxb setImage:[UIImage imageNamed:@"向右箭头"]forState:UIControlStateNormal];
        [butxb setTitle:@"请选择" forState:UIControlStateNormal];
        butxb.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [butxb setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        butxb.font=[UIFont systemFontOfSize:14.0f];
        [butxb.layer setBorderWidth:1.0];   //边框宽度
        [butxb addTarget:self action:@selector(butxbClick) forControlEvents:UIControlEventTouchUpInside];
        [butxb.layer setBorderColor:RGBColor(238, 238, 238).CGColor];//边框颜色
        [cellsw addSubview:butxb];
        _textFile3= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 145, Screen_Width/1.6 ,35)];
        _textFile3.backgroundColor = [UIColor whiteColor];
        _textFile3.font = [UIFont systemFontOfSize:14.f];
        _textFile3.textColor = [UIColor blackColor];
        _textFile3.textAlignment = NSTextAlignmentLeft;
        _textFile3.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile3.placeholder = @"请输入手机号";
        _textFile3.layer.borderWidth= 1.0f;
        
        [cellsw addSubview:_textFile3];
        
        _textFile4= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 190, Screen_Width/1.6 ,35)];
        _textFile4.backgroundColor = [UIColor whiteColor];
        _textFile4.font = [UIFont systemFontOfSize:14.f];
        _textFile4.textColor = [UIColor blackColor];
        _textFile4.textAlignment = NSTextAlignmentLeft;
        _textFile4.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile4.placeholder = @"请输入身份证号";
        _textFile4.layer.borderWidth= 1.0f;
        [cellsw addSubview:_textFile4];
        _textFile5= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 325, Screen_Width/1.6 ,35)];
        _textFile5.backgroundColor = [UIColor whiteColor];
        _textFile5.font = [UIFont systemFontOfSize:14.f];
        _textFile5.textColor = [UIColor blackColor];
        _textFile5.textAlignment = NSTextAlignmentLeft;
        _textFile5.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile5.placeholder = @"请输入职务";
        _textFile5.layer.borderWidth= 1.0f;
        [cellsw addSubview:_textFile5];
        _textFile2= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 370, Screen_Width/1.6 ,35)];
        _textFile2.backgroundColor = [UIColor whiteColor];
        _textFile2.font = [UIFont systemFontOfSize:14.f];
        _textFile2.textColor = [UIColor blackColor];
        _textFile2.textAlignment = NSTextAlignmentLeft;
        _textFile2.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile2.placeholder = @"请输入身份证地址";
        _textFile2.layer.borderWidth= 1.0f;
        [cellsw addSubview:_textFile2];
        _textFile6= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 415, Screen_Width/1.6 ,35)];
        _textFile6.backgroundColor = [UIColor whiteColor];
        _textFile6.font = [UIFont systemFontOfSize:14.f];
        _textFile6.textColor = [UIColor blackColor];
        _textFile6.textAlignment = NSTextAlignmentLeft;
        _textFile6.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile6.placeholder = @"请输入现居地址";
        _textFile6.layer.borderWidth= 1.0f;
        [cellsw addSubview:_textFile6];
        _textFile7= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 460, Screen_Width/1.6 ,35)];
        _textFile7.backgroundColor = [UIColor whiteColor];
        _textFile7.font = [UIFont systemFontOfSize:14.f];
        _textFile7.textColor = [UIColor blackColor];
        _textFile7.textAlignment = NSTextAlignmentLeft;
        _textFile7.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile7.placeholder = @"请输入特长爱好";
        _textFile7.layer.borderWidth= 1.0f;
        [cellsw addSubview:_textFile7];
        [[WebClient sharedClient] nation:ddtvinfo Keys:ddkey deptid:Deptid ResponseBlock:^(id resultObject, NSError *error) {
            
            NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
            NSMutableArray *muarray=[resultObject objectForKey:@"Data" ];
            NSLog(@"%@",muarray);
            
            _dropdownMenu= [[LMJDropdownMenu alloc] init];
            [_dropdownMenu setFrame:CGRectMake( Screen_Width/4.3+10,505, Screen_Width/1.6, 35)];
            [_dropdownMenu setMenuTitles:muarray rowHeight:30];
            _dropdownMenu.layer.borderColor=RGBColor(230, 233, 233).CGColor;
            NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu.mainBtn.currentTitle );
            _dropdownMenu.layer.borderWidth= 1.0f;
            //传值到_dropdownMenu页面判断
            _dropdownMenu.strpand=@"Nation";
            _dropdownMenu.delegate = self;
            [cellsw addSubview:_dropdownMenu];
        }];
        [[WebClient sharedClient] culturelevel:ddtvinfo Keys:ddkey deptid:Deptid ResponseBlock:^(id resultObject, NSError *error) {
            NSLog(@"LMJDropdownMenuLMJDropdownMenu===%@",resultObject);
            NSMutableArray *muarray=[resultObject objectForKey:@"Data" ];
            NSLog(@"%@",muarray);
            
            _dropdownMenu1= [[LMJDropdownMenu alloc] init];
            [_dropdownMenu1 setFrame:CGRectMake(10+Screen_Width/4.3,235, Screen_Width/1.6, 35)];
            [_dropdownMenu1 setMenuTitles:muarray rowHeight:30];
            _dropdownMenu1.layer.borderColor=RGBColor(230, 233, 233).CGColor;
            //            NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu.mainBtn.currentTitle );
            _dropdownMenu1.layer.borderWidth= 1.0f;
            //传值到_dropdownMenu页面判断
            _dropdownMenu1.strpand=@"one";
            _dropdownMenu1.delegate = self;
            [cellsw addSubview:_dropdownMenu1];
        }];
        
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10,arrayone.count*45, Screen_Width-20, 100)];
        [cellsw addSubview:self.textView];
        self.textView.delegate = self;
        //设置文本
        //    self.textView.text = @"我是UITextView，大家欢迎使用。";
        //设置文字对齐方式属性
        self.textView.textAlignment = NSTextAlignmentLeft;
        //设置文字对齐方
        //设置文字颜色属性
        self.textView.textColor = [UIColor blackColor];
        //设置文字字体属性
        self.textView.font = [UIFont systemFontOfSize:12.0f];
        //设置编辑使能属性,是否允许编辑（=NO时，只用来显示，依然可以使用选择和拷贝功能）
        self.textView.editable = YES;
        //设置圆角、边框属性
        self.textView.layer.cornerRadius = 1.0f;
        self.textView.layer.borderWidth = 1;
        self.textView.layer.borderColor =[UIColor grayColor].CGColor;
        
        //模仿UTextField的placeholder属性
        _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.textView.frame), 20)];
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.textColor = [UIColor grayColor];
        _placeholderLabel.text = @"请输入内容";
        _placeholderLabel.font = self.textView.font;
        [self.textView addSubview:_placeholderLabel];
        
        

    
    }else{
        for (int i=0; i<arrayone.count; i++) {
            NSInteger page = i/1;
            UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (45)+10, Screen_Width/4, 35)];
            labzhum.textColor=[UIColor blackColor];
            labzhum.font=[UIFont systemFontOfSize:13.0f];
            labzhum.text=arrayone[i];
            labzhum.textAlignment = NSTextAlignmentCenter;
            [cellsw addSubview:labzhum];
        }
        _textFile= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/3.8+10,10, Screen_Width/1.6 ,35)];
        _textFile.backgroundColor = [UIColor whiteColor];
        _textFile.font = [UIFont systemFontOfSize:14.f];
        _textFile.textColor = [UIColor blackColor];
        _textFile.textAlignment = NSTextAlignmentLeft;
        _textFile.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile.placeholder = @"请输入姓名";
        _textFile.layer.borderWidth= 1.0f;
        [cellsw addSubview:_textFile];
        _textFile1= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/3.8+10,55, Screen_Width/1.6 ,35)];
        _textFile1.backgroundColor = [UIColor whiteColor];
        _textFile1.font = [UIFont systemFontOfSize:14.f];
        _textFile1.textColor = [UIColor blackColor];
        _textFile1.textAlignment = NSTextAlignmentLeft;
        _textFile1.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile1.placeholder = @"请输入手机号";
        _textFile1.layer.borderWidth= 1.0f;
        [cellsw addSubview:_textFile1];
        [[WebClient sharedClient] nation:ddtvinfo Keys:ddkey deptid:Deptid ResponseBlock:^(id resultObject, NSError *error) {
            
            NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
            NSMutableArray *muarray=[resultObject objectForKey:@"Data" ];
            NSLog(@"%@",muarray);
            
            _dropdownMenu= [[LMJDropdownMenu alloc] init];
            [_dropdownMenu setFrame:CGRectMake( Screen_Width/3.8+10,100, Screen_Width/1.6, 35)];
            [_dropdownMenu setMenuTitles:muarray rowHeight:30];
            _dropdownMenu.layer.borderColor=RGBColor(230, 233, 233).CGColor;
            NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu.mainBtn.currentTitle );
            _dropdownMenu.layer.borderWidth= 1.0f;
            //传值到_dropdownMenu页面判断
            _dropdownMenu.strpand=@"Nation";
            _dropdownMenu.delegate = self;
            [cellsw addSubview:_dropdownMenu];
        }];
        _textFile3= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/3.8+10, 145, Screen_Width/1.6 ,35)];
        _textFile3.backgroundColor = [UIColor whiteColor];
        _textFile3.font = [UIFont systemFontOfSize:14.f];
        _textFile3.textColor = [UIColor blackColor];
        _textFile3.textAlignment = NSTextAlignmentLeft;
        _textFile3.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile3.placeholder = @"请输入身份证号";
        _textFile3.layer.borderWidth= 1.0f;
        
        [cellsw addSubview:_textFile3];
        butxiala=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/3.8+10, 190,Screen_Width/1.6, 35)];
        butxiala.backgroundColor=[UIColor whiteColor];
        [butxiala setImageEdgeInsets:UIEdgeInsetsMake(5, butxiala.frame.size.width-25, 5, 5)];
        [butxiala setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
        [butxiala setImage:[UIImage imageNamed:@"2"]forState:UIControlStateNormal];
        [butxiala setTitle:@"请选择" forState:UIControlStateNormal];
        butxiala.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [butxiala setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        butxiala.font=[UIFont systemFontOfSize:14.0f];
        [butxiala.layer setBorderWidth:1.0];   //边框宽度
        [butxiala addTarget:self action:@selector(butxialaClick) forControlEvents:UIControlEventTouchUpInside];
        [butxiala.layer setBorderColor:RGBColor(238, 238, 238).CGColor];//边框颜色
        [cellsw addSubview:butxiala];
        butxiala2=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/3.8+10, 235,Screen_Width/1.6, 35)];
        butxiala2.backgroundColor=[UIColor whiteColor];
        [butxiala2 setImageEdgeInsets:UIEdgeInsetsMake(5, butxiala.frame.size.width-25, 5, 5)];
        [butxiala2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
        [butxiala2 setImage:[UIImage imageNamed:@"2"]forState:UIControlStateNormal];
        [butxiala2 setTitle:@"请选择" forState:UIControlStateNormal];
        butxiala2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [butxiala2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        butxiala2.font=[UIFont systemFontOfSize:14.0f];
        [butxiala2.layer setBorderWidth:1.0];   //边框宽度
        [butxiala2 addTarget:self action:@selector(butxiala2Click) forControlEvents:UIControlEventTouchUpInside];
        [butxiala2.layer setBorderColor:RGBColor(238, 238, 238).CGColor];//边框颜色
        [cellsw addSubview:butxiala2];
        
              NSString *strurlpl=[[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=branch&TVInfoId=%@&key=%@&DeptId=%@",URL,ddtvinfo,ddkey,Deptid]  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
            NSLog(@"%@",data);
            NSMutableArray *muarraydsa=[data objectForKey:@"Data" ];
            NSLog(@"====%@",muarraydsa);
            _dropdownMenu2= [[LMJDropdownMenu alloc] init];
            
            [_dropdownMenu2 setFrame:CGRectMake( Screen_Width/3.8+10,280, Screen_Width/1.6, 35)];
            [_dropdownMenu2 setMenuTitles:muarraydsa rowHeight:30];
            _dropdownMenu2.layer.borderColor=RGBColor(230, 233, 233).CGColor;
            NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu2.mainBtn.currentTitle );
            _dropdownMenu2.layer.borderWidth= 1.0f;
            //传值到_dropdownMenu页面判断
            _dropdownMenu2.strpand=@"organize";
            _dropdownMenu2.delegate = self;
            [cellsw addSubview:_dropdownMenu2];
            
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"失败!!"];
        }];
        _textFile4= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/3.8+10, 370, Screen_Width/1.6 ,35)];
        _textFile4.backgroundColor = [UIColor whiteColor];
        _textFile4.font = [UIFont systemFontOfSize:14.f];
        _textFile4.textColor = [UIColor blackColor];
        _textFile4.textAlignment = NSTextAlignmentLeft;
        _textFile4.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile4.placeholder = @"请输入档案归属地";
        _textFile4.layer.borderWidth= 1.0f;
        [cellsw addSubview:_textFile4];
        NSString *strurlpl2=[[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=branch&TVInfoId=%@&key=%@&DeptId=%@",URL,ddtvinfo,ddkey,Deptid]  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [ZQLNetWork getWithUrlString:strurlpl2 success:^(id data) {
            NSMutableArray *muarraycer=[data objectForKey:@"Data" ];
            NSLog(@"%@",muarraycer);
            
            _dropdownMenu1= [[LMJDropdownMenu alloc] init];
            [_dropdownMenu1 setFrame:CGRectMake(10+Screen_Width/3.8,325, Screen_Width/1.6, 35)];
            [_dropdownMenu1 setMenuTitles:muarraycer rowHeight:30];
            _dropdownMenu1.layer.borderColor=RGBColor(230, 233, 233).CGColor;
            //            NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu.mainBtn.currentTitle );
            _dropdownMenu1.layer.borderWidth= 1.0f;
            //传值到_dropdownMenu页面判断
            _dropdownMenu1.strpand=@"organize";
            _dropdownMenu1.delegate = self;
            [cellsw addSubview:_dropdownMenu1];
            
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"失败!!"];
        }];
        
    }

    return cellsw;
    }else{
        if ([strcx containsString:@"pass"]){
        DfcxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        tableView.separatorStyle = NO;
        cell.DfcxM=_dataArray[indexPath.row];
        return cell;
        }else{
            return nil;

        }
    }
    
}
-(void)butxialaClick{
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *startDate) {
        datas=startDate;
        date2= [startDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
//        strbegin=[[NSString stringWithFormat:@"%@",date]
//                  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSLog(@"时间： %@",strbegin);
        [butxiala setTitle:[NSString stringWithFormat:@"%@",date2] forState:UIControlStateNormal];
        
    }];
    datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
    [datepicker show];
    
}
-(void)butxiala2Click{
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *startDate) {
        datas=startDate;
        date2= [startDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
        //        strbegin=[[NSString stringWithFormat:@"%@",date]
        //                  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //        NSLog(@"时间： %@",strbegin);
        [butxiala2 setTitle:[NSString stringWithFormat:@"%@",date2] forState:UIControlStateNormal];
        
    }];
    datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
    [datepicker show];
    
}
-(void)butxbClick{
 views= [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width,Screen_height)];
    views.backgroundColor = [UIColor blackColor];
    
    views.alpha=0.5;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:views];
//    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
//    [views addGestureRecognizer:singleTap];

    
  allview= [[UIView alloc]initWithFrame:CGRectMake(0, Screen_height/3, Screen_Width,91.5)];
    allview.alpha=1;
    allview.backgroundColor=[UIColor whiteColor];
    aray=@[@"男",@"女"];
    for (int i=0; i<aray.count; i++) {
        page= i/1;
        UIButton *butzhum=[[UIButton alloc]initWithFrame:CGRectMake(0, page * (45.5)+0.5, Screen_Width, 45)];
        butzhum.backgroundColor=[UIColor orangeColor];
        butzhum.tag=i;
        [butzhum setTitle:[NSString stringWithFormat:@"%@",aray[i]] forState:UIControlStateNormal];
        [butzhum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [butzhum addTarget:self action:@selector(butzhum:) forControlEvents:UIControlEventTouchUpInside];
        [allview addSubview:butzhum];
    }
   [window addSubview:allview];

}
- (void)butzhum:(UIButton *)butzhum{
    sex=aray[butzhum.tag];
    [butxb setTitle:[NSString stringWithFormat:@"%@",sex] forState:UIControlStateNormal];
    NSLog(@"%@",[butyzm currentTitle]);
    [views removeFromSuperview];
    [allview removeFromSuperview];
}
/*
 **监听点击事件，当点击非textfiled位置的时候，所有输入法全部收缩
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    //    [self endEditing:YES];
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
