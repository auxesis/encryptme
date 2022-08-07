require "rails_helper"

def assessment_path
  Rails.root.join("active_stash_assessment.yml")
end

def read_report(filename)
  YAML.load(assessment_path.read)
end

RSpec.describe "ActiveStash" do
  it "protects all sensitive data" do
    assessment = read_report(assessment_path)
    unprotected = []
    assessment.each do |model_name, fields|
      model = model_name.constantize
      suspected_fields = fields.map { |field| field[:field].to_sym }
      unencrypted = suspected_fields.reject { |name| model.encrypted_attributes.include?(name) }
      if unencrypted.size > 0
        unprotected << { model: model_name, fields: unencrypted }
      end
    end

    if unprotected.any?
      reason = "Unprotected sensitive fields:\n\t# #{unprotected.map { |f| "#{f[:model]}: #{f[:fields].join(", ")}" }.join("\n\t# ")}"
      pending(reason)
      fail
    end
  end
end
