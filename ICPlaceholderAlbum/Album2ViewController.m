//
//  Album2ViewController.m
//  ICPlaceholderAlbum
//
//  Created by Alex Hu on 2020/8/7.
//  Copyright © 2020 alexHu. All rights reserved.
//

#import "Album2ViewController.h"
#import "ICPlaceholderAlbum-Swift.h"

@interface Album2ViewController ()

@property (nonatomic, strong, nullable, readwrite) UIActivityIndicatorView *loadingView;
@property (nonatomic, strong, nullable, readwrite) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong, nullable, readwrite) UICollectionView *collectionView;


@end

@implementation Album2ViewController

- (void)viewDidLoad {
    
    CGFloat const slice = UIScreen.mainScreen.bounds.size.width;
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor: UIColor.whiteColor];
    
    [self.view addSubview:self.collectionView];
    
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
