# frozen_string_literal: true

path_sep = RUBY_PLATFORM.match?(/mswin|mingw|windows/) ? ';' : ':'
chef_bin = ENV['PATH'].split(path_sep).first

unless chef_bin.end_with?('/chef-workstation/bin', '/cinc-workstation/bin')
  raise('This cookbook requires Chef Workstation or Cinc Workstation')
end

source 'https://repo.socrata.com/artifactory/api/gems/rubygems-virtual'

gem 'kitchen-microwave', path: '/home/ubuntu/kitchen-microwave'

addon_gems = {
  'chefstyle' => nil,
  'cookstyle' => nil,
  'rubocop' => nil,
  # 'strings' => nil,
  # 'unicode-display_width' => nil,
  'test-kitchen' => nil,
  # 'kitchen-microwave' => 'nil',
  'simplecov-console' => nil,
  'chefspec' => nil,
}

File.read("#{chef_bin}/chef").lines.each do |line|
  next unless line.strip.start_with?('gem ')

  name, _, version = line.split('"')[1..3]

  next if addon_gems.key?(name)

  gem name, version
end

addon_gems.each do |name, version|
  gem name, version
end
