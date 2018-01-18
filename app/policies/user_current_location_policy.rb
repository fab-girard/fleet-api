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
class UserCurrentLocationPolicy
  attr_reader :current_user, :current_location

  def initialize(current_user, current_location)
    raise Pundit::NotAuthorizedError unless current_location
    @current_user = current_user
    @current_location = current_location
  end

  def show?
    same_company?
  end

  private

  def same_company?
    @current_user && @current_location.company == @current_user.company
  end
end
