//
//  VISPERViewController.h
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IVISPERViewController.h"
#import "IVISPERViewControllerServiceProvider.h"
#import "IVISPERPresenter.h"
#import "UIViewController+VISPER.h"

@interface VISPERViewController : UIViewController<IVISPERViewController>

-(instancetype)initWithServiceProvider:(NSObject<IVISPERViewControllerServiceProvider>*)serviceProvider
                             presenter:(NSObject<IVISPERPresenter>*)presenter;

-(instancetype)initWithCoder:(NSCoder *)aDecoder
             serviceProvider:(NSObject<IVISPERViewControllerServiceProvider>*)serviceProvider
                   presenter:(NSObject<IVISPERPresenter>*)presenter;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil
                        bundle:(NSBundle *)nibBundleOrNil
               serviceProvider:(NSObject<IVISPERViewControllerServiceProvider>*)serviceProvider
                     presenter:(NSObject<IVISPERPresenter>*)presenter;
@end
