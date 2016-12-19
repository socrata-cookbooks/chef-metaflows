# encoding: utf-8
# frozen_string_literal: true
#
# Cookbook Name:: chef-metaflows
# Recipe:: sensor_base
#

# Perform the initial operations needed to build a Metaflows image.

%w(
  yum-chef
  sshd
  runit
).each do |r|
  include_recipe r
end

package 'cloud-init'

include_recipe 'rbenv'
include_recipe 'rbenv::ruby_build'

rbenv_ruby '2.3.3' do
  global true
end

rbenv_gem 'aws-sdk' do
  ruby_version '2.3.3'
end
