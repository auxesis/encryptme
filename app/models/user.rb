class User < ApplicationRecord
  has_secure_password
  include ActiveStash::Search
  stash_index :name, :email, :dob
  encrypts :name, :email, :dob
end
