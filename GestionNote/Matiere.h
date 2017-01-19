//
//  Matiere.h
//  GestionNote
//
//  Created by ios on 26/11/2016.
//  Copyright (c) 2016 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Matiere : NSObject
@property (strong,nonatomic) NSString* nom ;
@property   float note ;
@property   float coef ;
-(id) initMatiereWithName:(NSString*)nom withNote:(float)note withCoef:(float)coef;
-(void)addMatiereToList:(NSMutableArray*)list;
-(void)deleteMatiereFromList:(NSMutableArray*)list;
@end
