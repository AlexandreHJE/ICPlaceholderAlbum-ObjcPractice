//
//  HomePageViewController.m
//  ICPlaceholderAlbum
//
//  Created by Alex Hu on 2020/8/7.
//  Copyright © 2020 alexHu. All rights reserved.
//

#import "HomePageViewController.h"
#import "ICPlaceholderAlbum-Swift.h"

@interface HomePageViewController ()

@property (nonatomic, strong, nullable, readwrite) UIButton *requestApiButton;
//Setter, Getter, iVar
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = UIColor.whiteColor;
    [self.view setBackgroundColor:UIColor.whiteColor];
    
    //Property
    [self.view addSubview:self.requestApiButton];
    [[self.requestApiButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor] setActive:YES];
    [[self.requestApiButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
    
    DataManager *manager = DataManager.shared;
    [manager getAlbumJSONWithSuccess:^(NSArray<ICPPhotoContent *> * _Nonnull contents) {
        for (ICPPhotoContent *content in contents) {
            NSLog(@"%@",  content);
            NSLog(@"%ld", (long)content.albumId);
            NSLog(@"%ld", (long)content.id);
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - Selector

- (void)p_pushAlbumView:(UIButton *)button {
    AlbumViewController *vc = [[AlbumViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getter

- (UIButton *)requestApiButton {
    //iVar
    if (!_requestApiButton) {
        _requestApiButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_requestApiButton setTitle:@"Request Photo Api" forState:UIControlStateNormal];
        [_requestApiButton addTarget:self action:@selector(p_pushAlbumView:) forControlEvents:UIControlEventTouchUpInside];
        [_requestApiButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_requestApiButton sizeToFit];
    }
    return _requestApiButton;
}

//#pragma mark - Setter
//
//- (void)setRequestApiButton:(UIButton *)requestApiButton {
//    _requestApiButton = requestApiButton;
//}

@end
