#!/usr/bin/env ruby

require 'crystalruby'

module Crystal
  crystalize [loops: :int] => :int
  def run(loops)
    regexps = [
      /linux/i, /debian/i, /ubuntu/i, /\bredhat\b/i, /\bRHEL\b/, /\bSUSE\b/, /\bCentOS\b/, /\bopensuse\b/i,
      /\bslackware\b/i, /\bKDE\b/, /\bGTK\d?\b/, /#GNOME\b/, /\bGNOME\s?\d+/, /\bkde plasma\b/i,
      /apt\-get/, /\bflatpak\b/i, /\b[Xx]org\b/
    ]

    posts = File.read_lines("posts.txt")
    matched = 0

    loops.times do
      posts.each do |txt|
        regexps.each do |r|
          matched += 1 if txt =~ r
        end
      end
    end

    return matched
  end
end

loops = ARGV[0].to_i
matched = Crystal.run(loops)
puts matched / loops
