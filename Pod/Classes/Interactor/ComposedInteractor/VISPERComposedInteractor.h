//
//  VISPERComposedInteractor.h
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERComposedInteractor.h"
#import "VISPERInteractor.h"

@interface VISPERComposedInteractor : VISPERInteractor<IVISPERComposedInteractor>

@property(nonatomic,strong)IBOutletCollection(NSObject<IVISPERInteractor>) NSArray *interactors;

-(void)addInteractor:(NSObject<IVISPERInteractor>*)interactor;
-(void)removeInteractor:(NSObject<IVISPERInteractor>*)interactor;

@end
