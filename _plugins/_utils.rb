require 'nokogiri'
require 'singleton'
require 'net/http'
require 'digest/md5'
require 'json'


class BranchUtils
  include Singleton
  attr_accessor :jsx

  def initialize
    @_react = {}

    @port = (20000 + rand(1000)).to_s

    @pid = fork do
      exec 'node', '--max_old_space_size=4096',File.dirname(__FILE__) + '/_render.js', @port
    end
    sleep 1
  end

  def bundle(content)
    _node("bundle", content)
  end

  def react(content)
    if @_react[content] then
      @_react[content]
    else
      @_react[content] = _node("react", _to_jsx(Nokogiri::XML(content).children[0]))
    end
  end


  def _node(type, data)
    req = Net::HTTP::Post.new '/'

    req.body = JSON.generate({ :type => type, :data => data })
    res = Net::HTTP.start('localhost', @port) do |http|
      http.request req
    end
    res.body
  end

  def _to_jsx(content)
    attr_translate = { "for" => "htmlFor", "class" => "className" }

    if content.text? then
      "{" + ("" + content).to_json + "}"
    elsif content.element?
      res = "<" + content.name + (content.attributes.map { |_, attr|
        ' ' + (attr_translate[attr.name] or attr.name) + '=' + (attr.value.start_with?('json:') ? '{' + attr.value[5..-1] + '}' : attr.value.to_json)
      }.join '')

      if content.children.count then
        res + '>' + (content.children.map { |child| _to_jsx(child) }.join '') + '</' + content.name + '>'
      else
        res + ' />'
      end
    else
      ""
    end
  end

  def json_property(obj)
    doc = Nokogiri::XML "<root></root>"
    doc.root.content = JSON.generate(obj)
    '"json:' + doc.root.inner_html.gsub('"', '&quot;') + '"'
  end
end
