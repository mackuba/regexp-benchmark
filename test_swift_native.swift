import Foundation

let regexps: [Regex<Substring>] = [
  try! Regex("linux").ignoresCase(),
  try! Regex("debian").ignoresCase(),
  try! Regex("ubuntu").ignoresCase(),
  try! Regex("\\bredhat\\b").ignoresCase(),
  try! Regex("\\bRHEL\\b"),
  try! Regex("\\bSUSE\\b"),
  try! Regex("\\bCentOS\\b"),
  try! Regex("\\bopensuse\\b").ignoresCase(),
  try! Regex("\\bslackware\\b").ignoresCase(),
  try! Regex("\\bKDE\\b"),
  try! Regex("\\bGTK\\d?\\b"),
  try! Regex("#GNOME\\b"),
  try! Regex("\\bGNOME\\s?\\d+"),
  try! Regex("\\bkde plasma\\b").ignoresCase(),
  try! Regex("apt\\-get"),
  try! Regex("\\bflatpak\\b").ignoresCase(),
  try! Regex("\\b[Xx]org\\b")
]

let posts = try! String(contentsOfFile: "posts.txt").components(separatedBy: .newlines)
let loops = Int(CommandLine.arguments[1])!
var matched = 0

for _ in 0..<loops {
  for txt in posts {
    for r in regexps {
      if txt.contains(r) {
        matched += 1
      }
    }
  }
}

print(matched / loops)
