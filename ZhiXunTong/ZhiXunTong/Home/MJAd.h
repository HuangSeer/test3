//
//  MJAd.h
//  MJExtensionExample
//
//  Created by MJ Lee on 15/1/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//  广告模型

#import <Foundation/Foundation.h>

@interface MJAd : NSObject
/** 广告图片 */
@property (copy, nonatomic) NSString *ModuName;
/** 广告url */
@property (strong, nonatomic) NSURL *url;
//广告标题
@property (strong, nonatomic) NSString *Message;
//广告ID
@property (strong, nonatomic) NSMutableArray *Data;

@property (strong, nonatomic) NSString *Title;

@property (strong, nonatomic) NSString *NewsShowUrl;
@property (strong, nonatomic) NSString *Agreement;





@end
