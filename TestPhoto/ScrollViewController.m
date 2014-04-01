//
//  ScrollViewController.m
//  TestPhoto
//
//  Created by Aizawa Takashi on 2014/03/31.
//  Copyright (c) 2014年 Aizawa Takashi. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray* images;
@property NSInteger page;
@property BOOL rotating;
@end

@implementation ScrollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if( self != nil )
    {
        self.images = [[NSMutableArray alloc] init];
        [self.images addObject:[UIImage imageNamed:@"1.jpg"]];
        [self.images addObject:[UIImage imageNamed:@"2.jpg"]];
        [self.images addObject:[UIImage imageNamed:@"3.jpg"]];
        [self.images addObject:[UIImage imageNamed:@"4.jpg"]];
        [self.images addObject:[UIImage imageNamed:@"5.jpg"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGRect frameRect = CGRectMake(0, 0, width, height);
    self.scrollView = [[UIScrollView alloc] initWithFrame:frameRect];

    // 横スクロールのインジケータを非表示にする
    self.scrollView.showsHorizontalScrollIndicator = NO;
    // ページングを有効にする
    self.scrollView.pagingEnabled = YES;
    self.scrollView.autoresizesSubviews = NO;
    
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.delegate = (id)self;
    // スクロールの範囲を設定
    [self.scrollView setContentSize:CGSizeMake((self.images.count * width), height)];
    [self.view addSubview:self.scrollView];
    
    CGFloat realWidth;
    CGFloat realHeight;
    CGFloat imageWidth;
    CGFloat imageHeight;
    for( int i = 0; i < self.images.count; i++ ){
        UIImage* image = self.images[i];
        imageWidth = image.size.width;
        imageHeight = image.size.height;
        if( imageWidth/imageHeight < width/height ){
            realHeight = height;
            realWidth = height*imageWidth/imageHeight;
        }else{
            realWidth = width;
            realHeight = width*imageHeight/imageWidth;
        }
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*realWidth, (height-realHeight)/2, realWidth, realHeight)];
        imageView.image = self.images[i];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.autoresizesSubviews = NO;
        [self.scrollView addSubview:imageView];
    }
    self.page = 0;
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.page;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    if( self.rotating == NO )
        return;
    CGFloat pageWidth = self.scrollView.bounds.size.width;
    if( fmod(self.scrollView.contentOffset.x, pageWidth) == 0 )
    {
        self.page = self.scrollView.contentOffset.x / pageWidth;
        
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGRect rect = self.scrollView.bounds;
    CGFloat newWidth = rect.size.height;
    CGFloat newHeight = rect.size.width;
    for( int i = 0; i < self.images.count; i++ )
    {
        UIImageView* imageView = (UIImageView*)self.scrollView.subviews[ i ];
        CGRect newRect = CGRectMake(newWidth/2+i*newWidth , newHeight/2, 0, 0);
        CGRect rect = newRect;
        imageView.frame = rect;
    }

    //UIImageView* currentImageView = self.scrollView.subviews[self.page];
    //currentImageView.frame = newRect;
    self.rotating = YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    self.rotating = NO;
    self.scrollView.frame = self.view.bounds;
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];

    [self.scrollView setContentSize:CGSizeMake((self.images.count * width), height)];
    CGRect frame = self.scrollView.frame;
    frame.origin.x = width * self.page;
    [self.scrollView scrollRectToVisible:frame animated:NO];

    CGFloat realWidth;
    CGFloat realHeight;
    CGFloat imageWidth;
    CGFloat imageHeight;
    for( int i = 0; i < self.images.count; i++ )
    {
        UIImageView* imageView = (UIImageView*)self.scrollView.subviews[ i ];
        UIImage* image = self.images[i];
        imageWidth = image.size.width;
        imageHeight = image.size.height;
        if( imageWidth/imageHeight < width/height ){
            realHeight = height;
            realWidth = height*imageWidth/imageHeight;
        }else{
            realWidth = width;
            realHeight = width*imageHeight/imageWidth;
        }
        CGRect rect = CGRectMake(i * width+(width-realWidth)/2, (height-realHeight)/2, realWidth, realHeight);
        imageView.frame = rect;
    }
    [UIView commitAnimations];

}
- (void)endAnimation
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
