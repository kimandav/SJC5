require_relative '../spec_helper.rb'
require_relative '../../bin/package-process.rb'

class ProcMetrics
  at_exit do
    @@autorun = false
  end
end

describe 'Handlers' do
  before do
    @stats = ProcMetrics.new
  end

#  describe '#netstat' do
#    it 'should collect process ports' do
#      processmap = @stats.netstat('tcp')
#      expect(processmap).not_to be_empty
#    end
#  end

#  describe '#_convert_ipv4_port' do
#    it 'should covert Hex string to ipaddress and port' do
#      l_addr, l_port = ProcMetrics.new._convert_ipv4_port('0100007F:170D')
#      expect(l_addr).to eq('127.0.0.1')
#      expect(l_port).to eq(5901)
#    end
#  end

#  describe '#_convert_ipv6_port' do
#    it 'should convert hex string to decimal port' do
#      l_addr, l_port = ProcMetrics.new._convert_ipv6_port('21DA00D300002F3B02AA00FFFE289C5A:170D')
#      expect(l_addr).to eq('21DA00D300002F3B02AA00FFFE289C5A')
#      expect(l_port).to eq(5901)
#    end
#  end

#  describe '#_get_pid_of_inode' do
#    it 'should get pid' do
#      content = File.readlines('/proc/net/tcp').drop(1)
#      if content.length != 0
#        inode = content[1].split[9]
#        pid = ProcMetrics.new._get_pid_of_inode(inode)
#        expect(pid).not_to be_empty
#      end
#    end
#  end

  describe '#run' do
    it 'should collect process metrics' do
      allow(ProcMetrics).to receive(:output).and_return('')
      expect_any_instance_of(ProcMetrics).to receive(:output).at_least(:once)
      @stats.run
    end
  end
end
