//
//  ViewController.m
//  DSLScratchCard
//
//  Created by 邓顺来 on 16/11/28.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import "ViewController.h"
#import "DSLScratchCard.h"

@interface ViewController ()
{
    DSLScratchCard *_card1;
    __weak IBOutlet DSLScratchCard *_card2;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *reset = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reset:)];
    self.navigationItem.rightBarButtonItem = reset;
    
    _card1 = [DSLScratchCard scratchCardWithHiddenImage:[UIImage imageNamed:@"RMB.jpg"]
                                             coverColor:[UIColor lightGrayColor]
                                             coverImage:nil];
    _card1.frame = CGRectMake(30, 100, [UIScreen mainScreen].bounds.size.width - 60, ([UIScreen mainScreen].bounds.size.width - 60) * 165 / 315);
//    _card1.coverImage = [UIImage imageNamed:@"coverImage.jpg"];
    [self.view addSubview:_card1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reset:(UIBarButtonItem *)sender
{
    [_card1 reset];
    [_card2 reset];
}

@end
