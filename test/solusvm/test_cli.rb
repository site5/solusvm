require 'test_helper'
require 'solusvm/cli'

class TestCLI < Test::Unit::TestCase

  def setup
    # Prevents mocha from stubbing non existent methods so that we now if the CLI is failing because
    # something was moved around.
    Mocha::Configuration.prevent(:stubbing_non_existent_method)
  end

  def test_should_print_version
    $stdout.expects(:puts).with(SolusVM::VERSION)
    SolusVM::CLI.start %W(version)
  end

end
