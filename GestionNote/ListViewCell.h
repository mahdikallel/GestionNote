//
//  ListViewCell.h
//  GestionNote
//
//  Created by ios on 25/11/2016.
//  Copyright (c) 2016 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewCell : UITableViewCell
@property(strong,nonatomic) IBOutlet UILabel* lbMatiere;
@property(strong,nonatomic) IBOutlet UILabel* lbNote;
@property(strong,nonatomic) IBOutlet UILabel* lbCoeff;
@end
