require "spec_helper"

describe Signature do
  describe "callbacks" do

    subject(:signature) { FactoryGirl.build(:signature) }

    describe "sign_change_org" do

      let(:change_petition) { double(:change_petition) }

      def stub_production_boolean(bool)
        Rails.env.stub(:production?).and_return(bool)
      end

      def stub_change_petition
        ChangePetition.stub(:new).and_return(change_petition)
      end

      before do
        stub_production_boolean(production?)
        stub_change_petition
      end

      context "when in production" do
        let(:production?) { true }

        it "signs the change petition" do
          expect(change_petition).to receive(:sign).with(signature)
          signature.save
        end
      end

      context "when not in production" do
        let(:production?) { false }

        it "does not sign the change petition" do
          expect(change_petition).not_to receive(:sign).with(signature)
          signature.save
        end
      end
    end
  end
end