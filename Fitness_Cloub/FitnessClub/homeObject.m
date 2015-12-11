//
//  homeObject.m
//  FitnessClub
//
//  Created by 米老头 on 15/11/25.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "homeObject.h"

@implementation homeObject
- (id)initWithDictionary:(NSDictionary *)dic {
    
   _ImgUrl = [[dic objectForKey:@"image"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"image"];
   _detail = [[dic objectForKey:@"address"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"address"];
     _name = [[dic objectForKey:@"name"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"name"];
    _ID = [[dic objectForKey:@"id"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"id"];
    return self;
}
@end
