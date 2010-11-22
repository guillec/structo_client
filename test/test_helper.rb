dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift dir + '/../lib'
$LOAD_PATH
$TESTING = true
require 'test/unit'
require 'rubygems'
require 'yaml'
require 'structo_record'
require 'structo_exceptions'
APP_CONFIG = YAML.load_file("#{dir}/config_test.yml")
STRUCTO_APP_NAME = APP_CONFIG['structo']['name']
STRUCTO_PUBLIC_KEY = APP_CONFIG['structo']['public_key']
STRUCTO_PRIVATE_KEY = APP_CONFIG['structo']['private_key']

##
# test/spec/mini 3
# http://gist.github.com/25455
# chris@ozmm.org
#
def context(*args, &block)
  return super unless (name = args.first) && block
  require 'test/unit'
  klass = Class.new(defined?(ActiveSupport::TestCase) ? ActiveSupport::TestCase : Test::Unit::TestCase) do
    def self.test(name, &block)
      define_method("test_#{name.gsub(/\W/,'_')}", &block) if block
    end
    def self.xtest(*args) end
    def self.setup(&block) define_method(:setup, &block) end
    def self.teardown(&block) define_method(:teardown, &block) end
  end
  (class << klass; self end).send(:define_method, :name) { name.gsub(/\W/,'_') }
  klass.class_eval &block
end
