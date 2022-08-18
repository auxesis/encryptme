class User < ApplicationRecord
  has_secure_password
  include ActiveStash::Search
  attribute :dob, :date
  stash_index :name, :email
  stash_index :dob, only: :range
  stash_index :title, :gender, only: :exact
  encrypts :name, :email, :gender, :title
end
