//
//  clubObject.h
//  FitnessClub
//
//  Created by 米老头 on 15/11/26.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface clubObject : NSObject
@property (strong, nonatomic) NSString *ImgUrl;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *name;
@property(strong,nonatomic)NSString *ID;
@property (strong, nonatomic) NSNumber *distance;
- (id)initWithDictionary:(NSDictionary *)dic;
@end
