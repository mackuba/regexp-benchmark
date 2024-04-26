regexps = [
  Regex.new("linux", Regex::CompileOptions::IGNORE_CASE | Regex::CompileOptions::NO_UTF_CHECK),
  Regex.new("debian", Regex::CompileOptions::IGNORE_CASE | Regex::CompileOptions::NO_UTF_CHECK),
  Regex.new("ubuntu", Regex::CompileOptions::IGNORE_CASE | Regex::CompileOptions::NO_UTF_CHECK),
  Regex.new("\\bredhat\\b", Regex::CompileOptions::IGNORE_CASE | Regex::CompileOptions::NO_UTF_CHECK),
  Regex.new("\\bRHEL\\b", Regex::CompileOptions::NO_UTF_CHECK),
  Regex.new("\\bSUSE\\b", Regex::CompileOptions::NO_UTF_CHECK),
  Regex.new("\\bCentOS\\b", Regex::CompileOptions::NO_UTF_CHECK),
  Regex.new("\\bopensuse\\b", Regex::CompileOptions::IGNORE_CASE | Regex::CompileOptions::NO_UTF_CHECK),
  Regex.new("\\bslackware\\b", Regex::CompileOptions::IGNORE_CASE | Regex::CompileOptions::NO_UTF_CHECK),
  Regex.new("\\bKDE\\b", Regex::CompileOptions::NO_UTF_CHECK),
  Regex.new("\\bGTK\\d?\\b", Regex::CompileOptions::NO_UTF_CHECK),
  Regex.new("#GNOME\\b", Regex::CompileOptions::NO_UTF_CHECK),
  Regex.new("\\bGNOME\\s?\\d+", Regex::CompileOptions::NO_UTF_CHECK),
  Regex.new("\\bkde plasma\\b", Regex::CompileOptions::IGNORE_CASE | Regex::CompileOptions::NO_UTF_CHECK),
  Regex.new("apt\\-get", Regex::CompileOptions::NO_UTF_CHECK),
  Regex.new("\\bflatpak\\b", Regex::CompileOptions::IGNORE_CASE | Regex::CompileOptions::NO_UTF_CHECK),
  Regex.new("\\b[Xx]org\\b", Regex::CompileOptions::NO_UTF_CHECK)
]

posts = File.read_lines("posts.txt")
loops = ARGV[0].to_i
matched = 0

loops.times do
  posts.each do |txt|
    regexps.each do |r|
      matched += 1 if r.match(txt, options: Regex::MatchOptions::NO_UTF_CHECK)
    end
  end
end

puts matched / loops
