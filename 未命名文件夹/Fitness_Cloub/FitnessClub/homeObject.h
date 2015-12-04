//
//  homeObject.h
//  FitnessClub
//
//  Created by 米老头 on 15/11/25.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface homeObject : NSObject
@property (strong, nonatomic) NSString *ImgUrl;
@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) NSString *name;
@property(strong,nonatomic)NSString *ID;
- (id)initWithDictionary:(NSDictionary *)dic;
@end
