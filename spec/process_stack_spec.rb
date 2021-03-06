require_relative '../lib/independent_stack'

base_path = File.dirname(__FILE__)
stack_artifacts_path = File.join(base_path, 'test-stack-process')
stack = IndependentStack.new(stack_artifacts_path)
client = Aws::CloudFormation::Client.new(region: 'ap-south-1')

stack_name = 'test-stack-process'

RSpec.describe IndependentStack do

  after(:each) do
    delete_stack(stack_name, client)
  end

  it 'for create action, the stack is created if it does not exist' do
    client.delete_stack(stack_name: stack_name)
    stack.process!

    stack_resource = Aws::CloudFormation::Resource.new(client: client)
    created_stack = stack_resource.stack(stack_name)
    created_stack.wait_until(max_attempts: 10, delay: 5) { |stack| stack.stack_status == 'CREATE_COMPLETE' }

    expect(created_stack.stack_status).to eql 'CREATE_COMPLETE'
  end
end

