//
//  MenuBarView.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 9/04/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "MenuBarView.h"
#import <Parse/Parse.h>
@interface MenuBarView ()
{
    NSArray *menuItems;
}

@end

@implementation MenuBarView

- (void)viewDidLoad {
    [super viewDidLoad];
    menuItems = @[@"title", @"Account", @"Request Cleaning", @"History", @"Share", @"About", @"Logout"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

   return menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}


- (IBAction)signoutButton:(id)sender {
    [PFUser logOut];
    NSLog(@"The user has logged  out");
    UIStoryboard *dashboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *logback = [dashboard instantiateViewControllerWithIdentifier:@"homeScreen1"];
    //[logback loadView];
    [self presentViewController:logback animated:YES completion:nil];

}
@end
