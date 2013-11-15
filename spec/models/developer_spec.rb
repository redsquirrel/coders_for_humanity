require 'spec_helper'

describe Developer do

  subject(:developer) { create(:developer) }

  it { should belong_to(:account) }
  it { should have_many(:collaborations) }
  it { should have_many(:projects) }
  it { should have_many(:roles) }
  it { should have_many(:given_feedbacks) }
  it { should have_many(:received_feedbacks) }

  its(:github_url) { should eq "www.github.com" }
  its(:name) { should eq "John Doe" }
  its(:email) { should eq "john.doe@email.com" }
  its(:organization) { should eq "oliwi" }
  its(:location) { should eq "Chicago" }


end
