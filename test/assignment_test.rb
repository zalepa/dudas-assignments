require_relative('../lib/dudas/assignment')
require 'pp'


a = Dudas::Assignment.new(File.read './fixtures/easy-assignment.xml')
pp a.to_hash
