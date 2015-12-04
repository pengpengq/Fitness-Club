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
    _name = [[dic objectForKey:@"clubName"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"clubName"];
    _clubAddress= [[dic objectForKey:@"clubAddressB"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"clubAddressB"];
    
    return self;
}
@end
