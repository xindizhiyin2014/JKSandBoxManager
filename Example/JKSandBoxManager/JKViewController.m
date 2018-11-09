//
//  JKViewController.m
//  JKSandBoxManager
//
//  Created by HHL110120 on 07/07/2017.
//  Copyright (c) 2017 HHL110120. All rights reserved.
//

#import "JKViewController.h"
#import <JKSandBoxManager/JKSandBoxManager.h>
@interface JKViewController ()

@end

@implementation JKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    NSString *ext = [JKSandBoxManager getPathExtensionWith:@"124.txt"];
//    NSLog(@"ext %@",ext);
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"abcd.png" ofType:nil];
    NSString *directory = [JKSandBoxManager getDirectoryWithFilePath:filePath];
    NSLog(@"directory %@",directory);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
