#!/usr/bin/env ruby

require 're2'

regexps = [
  RE2('linux', case_sensitive: false),
  RE2('debian', case_sensitive: false),
  RE2('ubuntu', case_sensitive: false),
  RE2('\bredhat\b', case_sensitive: false),
  RE2('\bRHEL\b'), RE2('\bSUSE\b'), RE2('\bCentOS\b'),
  RE2('\bopensuse\b', case_sensitive: false),
  RE2('\bslackware\b', case_sensitive: false),
  RE2('\bKDE\b'), RE2('\bGTK\d?\b'), RE2('#GNOME\b'), RE2('\bGNOME\s?\d+'),
  RE2('\bkde plasma\b', case_sensitive: false),
  RE2('apt\-get'),
  RE2('\bflatpak\b', case_sensitive: false),
  RE2('\b[Xx]org\b')
]

posts = File.read('posts.txt').lines

loops = ARGV[0].to_i
matched = 0

loops.times do
  posts.each do |txt|
    regexps.each do |r|
      if r.partial_match?(txt)
        matched += 1
      end
    end
  end
end

puts matched / loops
