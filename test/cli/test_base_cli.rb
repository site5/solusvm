require 'test_helper'
require 'solusvm/cli'

class TestBaseCli < Test::Unit::TestCase

  def setup
    # Prevents mocha from stubbing non existent methods so that we now if the CLI is failing because
    # something was moved around.
    Mocha::Configuration.prevent(:stubbing_non_existent_method)

    @base_cli = Solusvm::BaseCli.new
    @api      = Solusvm::Base.new

    @base_cli.stubs(:api).returns(@api)
  end

  def test_should_print_multiple_lines_if_enumerable
    @api.stubs(:successful?).returns(true)
    @base_cli.expects(:say).with("val1", nil, true)
    @base_cli.expects(:say).with("val2", nil, true)

    @base_cli.output(["val1", "val2"])
  end

  def test_should_use_retry_middleware_if_retry_request
    retry_middleware =  Faraday::Request.lookup_middleware :retry

    @api = Solusvm::Base.new(solusvm_params.merge(retry_request: true))
    assert_equal @api.conn.builder[0], retry_middleware

    @api = Solusvm::Base.new(solusvm_params)
    assert_not_equal @api.conn.builder[0], retry_middleware
  end

  def test_should_print_error_if_not_successful
    @api.stubs(:successful?).returns(false)
    @api.stubs(:statusmsg).returns("the message")
    @base_cli.expects(:say).with("Request failed: the message", nil, true)

    @base_cli.output("result")
  end
end
