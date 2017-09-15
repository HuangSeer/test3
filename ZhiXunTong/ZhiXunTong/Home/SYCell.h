//
//  SYCell.h
//  Exer
//
//  Created by Sauchye on 14-9-5.
//  Copyright (c) 2014年 Sauchye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYCell : UICollectionViewCell

@property (strong,nonatomic) UIView *cellView;
@property (strong,nonatomic) UIView *cellXian;
@property (strong, nonatomic) UIImageView *topImage;
@property (strong, nonatomic) UILabel *titlelabel;

@property (strong, nonatomic) UILabel *addrelabel;
@property (strong, nonatomic) UILabel *timlabel;

@end
