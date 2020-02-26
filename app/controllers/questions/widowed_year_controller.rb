module Questions
  class WidowedYearController < QuestionsController
    layout "question"

    def section_title
      "Personal Information"
    end

    def self.show?(intake)
      intake.widowed_yes?
    end

    def illustration_path; end
  end
end
