//
//  MoyenneViewController.m
//  GestionNote
//
//  Created by ios on 27/11/2016.
//  Copyright (c) 2016 ios. All rights reserved.
//

#import "MoyenneViewController.h"

@interface MoyenneViewController ()

@end

@implementation MoyenneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self.view setNeedsDisplay];
    // Do any additional setup after loading the view.

    lbMoyenne.text = [NSString stringWithFormat:@"%.02f", _moy];
        NSLog(@"smoyenne %@",lbMoyenne.text);
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
