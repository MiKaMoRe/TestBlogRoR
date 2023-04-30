require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to belong_to :author }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :description }
end
