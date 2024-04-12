import Foundation

static let regexps = [
  /linux/i, /debian/i, /ubuntu/i, /\bredhat\b/i, /\bRHEL\b/, /\bSUSE\b/, /\bCentOS\b/, /\bopensuse\b/i,
  /\bslackware\b/i, /\bKDE\b/, /\bGTK\d?\b/, /#GNOME\b/, /\bGNOME\s?\d+/, /\bkde plasma\b/i,
  /apt\-get/, /\bflatpak\b/i, /\b[Xx]org\b/
]

let posts = try! String(contentsOfFile: "posts.txt").components(separatedBy: .newlines)
let loops = Int(CommandLine.arguments[1])!
var matched = 0

for _ in 0..<loops {
  for txt in posts {
    let range = NSRange(location: 0, length: txt.utf16.count)

    for r in regexps {
      if txt.contains(r) {
        matched += 1
      }
    }
  }
}

print(matched / loops)
