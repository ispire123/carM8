//
//  AboutUsViewController.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 26/04/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "AboutUsViewController.h"
#import "SWRevealViewController.h"
#import <WebKit/WebKit.h>
@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    NSString *urlString = @"http://www.carm8.com.au/contact-us.html";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:urlRequest];
    
    [super viewDidLoad];
    
   // NSURL *url = [NSURL URLWithString:@"www.carm8.com.au/about-us.html"];
  //  NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
   // [_webView loadRequest:requestURL];
    // Do any additional setup after loading the view.
    
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
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
