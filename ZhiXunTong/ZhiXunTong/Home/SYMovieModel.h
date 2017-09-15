//
//  SYMovieModel.h
//  Exer
//
//  Created by Sauchye on 14-9-5.
//  Copyright (c) 2014年 Sauchye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYMovieModel : NSObject

@property (nonatomic, strong)NSString *movieName;
@property (nonatomic, strong)NSString *movieYear;
@property (nonatomic, strong)NSString *movieImage;
@property (nonatomic, strong)NSString *movieId;
@property (nonatomic, strong)NSString *moviefangyaun;

@property (nonatomic, strong)NSString *movieSc;
-(id)initWithName:(NSString *)aName;
@end
