//
//  myCollectionObject.m
//  FitnessClub
//
//  Created by QAQ on 15/12/9.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "myCollectionObject.h"

@implementation myCollectionObject
- (id)initWithDictionary:(NSDictionary *)dic {
    
    _distance = [[dic objectForKey:@"distance"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"distance"];
    _image = [[dic objectForKey:@"clubImage"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"clubImage"];
    _name = [[dic objectForKey:@"clubName"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"clubName"];
    _address=[[dic objectForKey:@"clubAddress"] isKindOfClass:[NSNull class]] ? @"":[dic objectForKey:@"clubAddress"];
    
    return self;
}
@end
