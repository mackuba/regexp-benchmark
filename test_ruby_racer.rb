#!/usr/bin/env ruby

require 'mini_racer'

worker_script = %(
  const regexps = [
    /linux/i, /debian/i, /ubuntu/i, /\\bredhat\\b/i, /\\bRHEL\\b/, /\\bSUSE\\b/, /\\bCentOS\\b/, /\\bopensuse\\b/i,
    /\\bslackware\\b/i, /\\bKDE\\b/, /\\bGTK\\d?\\b/, /#GNOME\\b/, /\\bGNOME\\s?\\d+/, /\\bkde plasma\\b/i,
    /apt\\-get/, /\\bflatpak\\b/i, /\\b[Xx]org\\b/
  ];

  function matchLines(lines) {
    return lines.map((line) => regexps.some((r) => r.test(line)));
  }
)

posts = File.read('posts.txt').lines

loops = ARGV[0].to_i
matched = 0

js = MiniRacer::Context.new
js.eval(worker_script, filename: 'worker.js')

loops.times do
  matched += js.call('matchLines', posts).select { |r| r == 1 }.length

  # posts.each do |txt|
  #   if js.call('matchLine', txt)
  #     matched += 1
  #   end
  # end
end

puts matched / loops
