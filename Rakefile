#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'

task :default => :test

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end
