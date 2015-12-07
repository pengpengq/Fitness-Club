//
//  clubdateilObject.m
//  FitnessClub
//
//  Created by 米老头 on 15/12/1.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "clubdateilObject.h"

@implementation clubdateilObject
- (id)initWithDictionary:(NSDictionary *)dic{
    _eName = [[dic objectForKey:@"eName"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"eName"];
    _orginPrice= [[dic objectForKey:@"orginPrice"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"orginPrice"];
    _saleCount=[[dic objectForKey:@"saleCount"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"saleCount"];
    _eLogo=[[dic objectForKey:@"eLogo"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"eLogo"];
_number = [[dic objectForKey:@"number"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"number"];
    _price = [[dic objectForKey:@"price"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"price"];
    return self;
}
@end
