//
//  MyCollectionViewCell.m
//  ZhiXunTong
//
//  Created by Mou on 2017/5/31.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "PchHeader.h"

@implementation MyCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        float with = (Screen_Width-150) / 4;
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, with, with)];
        [self.contentView addSubview:_topImage];
        _botlabel = [[UILabel alloc] initWithFrame:CGRectMake(-5 , with, with+20, 20)];
        _botlabel.textAlignment = NSTextAlignmentCenter;
        _botlabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:_botlabel];
    }
    
    return self;
}
@end
