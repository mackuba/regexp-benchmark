#!/usr/bin/env ruby

require 'open3'

f = File.read('../posts.txt')
posts = File.read('../posts.txt').lines

loops = ARGV[0].to_i
matched = 0

Open3.popen3("./target/release/rusty_pipe") { |stdin, stdout, stderr, wait_thr|
  reader = Thread.new do
    loop do
      res = stdout.gets
      break if res.nil?

      if res.strip == '1'
        matched += 1
      end
    end
  end

  loops.times do
    stdin.print(f)

    ## send + read each post
    # posts.each do |txt|
    #   stdin.print(txt)
    #   res = stdout.gets.strip
    #   if res == '1'
    #     matched += 1
    #   end
    # end

    ## read after each loop
    # posts.length.times do
    #   res = stdout.gets.strip
    #   if res == '1'
    #     matched += 1
    #   end
    # end
  end

  stdin.close
  reader.join
}

puts matched / loops
