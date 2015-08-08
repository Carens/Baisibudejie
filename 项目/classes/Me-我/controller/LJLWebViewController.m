//
//  LJLWebViewController.m
//  项目
//
//  Created by LiJiale on 15/8/8.
//
//

#import "LJLWebViewController.h"
#import <NJKWebViewProgress.h>

@interface LJLWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForItem;

@property (strong,nonatomic) NJKWebViewProgress *progress;

@end

@implementation LJLWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progress;
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress) {
        weakSelf.progressView.progress = progress;
        
        weakSelf.progressView.hidden = (progress == 1.0);
    };
    self.progress.webViewProxyDelegate = self;

    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (IBAction)goBack:(id)sender {
    
    [self.webView goBack];
    
}

- (IBAction)goFor:(id)sender {
    
    [self.webView goForward];
}

- (IBAction)refresh:(id)sender {
    
    [self.webView reload];
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBackItem.enabled = webView.canGoBack;
    self.goForItem.enabled = webView.canGoForward;
}

@end
