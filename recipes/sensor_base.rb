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
