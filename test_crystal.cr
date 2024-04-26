regexps = [
  Regex.new("linux", Regex::CompileOptions::IGNORE_CASE),
  Regex.new("debian", Regex::CompileOptions::IGNORE_CASE),
  Regex.new("ubuntu", Regex::CompileOptions::IGNORE_CASE),
  Regex.new("\\bredhat\\b", Regex::CompileOptions::IGNORE_CASE),
  Regex.new("\\bRHEL\\b"),
  Regex.new("\\bSUSE\\b"),
  Regex.new("\\bCentOS\\b"),
  Regex.new("\\bopensuse\\b", Regex::CompileOptions::IGNORE_CASE),
  Regex.new("\\bslackware\\b", Regex::CompileOptions::IGNORE_CASE),
  Regex.new("\\bKDE\\b"),
  Regex.new("\\bGTK\\d?\\b"),
  Regex.new("#GNOME\\b"),
  Regex.new("\\bGNOME\\s?\\d+"),
  Regex.new("\\bkde plasma\\b", Regex::CompileOptions::IGNORE_CASE),
  Regex.new("apt\\-get"),
  Regex.new("\\bflatpak\\b", Regex::CompileOptions::IGNORE_CASE),
  Regex.new("\\b[Xx]org\\b")
]

posts = File.read_lines("posts.txt")
loops = ARGV[0].to_i
matched = 0

loops.times do
  posts.each do |txt|
    regexps.each do |r|
      matched += 1 if txt =~ r
    end
  end
end

puts matched / loops
