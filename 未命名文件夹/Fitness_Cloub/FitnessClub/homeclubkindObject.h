//
//  homeclubkindObject.h
//  FitnessClub
//
//  Created by 米老头 on 15/11/27.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface homeclubkindObject : NSObject
@property (strong, nonatomic) NSString *backimgurl;
@property (strong, nonatomic) NSString *frontImgUrl;
@property (strong, nonatomic) NSString *name;
- (id)initWithDictionary:(NSDictionary *)dic;
@end
