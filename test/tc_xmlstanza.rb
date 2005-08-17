#!/usr/bin/ruby

$:.unshift '../lib'

require 'test/unit'
require 'socket'
require 'xmpp4r/xmlstanza'
require 'xmpp4r/iq'
include Jabber

class XMLStanzaTest < Test::Unit::TestCase

  def test_from
    x = XMLStanza::new("message")
    assert_equal(nil, x.from)
    assert_equal(x, x.set_from("blop"))
    assert_equal("blop", x.from)
    x.from = "tada"
    assert_equal("tada", x.from)
  end

  def test_to
    x = XMLStanza::new("message")
    assert_equal(nil, x.to)
    assert_equal(x, x.set_to("blop"))
    assert_equal("blop", x.to)
    x.to = "tada"
    assert_equal("tada", x.to)
  end

  def test_id
    x = XMLStanza::new("message")
    assert_equal(nil, x.id)
    assert_equal(x, x.set_id("blop"))
    assert_equal("blop", x.id)
    x.id = "tada"
    assert_equal("tada", x.id)
  end

  def test_type
    x = XMLStanza::new("message")
    assert_equal(nil, x.type)
    assert_equal(x, x.set_type("blop"))
    assert_equal("blop", x.type)
    x.type = "tada"
    assert_equal("tada", x.type)
  end

  def test_import
    x = XMLStanza::new("iq")
    x.id = "heya"
    q = x.add_element("query")
    q.add_namespace("about:blank")
    q.add_element("b").text = "I am b"
    q.add_text("I am text")
    q.add_element("a").add_attribute("href", "http://home.gna.org/xmpp4r/")
    x.add_text("yow")
    x.add_element("query")

    x_s = x.to_s
    iq = Iq.import(x)
    iq_s = iq.to_s
    
    assert_equal(x.id, iq.id)
    assert_equal(q, iq.query)
    assert_equal(x_s, iq_s)
    assert_equal(q.namespace, iq.queryns)
  end
end