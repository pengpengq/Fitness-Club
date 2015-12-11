//
//  reservationViewController.m
//  FitnessClub
//
//  Created by 米老头 on 15/11/26.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "reservationViewController.h"
#import "LeafNotification.h"
@interface reservationViewController ()

@end

@implementation reservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
+ (reservationViewController *)sharedCenter
{
    static dispatch_once_t once;
    static reservationViewController *sharedCenter;
    dispatch_once(&once, ^ { sharedCenter = [[reservationViewController alloc] init]; });
    return sharedCenter;
}
- (NSUInteger)cacheSize
{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       NSLog(@"%@", cachPath);
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                   });
    return 0;
}
- (IBAction)clearmemory:(id)sender {
    NSUInteger cacheSize = [[reservationViewController sharedCenter] cacheSize];
    if (cacheSize < 1024)
    {
        _memoryLabel.text = [NSString stringWithFormat: @"%lu B", (unsigned long)cacheSize];
    }
    else if (cacheSize < 1024 * 1024)
    {
        _memoryLabel.text = [NSString stringWithFormat: @"%.2f KB", (cacheSize * 1.0f) / 1024];
    }
    else if (cacheSize < 1024 * 1024 * 1024)
    {
        _memoryLabel.text = [NSString stringWithFormat: @"%.2f MB", (cacheSize * 1.0f) / (1024 * 1024)];
    }
    else
    {
        _memoryLabel.text = [NSString stringWithFormat: @"%.2f GB", (cacheSize * 1.0f) / (1024 * 1024 * 1024)];
    }
    [LeafNotification showInController:self withText:@"清理完成" type:LeafNotificationTypeSuccess];
    
}
@end
