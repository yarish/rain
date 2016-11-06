require 'ci/reporter/rake/rspec'

require_relative 'lib/stack_lifecycle'
require_relative 'lib/print_module'

desc "describe. For e.g.: rake describe[/Users/krishman/development/products/rain/spec/test-stack,dev]"
task :describe, [:artifacts_path, :environment] do |t, args|
  stack = StackLifecycle.new(args.artifacts_path, args.environment)
  puts PrintModule.print_metadata(stack.metadata)
end

desc "List current stack status"
task :list, [:artifacts_path] do |t, args|
  path = args.artifacts_path || File.dirname(__FILE__)
  stack = StackLifecycle.new(path)
  puts PrintModule.print_stack_description(stack.list)
end

desc "process"
task :process, [:artifacts_path] do |t, args|
  path = args.artifacts_path || File.dirname(__FILE__)
  stack = StackLifecycle.new(path)
  stack.process!
end


begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)

rescue LoadError
  # no rspec available
end

task :spec => 'ci:setup:rspec'