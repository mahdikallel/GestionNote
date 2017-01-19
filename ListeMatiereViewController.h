//
//  ListeMatiereViewController.h
//  GestionNote
//
//  Created by ios on 25/11/2016.
//  Copyright (c) 2016 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoyenneViewController.h"

@interface ListeMatiereViewController : UIViewController<UITableViewDelegate , UITableViewDataSource>
{
    IBOutlet UITableView* listMatiere;
    IBOutlet UIButton* button;
}
@property  MoyenneViewController* moyView ;
@property  float sommeNote;
@property float sommeCoef ;
@end
