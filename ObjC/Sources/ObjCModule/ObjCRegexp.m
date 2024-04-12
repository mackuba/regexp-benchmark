#import "ObjCRegexp.h"

@implementation ObjCRegexp

- (void)run {
  NSError *error;
  NSString *text = [[NSString alloc] initWithContentsOfFile:@"posts.txt" encoding:NSUTF8StringEncoding error:&error];
  if (error) {
    NSLog(@"Error: %@", error);
    return;
  }

  NSArray *posts = [text componentsSeparatedByString:@"\n"];
  NSInteger loops = [[[[NSProcessInfo processInfo] arguments] objectAtIndex:1] integerValue];
  NSInteger matched = 0;

  NSUInteger caseInsensitive = NSRegularExpressionCaseInsensitive;
  NSArray *regexps = @[
    [NSRegularExpression regularExpressionWithPattern:@"linux" options:caseInsensitive error:nil],
    [NSRegularExpression regularExpressionWithPattern:@"debian" options:caseInsensitive error:nil],
    [NSRegularExpression regularExpressionWithPattern:@"ubuntu" options:caseInsensitive error:nil],
    [NSRegularExpression regularExpressionWithPattern:@"\\bredhat\\b" options:caseInsensitive error:nil],
    [NSRegularExpression regularExpressionWithPattern:@"\\bRHEL\\b" options:0 error:nil],
    [NSRegularExpression regularExpressionWithPattern:@"\\bSUSE\\b" options:0 error:nil],
    [NSRegularExpression regularExpressionWithPattern:@"\\bCentOS\\b" options:0 error:nil],
    [NSRegularExpression regularExpressionWithPattern:@"\\bopensuse\\b" options:caseInsensitive error:nil],
    [NSRegularExpression regularExpressionWithPattern:@"\\bslackware\\b" options:caseInsensitive error:nil],
    [NSRegularExpression regularExpressionWithPattern:@"\\bKDE\\b" options:0 error:nil],
    [NSRegularExpression regularExpressionWithPattern:@"\\bGTK\\d?\\b" options:0 error:nil],
    [NSRegularExpression regularExpressionWithPattern:@"#GNOME\\b" options:0 error:nil],
    [NSRegularExpression regularExpressionWithPattern:@"\\bGNOME\\s?\\d+" options:0 error:nil],
    [NSRegularExpression regularExpressionWithPattern:@"\\bkde plasma\\b" options:caseInsensitive error:nil],
    [NSRegularExpression regularExpressionWithPattern:@"apt\\-get" options:0 error:nil],
    [NSRegularExpression regularExpressionWithPattern:@"\\bflatpak\\b" options:caseInsensitive error:nil],
    [NSRegularExpression regularExpressionWithPattern:@"\\b[Xx]org\\b" options:0 error:nil]
  ];

  for (NSInteger i = 0; i < loops; i++) {
    for (NSString *txt in posts) {
      NSRange range = NSMakeRange(0, txt.length);

      for (NSRegularExpression *r in regexps) {
        if ([r firstMatchInString:txt options:0 range:range]) {
          matched++;
        }
      }
    }
  }

  NSLog(@"%ld", matched / loops);
}

@end
