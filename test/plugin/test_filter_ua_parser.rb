require 'helper'

class UaParserFilterTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
    type ua_parser
    key_name user_agent
    delete_key no
    out_key ua
  ]

  def create_driver(conf=CONFIG,tag='test')
    Fluent::Test::FilterTestDriver.new(Fluent::UaParserFilter, tag).configure(conf)
  end

  def test_configure
    d = create_driver(CONFIG)
    assert_equal 'user_agent', d.instance.config['key_name']
    assert_equal 'ua', d.instance.config['out_key']
  end

  def test_emit
    d1 = create_driver(CONFIG)
    ua = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.71 Safari/537.36'
    emit_message = 'error has occoured.'
    emit_extra = {'foo' => {'array' => [1,2,3]}, 'hash' => {'nest' => 'data'}}

    d1.run do
      d1.emit({'user_agent' => ua})
    end
    emits = d1.emits
    assert_equal 1, emits.length
    assert_equal 'test', emits[0][0] # tag
    ua_object = emits[0][2]['ua']
    assert_equal 'Chrome', ua_object['browser']['family']
    assert_equal 46, ua_object['browser']['major_version']
    assert_equal '46.0.2490', ua_object['browser']['version']
    assert_equal 'Windows 7', ua_object['os']['family']
    assert_equal '', ua_object['os']['version']
    assert_equal 'Other', ua_object['device']
  end

end
