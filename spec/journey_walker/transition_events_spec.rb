require_relative '../spec_helper'
require_relative '../../lib/journey_walker/journey_error'
require 'json'

#
# The config loaded here is of the form
#
# state1 --> state2
#
# The single transition between state one and two expects a call to be made to update a number
#
describe JourneyWalker::Journey do
  let(:config) do
    JSON.parse(File.read('spec/journey_walker/config/transition_events.json'), symbolize_names: true)
  end
  let(:journey) { described_class.new(config) }

  it 'should raise an error when a non-defaulted parameter is missing' do
    current_state = journey.start
    JourneyWalkerTests.update_numeric_class_value(1)
    expect { journey.perform_action(current_state[:name], 'save', action_params: {}) }
      .to raise_error(JourneyWalker::JourneyError)
  end

  it 'should execute the event data source call' do
    current_state = journey.start
    JourneyWalkerTests.update_numeric_class_value(1)
    expect(JourneyWalkerTests.new(nil).fetch_numeric_value).to eq(1)
    current_state = journey.perform_action(current_state[:name], 'save', action_params: { my_action_param: 3 })
    expect(current_state[:name]).to eq('state1')
    expect(JourneyWalkerTests.new(nil).fetch_numeric_value).to eq(3)
  end
end
