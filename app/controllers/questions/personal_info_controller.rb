module Questions
  class PersonalInfoController < QuestionsController
    skip_before_action :require_sign_in

    def section_title
      "Household Information"
    end

    def illustration_path; end

    def tracking_data
      {}
    end
  end
end
