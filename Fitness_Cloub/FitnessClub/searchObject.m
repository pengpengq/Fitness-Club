//
//  searchObject.m
//  FitnessClub
//
//  Created by 米山 on 15/12/10.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "searchObject.h"

@implementation searchObject
- (id)initWithDictionary:(NSDictionary *)dic{

    _imageV = [[dic objectForKey:@"clubLogo"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"clubLogo"];
    _clubName = [[dic objectForKey:@"clubName"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"clubName"];

    return self;
}
@end
