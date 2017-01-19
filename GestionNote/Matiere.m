//
//  Matiere.m
//  GestionNote
//
//  Created by ios on 26/11/2016.
//  Copyright (c) 2016 ios. All rights reserved.
//

#import "Matiere.h"

@implementation Matiere
-(id) initMatiereWithName:(NSString*)nom withNote:(float)note withCoef:(float)coef{
    
    if(self ==[super init])
    {
        self.nom=nom;
        self.note=note;
        self.coef=coef;
    }
    return self ;
}
-(void)addMatiereToList:(NSMutableArray*)list
{
    [list addObject:self];
}
-(void)deleteMatiereFromList:(NSMutableArray*)list
{
    [list removeObject:self];
}



@end
