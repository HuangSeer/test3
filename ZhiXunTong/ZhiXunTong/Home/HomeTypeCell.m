//
//  HomeTypeCell.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/1.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "HomeTypeCell.h"
#import <UIImageView+WebCache.h>

@interface HomeTypeCell()
@property (weak, nonatomic) IBOutlet UIImageView *ImageLogo;
@property (weak, nonatomic) IBOutlet UILabel *LabelTitle;

@end

@implementation HomeTypeCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    //if (self)
    //{
        return self;
    //}
}
        
        
- (void)setModel:(HotmTypeModel *)model{
    [_ImageLogo sd_setImageWithURL:[NSURL URLWithString:model.ImageUrl] placeholderImage:[UIImage imageNamed:@""]];
    _LabelTitle.text = model.title;
}
@end
