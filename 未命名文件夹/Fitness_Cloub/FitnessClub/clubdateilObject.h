//
//  clubdateilObject.h
//  FitnessClub
//
//  Created by 米老头 on 15/12/1.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface clubdateilObject : NSObject
@property (strong, nonatomic) NSString *eName;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *eLogo;
@property (strong, nonatomic) NSNumber *saleCount;
@property (strong, nonatomic) NSNumber *orginPrice;
@property (strong, nonatomic) NSNumber *price;
- (id)initWithDictionary:(NSDictionary *)dic;

@end
