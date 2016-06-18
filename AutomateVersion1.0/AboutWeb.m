//
//  AboutWeb.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 27/04/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "AboutWeb.h"
#import <WebKit/WebKit.h>
@interface AboutWeb ()

@end

@implementation AboutWeb

- (void)viewDidLoad {
    
    NSString *urlString = @"http://www.carm8.com.au";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:urlRequest];

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

@end
