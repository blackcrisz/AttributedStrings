//
//  CardGameViewController.m
//  AttributedStrings
//
//  Created by Cristian on 2/25/13.
//  Copyright (c) 2013 Cristian. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labetText;
@property (weak, nonatomic) IBOutlet UILabel *labelWord;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;

- (NSArray*) numberOfWordsInLabel;
@end

@implementation CardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self changeWord];
}

- (NSArray *)numberOfWordsInLabel
{
    NSArray *wordList = [[self.labetText.attributedText string] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([wordList count])
    {
        return wordList;
    }
    else
    {
        return @[@""];
    }
}

- (NSString*) selectedWord
{
    return [self numberOfWordsInLabel][(int)self.stepper.value];
}

- (IBAction)changeWord
{
    self.stepper.maximumValue = [self numberOfWordsInLabel].count - 1;
    self.labelWord.text = [self selectedWord];
}

- (void)addTextAttributes:(NSDictionary*)attributes range:(NSRange)range
{
    if (range.location != NSNotFound)
    {
        NSMutableAttributedString *mat = [self.labetText.attributedText mutableCopy];
        [mat addAttributes:attributes range:range];
        
        self.labetText.attributedText = mat;
    }
}

- (void)addSelectedWordAttributes:(NSDictionary*)attributes
{
    NSRange wordRange = [[self.labetText.attributedText string] rangeOfString:self.labelWord.text];
    [self addTextAttributes:attributes range:wordRange];
}

- (IBAction)underline
{

    [self addSelectedWordAttributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
}

- (IBAction)nounderline
{
    [self addSelectedWordAttributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone)}];
}
- (IBAction)addColor:(UIButton*)sender
{
    [self addSelectedWordAttributes:@{NSForegroundColorAttributeName : sender.backgroundColor}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
