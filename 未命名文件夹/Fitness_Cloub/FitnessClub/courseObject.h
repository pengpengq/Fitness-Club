//
//  courseObject.h
//  FitnessClub
//
//  Created by 米老头 on 15/11/26.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface courseObject : NSObject
@property(strong,nonatomic)NSString *eLogo;
@property(strong,nonatomic)NSString *eFeature;
@property(strong,nonatomic)NSString *useDate;
@property(strong,nonatomic)NSString *eClubName;
@property(strong,nonatomic)NSString *clubTel;
@property(strong,nonatomic)NSString *eName;
@property (strong, nonatomic) NSNumber *orginPrice;
@property (strong, nonatomic) NSNumber *currentPrice;
@property (strong, nonatomic) NSString *eAddress;
- (id)initWithDictionary:(NSDictionary *)dic;
@end

