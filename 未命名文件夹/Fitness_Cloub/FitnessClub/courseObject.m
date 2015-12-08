//
//  courseObject.m
//  FitnessClub
//
//  Created by 米老头 on 15/11/26.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "courseObject.h"

@implementation courseObject
- (id)initWithDictionary:(NSDictionary *)dic {
    
    _eLogo = [[dic objectForKey:@"eLogo"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"eLogo"];
    _eAddress = [[dic objectForKey:@"eAddress"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"eAddress"];
    _eName = [[dic objectForKey:@"eName"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"eName"];
    _useDate = [[dic objectForKey:@"useDate"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"useDate"];
    _eFeature = [[dic objectForKey:@"eFeature"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"eFeature"];
    _eClubName = [[dic objectForKey:@"eClubName"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"eClubName"];
    _currentPrice = [[dic objectForKey:@"currentPrice"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"currentPrice"];
    _orginPrice = [[dic objectForKey:@"orginPrice"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"orginPrice"];
    _clubTel    =   [[dic objectForKey:@"clubTel"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"clubTel"];
    return self;
}

@end
