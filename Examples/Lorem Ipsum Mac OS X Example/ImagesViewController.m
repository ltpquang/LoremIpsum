/*
 *        __                                 ____
 *       / /   ____  ________  ____ ___     /  _/___  _______  ______ ___
 *      / /   / __ \/ ___/ _ \/ __ `__ \    / // __ \/ ___/ / / / __ `__ \
 *     / /___/ /_/ / /  /  __/ / / / / /  _/ // /_/ (__  ) /_/ / / / / / /
 *    /_____/\____/_/   \___/_/ /_/ /_/  /___/ .___/____/\__,_/_/ /_/ /_/
 *                                          /_/
 *
 *                            ImagesViewController.m
 *                   http://github.com/lukaskubanek/LoremIpsum
 *             2013-2014 (c) Lukas Kubanek (http://lukaskubanek.com)
 */

#import "ImagesViewController.h"
#import "LoremIpsum.h"

@interface NSArray (LoremIpsum)

- (id)li_randomObject;

@end

@interface ImagesViewController ()

@property (weak) IBOutlet NSImageView *imageView;
@property (weak) IBOutlet NSTextField *informationLabel;

@end

@implementation ImagesViewController

- (void)awakeFromNib
{
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self loadImage:nil];
}

- (IBAction)loadImage:(id)sender
{
    NSArray *services = @[@(LIPlaceholderImageServiceLoremPixel),
            @(LIPlaceholderImageServiceDummyImage),
            @(LIPlaceholderImageServicePlaceKitten),
            @(LIPlaceholderImageServiceHhhhold)];
    LIPlaceholderImageService service = (LIPlaceholderImageService)[[services li_randomObject] intValue];
    NSSize size = NSMakeSize(MAX(70, arc4random() % 420), MAX(70, arc4random() % 420));

    NSString *serviceString = nil;
    if (service == LIPlaceholderImageServiceLoremPixel) {
        serviceString = @"lorempixel.com";
    } else if (service == LIPlaceholderImageServiceDummyImage) {
        serviceString = @"dummyimage.com";
    } else if (service == LIPlaceholderImageServicePlaceKitten) {
        serviceString = @"placekitten.com";
    } else if (service == LIPlaceholderImageServiceHhhhold) {
        serviceString = @"hhhhold.com";
    }

    NSString *information = [NSString stringWithFormat:@"%@ %0.fx%0.f", serviceString, size.width, size.height];

    [LoremIpsum asyncPlaceholderImageFromService:service
                                        withSize:size
                                      completion:^(NSImage *image) {
        self.imageView.image = image;
        self.informationLabel.stringValue = information;
    }];
}

@end
