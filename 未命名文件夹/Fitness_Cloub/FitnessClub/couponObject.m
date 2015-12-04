//
//  couponObject.m
//  FitnessClub
//
//  Created by QAQ on 15/12/4.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "couponObject.h"

@implementation couponObject
- (id)initWithDictionary:(NSDictionary *)dic {
    
    _enddate = [[dic objectForKey:@"endDate"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"endDate"];
    _logo = [[dic objectForKey:@"eLogo"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"eLogo"];
    _name = [[dic objectForKey:@"eClubName"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"eClubName"];
    _usedate=[[dic objectForKey:@"useDate"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"useDate"];
    _tel=[[dic objectForKey:@"clubTel"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"clubTel"];
    return self;
}
@end
