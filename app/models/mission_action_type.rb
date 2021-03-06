# Copyright © Mapotempo, 2017
#
# This file is part of Mapotempo.
#
# Mapotempo is free software. You can redistribute it and/or
# modify since you respect the terms of the GNU Affero General
# Public License as published by the Free Software Foundation,
# either version 3 of the License, or (at your option) any later version.
#
# Mapotempo is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the Licenses for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with Mapotempo. If not, see:
# <http://www.gnu.org/licenses/agpl.html>
#

# == Schema Information
#
# {
#   "type": "mission_action_type",
#   "_id": "mission_action_type-XXXX"
#   "company_id": "company-XXXXX_XXXXX_XXXX_XXXXX",
#   "previous_mission_status_type_id": "status_pending"
#   "next_mission_status_type_id": "status_completed"
#   "label": "To pending",
#   "group": "default"
# }
#

class MissionActionType < ApplicationRecord

  # == Attributes ===========================================================
  attribute :group, type: String
  attribute :label, type: String

  # == Extensions ===========================================================
  include TouchableConcern

  # == Relationships ========================================================
  belongs_to :company

  belongs_to :previous_mission_status_type,
             class_name: MissionStatusType
  belongs_to :next_mission_status_type,
             class_name: MissionStatusType

  # == Validations ==========================================================
  validates_presence_of :company_id
  validate :company_id_immutable, on: :update

  validates_presence_of :previous_mission_status_type_id
  validates_presence_of :next_mission_status_type_id

  # == Views ===============================================================
  view :all
  view :by_company, emit_key: :company_id

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

  include TouchableConcern

  private

  def company_id_immutable
    if company_id_changed?
      errors.add(:company_id, I18n.t('couchbase.errors.models.mission_status_type.company_id_immutable'))
    end
  end
end
