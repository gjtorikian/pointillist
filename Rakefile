#!/usr/bin/env rake
require "bundler/gem_tasks"
require "rake/testtask"
require "fileutils"
require 'benchmark'

task :default => :test

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

def language_to_ul(language_to_data)
  contents = %|<ul class="dropdown-menu" role="menu">|
  contents << language_to_data.keys.map do |language|
    %|<li><a href="#{language}.html">#{language}</a></li>|
  end.join("\n")
  contents << "</ul>"
end

desc "Generate samples site"
task :publish do
  require "pygments"
  require File.expand_path('../lib/pointillist', __FILE__)

  language_to_data = {}
  Dir.glob("test/pointillist/fixtures/test_*.*") do |file|
    language = File.basename(file).split("_")[1].split(".")[0]
    file_data = File.read(file)
    language_to_data[language] = file_data
  end

  files_to_copy = []

  index_template = File.read("docs/_templates/index.html")
  lang_template = File.read("docs/_templates/language.html")

  index = File.new(File.join("#{Dir.tmpdir}", "index.html"), "w+")
  index.write(index_template.sub("{{ language_list }}", language_to_ul(language_to_data)))
  files_to_copy << index.path
  index.close

  language_to_data.each do |language, file_data|
    lang = File.new(File.join("#{Dir.tmpdir}", "#{language}.html"), "w+")
    contents = lang_template.sub("{{ language_list }}", language_to_ul(language_to_data))
    contents = contents.gsub("{{ language_name }}", language)

    pointillist_render = pygments_render = nil
    pointillist_time = Benchmark.realtime do
      pointillist_render = Pointillist.highlight(file_data, language)
    end
    contents = contents.sub("{{ POINTILLIST_OUTPUT }}", pointillist_render)
    contents = contents.sub("{{ pointillist_benchmark }}", pointillist_time.to_s)
    pygments_time = Benchmark.realtime do
      pygments_render = Pygments.highlight(file_data, :lexer => language.downcase)
    end
    contents = contents.sub("{{ PYGMENTS_OUTPUT }}", pygments_render)
    contents = contents.sub("{{ pygments_benchmark }}", pygments_time.to_s)

    lang.write(contents)
    files_to_copy << lang.path
    lang.close
  end

  system "git checkout gh-pages"
  message = "Site updated at #{Time.now.utc}"
  files_to_copy.each { |file| FileUtils.copy(file, ".") }
  if ENV['nope'].nil?
    system "git add ."
    system "git commit -am #{message.shellescape}"
    system "git push origin gh-pages --force"
    system "git checkout master"
    system "echo yolo"
  end
end
