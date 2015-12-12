//
//  searchObject.h
//  FitnessClub
//
//  Created by 米山 on 15/12/10.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface searchObject : NSObject
//@property (strong, nonatomic) NSString *imageV;
@property (strong, nonatomic) NSString *clubName;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
