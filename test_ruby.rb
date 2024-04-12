#!/usr/bin/env ruby

regexps = [
  /linux/i, /debian/i, /ubuntu/i, /\bredhat\b/i, /\bRHEL\b/, /\bSUSE\b/, /\bCentOS\b/, /\bopensuse\b/i,
  /\bslackware\b/i, /\bKDE\b/, /\bGTK\d?\b/, /#GNOME\b/, /\bGNOME\s?\d+/, /\bkde plasma\b/i,
  /apt\-get/, /\bflatpak\b/i, /\b[Xx]org\b/
]

posts = File.read('posts.txt').lines

loops = ARGV[0].to_i
matched = 0

loops.times do
  posts.each do |txt|
    regexps.each do |r|
      if txt =~ r
        matched += 1
      end
    end
  end
end

puts matched / loops
