import Foundation

let regexps = [
  try! NSRegularExpression(pattern: "linux", options: .caseInsensitive),
  try! NSRegularExpression(pattern: "debian", options: .caseInsensitive),
  try! NSRegularExpression(pattern: "ubuntu", options: .caseInsensitive),
  try! NSRegularExpression(pattern: "\\bredhat\\b", options: .caseInsensitive),
  try! NSRegularExpression(pattern: "\\bRHEL\\b"),
  try! NSRegularExpression(pattern: "\\bSUSE\\b"),
  try! NSRegularExpression(pattern: "\\bCentOS\\b"),
  try! NSRegularExpression(pattern: "\\bopensuse\\b", options: .caseInsensitive),
  try! NSRegularExpression(pattern: "\\bslackware\\b", options: .caseInsensitive),
  try! NSRegularExpression(pattern: "\\bKDE\\b"),
  try! NSRegularExpression(pattern: "\\bGTK\\d?\\b"),
  try! NSRegularExpression(pattern: "#GNOME\\b"),
  try! NSRegularExpression(pattern: "\\bGNOME\\s?\\d+"),
  try! NSRegularExpression(pattern: "\\bkde plasma\\b", options: .caseInsensitive),
  try! NSRegularExpression(pattern: "apt\\-get"),
  try! NSRegularExpression(pattern: "\\bflatpak\\b", options: .caseInsensitive),
  try! NSRegularExpression(pattern: "\\b[Xx]org\\b")
]

let posts = try! String(contentsOfFile: "posts.txt").components(separatedBy: .newlines)
let loops = Int(CommandLine.arguments[1])!
var matched = 0

for _ in 0..<loops {
  for txt in posts {
    let range = NSRange(location: 0, length: txt.utf16.count)

    for r in regexps {
      if r.firstMatch(in: txt, range: range) != nil {
        matched += 1
      }
    }
  }
}

print(matched / loops)
