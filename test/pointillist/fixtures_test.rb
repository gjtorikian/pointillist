require "test_helper"

class Pointillist::FixturesTest < Test::Unit::TestCase

  RUBY_CODE = "#!/usr/bin/ruby\nputs 'foo'"
  RUBY_CODE_TRAILING_NEWLINE = "#!/usr/bin/ruby\nputs 'foo'\n"
  REDIS_CODE = File.read(File.join(File.dirname(__FILE__), 'fixtures', 'test_data.c'))
  COFEESCRIPT_CODE = File.read(File.join(File.dirname(__FILE__), 'fixtures', 'test_data.coffee'))
  RUBY_CODE = File.read(File.join(File.dirname(__FILE__), 'fixtures', 'test_data.rb'))

  def test_highlight_defaults_to_html
    code = Pointillist.highlight(RUBY_CODE, "Ruby")

    assert_match '<span class="c1"><span class="c">#</span> -*- coding: utf-8 -*-</span>', code
    assert_equal '<div class', code[0..9]
  end

end
