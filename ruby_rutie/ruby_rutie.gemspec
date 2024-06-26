# frozen_string_literal: true

require_relative "lib/ruby_rutie/version"

Gem::Specification.new do |spec|
  spec.name = "ruby_rutie"
  spec.version = RubyRutie::VERSION
  spec.authors = ["Kuba Suder"]
  spec.email = ["jakub.suder@gmail.com"]

  spec.required_ruby_version = ">= 3.0.0"
  spec.summary = "Testing the Ruby-Rust bridge"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rutie', '~> 0.0.4'
end
