def model_fields(model)
  model.column_names
end

def models
  Rails.application.eager_load!
  ApplicationRecord.descendants
end

def secured_by_active_stash?(fields)
  fields.include?("stash_id")
end

def name_rules
  [
    { name: "name", display_name: "names", column_names: ["name"] },
    { name: "last_name", display_name: "last names", column_names: ["lastname", "lname", "surname"] },
    { name: "phone", display_name: "phone numbers", column_names: ["phone", "phonenumber"] },
    { name: "date_of_birth", displayname: "dates of birth", column_names: ["dateofbirth", "birthday", "dob"] },
    { name: "postal_code", display_name: "postal codes", column_names: ["zip", "zipcode", "postalcode"] },
    { name: "oauth_token", display_name: "OAuth tokens", column_names: ["accesstoken", "refreshtoken"] },
  ]
end

def suspected_personal_data(model)
  fields = model_fields(model)
  matches = {}
  fields.each do |field|
    suspects = name_rules.select { |rule| rule[:column_names].include?(field) }
    if suspects.size > 0
      matches[field] ||= []
      matches[field] << suspects
    end
  end
  matches
end

namespace :active_stash do
  desc "audit your data"
  task :audit => [:environment] do
    models.each do |model|
      p [model.name, suspected_personal_data(model)]
    end
    exit
  end
end
