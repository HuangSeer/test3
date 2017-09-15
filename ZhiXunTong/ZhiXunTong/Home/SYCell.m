//
//  SYCell.m
//  Exer
//
//  Created by Sauchye on 14-9-5.
//  Copyright (c) 2014年 Sauchye. All rights reserved.
//

#import "SYCell.h"
#import "PchHeader.h"

@implementation SYCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _cellView=[[UIView alloc] initWithFrame:CGRectMake(10, 2.5, Screen_Width-20, 75)];
        _cellView.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:_cellView];
        
        _cellXian=[[UIView alloc] initWithFrame:CGRectMake(30, 40, Screen_Width-50, 1)];
        _cellXian.backgroundColor=RGBColor(236, 236, 236);
        [self.contentView addSubview:_cellXian];
        
        //float with = (Screen_Width-100) / 4;
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_cellView addSubview:_topImage];
        
        _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(20,2.5, Screen_Width-50, 30)];
        //_titlelabel.textColor=RGBColor(236, 236, 236);
        _titlelabel.numberOfLines = 2;
        _titlelabel.textAlignment = NSTextAlignmentLeft;
        _titlelabel.font = [UIFont systemFontOfSize:13];
        [_cellView addSubview:_titlelabel];
        
        _addrelabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 45, Screen_Width-50, 30)];
        //_addrelabel.textColor=RGBColor(236, 236, 236);
        _addrelabel.textAlignment = NSTextAlignmentLeft;
        _addrelabel.font=[UIFont systemFontOfSize:13];
        [_cellView addSubview:_addrelabel];
        
        _timlabel=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width-120, 45, 90, 30)];
       // _timlabel.textColor=RGBColor(236, 236, 236);
        _timlabel.textAlignment=NSTextAlignmentRight;
        _timlabel.font=[UIFont systemFontOfSize:13];
        [_cellView addSubview:_timlabel];
    }
    
    return self;
}

@end
