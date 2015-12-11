//
//  homeclubkindObject.m
//  FitnessClub
//
//  Created by 米老头 on 15/11/27.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "homeclubkindObject.h"

@implementation homeclubkindObject
- (id)initWithDictionary:(NSDictionary *)dic {
    _backimgurl = [[dic objectForKey:@"backImgUrl"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"backImgUrl"];
    _backimgurl = [[dic objectForKey:@"frontImgUrl"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"frontImgUrl"];
    _name = [[dic objectForKey:@"name"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"name"];
    return self;
    
}
@end
