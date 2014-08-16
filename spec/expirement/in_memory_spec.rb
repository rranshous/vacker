require_relative '../../lib/expirement/in_memory.rb'

describe Expirement::InMemory do

  let(:expirement_class) { Expirement.dup }
  subject { expirement_class.new }

  before do
    expirement_class.instance_eval { prepend Expirement::InMemory }
  end

  it "should add ID to new expirements" do
    expect(subject).not_to eq nil
  end

  context "Many have been created" do
    let(:all_expirements) { [expirement_class.new] * 10 }
    let(:expirement) { all_expirements.first }
    before { all_expirements }
    it "should allow access to previously created by id" do
      expect(expirement_class.find(expirement.id)).to eq expirement
    end
  end
end
