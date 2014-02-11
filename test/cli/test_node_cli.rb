require 'test_helper'
require 'solusvm/cli'

class TestNodeCLI < Test::Unit::TestCase

  def setup
    # Prevents mocha from stubbing non existent methods so that we now if the CLI is failing because
    # something was moved around.
    Mocha::Configuration.prevent(:stubbing_non_existent_method)
  end

  def test_should_delegate_node_available_ips_to_node
    SolusVM::Node.expects(:new).with(solusvm_params).returns(mock do
      expects(:successful?).returns(true)
      expects(:available_ips).with("thevserverid").returns("theips")
    end)

    $stdout.expects(:puts).with("theips")
    SolusVM::CLI.start(cli_expand_base_arguments(["node", "available-ips", "thevserverid"]))
  end

  def test_should_delegate_node_stats_to_node
    SolusVM::Node.expects(:new).with(solusvm_params).returns(mock do
      expects(:successful?).returns(true)
      expects(:statistics).with("thevserverid").returns("thestats")
    end)

    $stdout.expects(:puts).with("thestats")
    SolusVM::CLI.start(cli_expand_base_arguments(["node", "stats", "thevserverid"]))
  end

  def test_should_delegate_node_xenresources_to_node
    SolusVM::Node.expects(:new).with(solusvm_params).returns(mock do
      expects(:successful?).returns(true)
      expects(:xenresources).with("thevserverid").returns("theresources")
    end)

    $stdout.expects(:puts).with("theresources")
    SolusVM::CLI.start(cli_expand_base_arguments(["node", "xenresources", "thevserverid"]))
  end

  def test_should_delegate_node_virtualservers_to_node
    SolusVM::Node.expects(:new).with(solusvm_params).returns(mock do
      expects(:successful?).returns(true)
      expects(:virtualservers).with("thevserverid").returns("thedata")
    end)

    $stdout.expects(:puts).with("thedata")
    SolusVM::CLI.start(cli_expand_base_arguments(["node", "virtualservers", "thevserverid"]))
  end

  def test_should_delegate_nodes_list_to_node
    SolusVM::Node.expects(:new).with(solusvm_params).returns(mock do
      expects(:successful?).returns(true)
      expects(:list).with("type").returns("thenodes")
    end)

    $stdout.expects(:puts).with("thenodes")
    SolusVM::CLI.start(cli_expand_base_arguments(["node", "list", "type"]))
  end

  def test_should_delegate_nodes_ids_to_node
    SolusVM::Node.expects(:new).with(solusvm_params).returns(mock do
      expects(:successful?).returns(true)
      expects(:ids).with("type").returns("thenodes")
    end)

    $stdout.expects(:puts).with("thenodes")
    SolusVM::CLI.start(cli_expand_base_arguments(["node", "list-ids", "type"]))
  end

end
