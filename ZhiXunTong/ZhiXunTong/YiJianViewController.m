//
//  YiJianViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/9/11.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "YiJianViewController.h"
#import "PchHeader.h"
#define MAXSTRINGLENGTH 500
@interface YiJianViewController ()<UITextViewDelegate>{
    UILabel *_placeholderLabel;
    UIButton *buttj;
    NSString *ddtvinfo;
    NSString *ddkey;
    NSString *aaid;
    NSString *Deptid;
    NSString *userid;
     NSDictionary *userinfo;
    NSString *myurl;
}
@property (nonatomic, strong) UIScrollView *mianScrollView;
@property (strong ,nonatomic)UITextView *textView;
@property (nonatomic,strong) NSMutableArray * photoArr;

@end

@implementation YiJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"意见反馈";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
     userinfo=[userDefaults objectForKey:UserInfo];
    ddtvinfo=[userDefaults objectForKey:TVInfoId];
    ddkey=[userDefaults objectForKey:Key];
    Deptid=[userDefaults objectForKey:DeptId];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    userid=[[arry objectAtIndex:0] objectForKey:@"id"];
    [self inittable];
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
-(void)inittable{
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(5,10, Screen_Width-10, Screen_height/3.5)];
    [self.view addSubview:self.textView];
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
    
    _placeholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,Screen_height/3.5-20, Screen_Width-15, 20)];
    _placeholderLabel.text=@"500/500";
    _placeholderLabel.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:_placeholderLabel];
  
    
    buttj=[[UIButton alloc]initWithFrame:CGRectMake((Screen_Width-100)/2, Screen_height-100, 100, 35)];
    buttj.backgroundColor=[UIColor redColor];
    
    [buttj.layer setMasksToBounds:YES];
    [buttj setTitle:@"提   交" forState:UIControlStateNormal];
    //  [login setFont:[UIFont systemFontOfSize:13]];
    buttj.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    buttj.backgroundColor=[UIColor redColor];
    [buttj.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
    [buttj addTarget:self action:@selector(buttjyuan) forControlEvents:UIControlEventTouchUpInside];
    [buttj setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:buttj];

    _mianScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, Screen_height/3.5+10, Screen_Width, 90)];
    _mianScrollView.contentSize =CGSizeMake(Screen_Width, 90);
    _mianScrollView.bounces =YES;
    _mianScrollView.showsVerticalScrollIndicator = false;
    _mianScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_mianScrollView];
    [_mianScrollView setDelegate:self];
    self.showInView = _mianScrollView;
    
    /** 初始化collectionView */
    [self initPickerView];
 
}
#pragma mark - text view delegate
- (void)textViewDidChange:(UITextView *)textView
{
    NSString *lang = [[[UITextInputMode activeInputModes] firstObject] primaryLanguage];//当前的输入模式
    if ([lang isEqualToString:@"zh-Hans"])
    {
        UITextRange *range = [textView markedTextRange];
        UITextPosition *start = range.start;
        UITextPosition*end = range.end;
        NSInteger selectLength = [textView offsetFromPosition:start toPosition:end];
        NSInteger contentLength = textView.text.length - selectLength;
        
        if (contentLength > MAXSTRINGLENGTH)
        {
            textView.text = [textView.text substringToIndex:MAXSTRINGLENGTH];
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"最长限制500个字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        }
        if (contentLength < MAXSTRINGLENGTH)
        {
            _placeholderLabel.text = [NSString stringWithFormat:@"%ld/500", MAXSTRINGLENGTH - contentLength];
        }
        else
        {
            _placeholderLabel.text = @"0/500";
        }
    }
    else
    {
        if (textView.text.length > MAXSTRINGLENGTH)
        {
            textView.text = [textView.text substringToIndex:MAXSTRINGLENGTH];
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"最长限制500个字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        }
        _placeholderLabel.text = [NSString stringWithFormat:@"%ld/500", MAXSTRINGLENGTH-textView.text.length];
    }
}
-(void)buttjyuan
{
    NSLog(@"发表");
    self.photoArr = [[NSMutableArray alloc] initWithArray:[self getBigImageArray]];
    NSLog(@"%@",self.photoArr);
    NSString *strurl=[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=tp&TVInfoId=%@&Key=%@",URL,ddtvinfo,ddkey];
    NSString *encodedValue = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    for(NSInteger i = 0; i < self.photoArr.count; i++)
    {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 20;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
        __block NSInteger blockI = i;
        [manager POST:encodedValue parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            //取出单张图片二进制数据
            id obj = self.photoArr[blockI];
            UIImage *image = nil;
            if ([obj isKindOfClass:[UIImage class]]) {
                image = (UIImage *)obj;
            }else{
                image = [UIImage imageWithContentsOfFile:obj];
            }
            if (image) {
                
                UIImage *image = self.photoArr[i];
                NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
                // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                // 要解决此问题，
                // 可以在上传时使用当前的系统事件作为文件名
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                [formatter setDateFormat:@"yyyyMMddHHmmss"];
                NSString *dateString = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
                /*
                 *该方法的参数
                 1. appendPartWithFileData：要上传的照片[二进制流]
                 2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
                 3. fileName：要保存在服务器上的文件名
                 4. mimeType：上传的文件的类型
                 */
                [formData appendPartWithFileData:imageData name:@"mFile" fileName:fileName mimeType:@"image/jpeg"]; //
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            NSLog(@"progress is %@",uploadProgress);
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //            success(responseObject);
            NSLog(@"成功---%@",responseObject);
            NSLog(@"%@",[responseObject objectForKey:@"URL"]);
            myurl=[NSString stringWithFormat:@"%@%@",URL,[responseObject objectForKey:@"URL"]];
            [self lokiedate];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //            failure(error);
            [SVProgressHUD showErrorWithStatus:@"提交失败"];
            NSLog(@"失败---%@",error);
        }];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)lokiedate{
    NSLog(@"%@",myurl);
    NSString *strurlphone=[[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=feedbackadd&TVInfoId=%@&Key=%@&userid=%@&content=%@&image=%@",URL,ddtvinfo,ddkey,userid,_textView.text,myurl]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",strurlphone);
    [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
         NSString *Message=[data objectForKey:@"Message"];

            [SVProgressHUD showSuccessWithStatus:Message];

      
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);

    }];
}
@end
