# frozen_string_literal: true
# == Schema Information
#
# Table name: conversations
#
#  id                :bigint(8)        not null, primary key
#  uri               :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_status_id  :bigint(8)
#  parent_account_id :bigint(8)
#  inbox_url         :string
#

class Conversation < ApplicationRecord
  validates :uri, uniqueness: true, if: :uri?

  belongs_to :parent_status, class_name: 'Status', optional: true
  belongs_to :parent_account, class_name: 'Account', optional: true

  has_many :statuses

  scope :local, -> { where(uri: nil) }

  def local?
    uri.nil?
  end

  def object_type
    :conversation
  end
end
