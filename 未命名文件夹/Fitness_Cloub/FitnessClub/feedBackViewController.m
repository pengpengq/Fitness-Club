//
//  feedBackViewController.m
//  FitnessClub
//
//  Created by 米老头 on 15/11/26.
//  Copyright © 2015年 milaotou. All rights reserved.
//

#import "feedBackViewController.h"
#import "MLKMenuPopover.h"

#define MENU_POPOVER_FRAME  CGRectMake(106, 250, 140, 88)
@interface feedBackViewController ()  <MLKMenuPopoverDelegate>
@property(nonatomic,strong) MLKMenuPopover *menuPopover;
@property(nonatomic,strong) NSArray *menuItems;
@end

@implementation feedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Menu Popover";
    self.menuItems = [NSArray arrayWithObjects:@"确认提交",@"取消提交", nil];
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

- (IBAction)resubmitAction:(UIButton *)sender {

        // Hide already showing popover
        [self.menuPopover dismissMenuPopover];
        
        self.menuPopover = [[MLKMenuPopover alloc] initWithFrame:MENU_POPOVER_FRAME menuItems:self.menuItems];
        
        self.menuPopover.menuPopoverDelegate = self;
        [self.menuPopover showInView:self.view];
        
        
    }
    
    - (void)menuPopover:(MLKMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex
    {
        [self.menuPopover dismissMenuPopover];
        
        NSString *title = [NSString stringWithFormat:@"%@成功.",[self.menuItems objectAtIndex:selectedIndex]];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertView show];
    }

@end
