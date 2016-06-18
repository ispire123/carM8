//
//  ServiceSelectionViewController.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 25/01/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "ServiceSelectionViewController.h"

@interface ServiceSelectionViewController ()

@end

@implementation ServiceSelectionViewController
{
    NSArray *selectionarray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    selectionarray = @[@"Change Oil and Filter", @"Brake Pads replacement"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return selectionarray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [selectionarray objectAtIndex:indexPath.row];
    UITableView *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
