//
//  couponObject.h
//  FitnessClub
//
//  Created by QAQ on 15/12/4.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface couponObject : NSObject
@property (strong, nonatomic) NSString *logo;
@property (strong, nonatomic) NSString *tel;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *enddate;
@property (strong, nonatomic) NSString *usedate;
- (id)initWithDictionary:(NSDictionary *)dic;@end
