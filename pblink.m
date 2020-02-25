#import <Cocoa/Cocoa.h>

#define HTML_TEMPLATE "<html><head><meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\"></head><body><a href=\"%s\">%s<a></body></html>"
#define HTML_TEMPLATE_LEN 125

int main(int argc, const char* argv[]) {
  @autoreleasepool {
    if (argc != 3) {
      fprintf(stderr, "Usage: pblink <url> <text>\n");
      return 1;
    }
    const char* url = argv[1];
    const char* text = argv[2];
    const int html_len = HTML_TEMPLATE_LEN + strlen(url) + strlen(text);
    char html[html_len];
    sprintf(html, HTML_TEMPLATE, url, text);
    NSPasteboard* pb = [NSPasteboard generalPasteboard];
    [pb clearContents];
    NSString *str = [NSString stringWithCString:html encoding:NSUTF8StringEncoding];
    if (![pb setString:str forType:NSPasteboardTypeHTML]) {
      fprintf(stderr, "Failed to write HTML to pasteboard\n");
      return 1;
    }
    str = [NSString stringWithCString:text encoding:NSUTF8StringEncoding];
    if (![pb setString:str forType:NSPasteboardTypeString]) {
      fprintf(stderr, "Failed to write String to pasteboard\n");
      return 1;
    }
  }
  return 0;
}
