require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe State do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :abbrev => "value for abbrev",
      :unicameral => false,
      :fips_code => 9999
    }
  end

  it "should create a new instance given valid attributes" do
    State.create!(@valid_attributes)
  end

  it "should not allow duplicate fips codes" do
    State.create!(@valid_attributes)
    invalid_state = State.create(@valid_attributes)
    invalid_state.should_not be_valid
  end

  it "should show unsupported states" do
    state_u = State.create!(@valid_attributes)
    State.unsupported.should include state_u
  end
  
  it "should show supported states" do
    state_s = State.create!(@valid_attributes.merge(:launch_date => 2.days.ago))
    State.supported.should include state_s
  end

  it "should show pending states" do
    state_p = State.create!(@valid_attributes.merge(:launch_date => 2.days.from_now))
    State.pending.should include state_p
  end

end
