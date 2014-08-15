require_relative '../lib/expirement'

describe Expirement do
  subject { described_class.new }

  context "#new" do
    let(:invarients) do
      { 'desire_success' => true,
        'is_an_expirement' => 'yes',
        'expirement_count' => 0 }
    end
    let(:varients) do
      { 'may_change' => true,
        'and' => { 'how' => 1 } }
    end
    let(:status) { }
    subject { described_class.new invarients, varients }
    it 'allows you to pass invarients' do
      expect(subject.invarients).to eq invarients
    end
    it 'allows you to pass varients' do
      expect(subject.varients).to eq varients
    end
  end

  context "result" do
    context "update_result" do
      it "allows you to set a result by key and value" do
        subject.update_result :success, true
        expect(subject.result).to eq({ success: true })
      end
    end
  end

  context "log" do
    context "append_log" do
      it "allows you to add a new log message" do
        subject.append_log 'this is a log message!'
        subject.append_log 'this is another log message!'
        expect(subject.log).to eq(['this is a log message!',
                                   'this is another log message!'])
      end
    end
  end

  context "artifacts" do
    context "append_artifact" do
      let(:artifact) { {'artifact' => true } }
      it "allows you to add artifact as hash data" do
        subject.append_artifact(artifact)
        expect(subject.artifacts).to eq [artifact]
      end
    end
  end
end
