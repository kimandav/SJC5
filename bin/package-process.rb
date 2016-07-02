#!/usr/bin/env ruby
#
# copyright 2016 Udaya Bhaskar Reddy Panditi <upanditi@cisco.com>
#
# Released under the same terms as Sensu (the MIT license); see LICENSE
# for details.
#
# This is the Plugin to collect process packages including ports,
#
#
require 'sensu-plugin/metric/cli'
require 'socket'
# require 'set'
require 'etc'

#
# Proc Metrics
#
# /proc/[PID]/status memory packages plugin
#
class ProcMetrics < Sensu::Plugin::Metric::CLI::Graphite
  option :scheme,
         description: 'Metric naming scheme',
         long: '--scheme SCHEME',
         default: "#{Socket.gethostname}.packages"

  def acquire_stats_for_process
    packages = []
    puts RUBY_PLATFORM

    if RUBY_PLATFORM =~ /linux/
      if File.exist?('/etc/redhat-release') || File.exist?('/etc/centos-release')
        cmd = `rpm -qa --queryformat '%{name}-%{version}-%{release}.%{arch}  %{name} %{version} %{vendor} %{installtime} (%{installtime:date})\n'`
        cmd1 = cmd.lines.each do |line|
          fullpackage, name, version, vendor, installtime, date = line.split(' ', 6)
          date = date.chomp("\n")
          out = {
            'fullpackage' => fullpackage,
            'name' => name,
            'version' => version,
            'vendor' => vendor,
            'installtime' => installtime,
            'date' => date
          }
          packages << out
        end
      elsif File.exist?('/etc/debian_version')
        cmd = `dpkg-query -W -f='${Package}-${version} ${package} ${version} ${Maintainer} ${installtime} ${date}\n'`
        cmd.lines.each do |line|
          fullpackage, name, version, vendor, installtime, date = line.split
          out = {
            'fullpackage' => fullpackage,
            'name' => name,
            'version' => version,
            'vendor' => vendor,
            'date' => 'null'
          }
          packages << out
        end

      end
    elsif RUBY_PLATFORM =~ /mingw32/
      cmd = `wmic product get name,version,vendor,installdate /format:csv\n`
      cmd.lines.each do |line|
        host, date, name, vendor, version = line.split(',')
        out = {
          'date' => date,
          'name' => name,
          'version' => version,
          'vendor' => vendor
        }
        packages << out
      end
    end
   packages
  end

  def run
    mem = acquire_stats_for_process
    timestamp = Time.now.to_i
    mem.each do |package|
      package.each do |k, v|
        output [config[:scheme],package["name"], k ].join('.'),  v, timestamp
#        output "#{config[:scheme]}.#{k},value".join('.'), v, timestamp
#        end     
      end
    end
  end
end
