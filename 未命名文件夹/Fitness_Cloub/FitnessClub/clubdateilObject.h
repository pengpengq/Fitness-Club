//
//  clubdateilObject.h
//  FitnessClub
//
//  Created by 米老头 on 15/12/1.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface clubdateilObject : NSObject
@property (strong, nonatomic) NSString *clubAddress;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *saleCount;
@property (strong, nonatomic) NSString *price;
- (id)initWithDictionary:(NSDictionary *)dic;

@end
