//
//  myCollectionObject.h
//  FitnessClub
//
//  Created by QAQ on 15/12/9.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myCollectionObject : NSObject
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *distance;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
- (id)initWithDictionary:(NSDictionary *)dic;

@end
