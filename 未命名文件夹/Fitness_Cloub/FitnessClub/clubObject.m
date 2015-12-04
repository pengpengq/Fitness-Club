//
//  clubObject.m
//  FitnessClub
//
//  Created by 米老头 on 15/11/26.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "clubObject.h"

@implementation clubObject
- (id)initWithDictionary:(NSDictionary *)dic {
    
    _ImgUrl = [[dic objectForKey:@"image"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"image"];
    _address = [[dic objectForKey:@"address"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"address"];
    _name = [[dic objectForKey:@"name"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"name"];
    _distance= [[dic objectForKey:@"distance"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"distance"];
    _ID = [[dic objectForKey:@"id"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"id"];
    return self;
}
@end
