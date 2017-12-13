//
//  UIViewController+Presenter.h
//  VISPER-UIViewController
//
//  Created by bartel on 13.12.17.
//

#import <UIKit/UIKit.h>
@import VISPER_Presenter;

@interface UIViewController (Presenter)

#pragma mark presenter management
@property (readonly,nonatomic, strong) NSArray  * _Nonnull visperPresenters;

-(void)addVisperPresenter:(NSObject<ViewControllerEventPresenter> * __nonnull)presenter;
-(void)removeVisperPresenter:(NSObject<ViewControllerEventPresenter> *__nonnull)presenter;
-(void)notifyPresentersOfView:(UIView* __nonnull)view
                    withEvent:(NSObject* __nonnull)event;

@end
