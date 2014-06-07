#!/usr/bin/env rake
require "bundler/gem_tasks"
require "rake/testtask"
require "fileutils"

task :default => :test

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

def language_to_ul(language_to_data)
  contents = "<ul>"
  contents << language_to_data.keys.map do |language|
    %|<li><a href="#{language}.html">#{language}</a></li>|
  end
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

  index = Tempfile.new('index.html')
  index.write(index_template.sub("{{ language_list }}", language_to_ul(language_to_data)))
  files_to_copy << index.path

  language_to_data.each do |language, file_data|
    lang = Tempfile.new("#{language}.html")
    contents = lang_template.sub("{{ language_list }}", language_to_ul(language_to_data)))
    contents = contents.sub("{{ POINTILLIST_OUTPUT }}", Pygments.highlight(file_data, :lexer => language.downcase))
    contents = contents.sub("{{ PYGMENTS_OUTPUT }}", Pointillist.highlight(file_data, language))
    lang.write(contents)
    files_to_copy << lang.path
  end

  system "git checkout gh-pages"
  message = "Site updated at #{Time.now.utc}"
  files_to_copy.each { |file| FileUtils.copy(file, ".") }
  # system "git add ."
  # system "git commit -am #{message.shellescape}"
  # system "git push origin gh-pages --force"
  # system "git checkout master"
  # system "echo yolo"
end
