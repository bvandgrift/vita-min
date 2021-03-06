require "rails_helper"

RSpec.describe Questions::JobCountController do
  let(:intake) { create :intake }

  before do
    allow(subject).to receive(:user_signed_in?).and_return(true)
    allow(subject).to receive(:current_intake).and_return(intake)
  end

  describe "#edit" do
    context "when user not signed in" do
      before do
        allow(subject).to receive(:user_signed_in?).and_return(false)
      end

      it "redirects to ID.me login page" do
        get :edit

        expect(response).to redirect_to(identity_questions_path(after_login: job_count_questions_path))
      end
    end
  end

  describe "#update" do
    context "with valid params" do
      let(:params) do
        {
          job_count_form: {
            job_count: "3"
          }
        }
      end

      before do
        allow(subject).to receive(:send_mixpanel_event).and_return(true)
      end

      it "saves data to the model" do
        post :update, params: params

        expect(intake.reload.job_count).to eq 3
      end

      it "calls send_mixpanel_event with the right data" do
        post :update, params: params

        expect(subject).to have_received(:send_mixpanel_event).with(event_name: "question_answered", data: { job_count: "3" })
      end
    end
  end
end

