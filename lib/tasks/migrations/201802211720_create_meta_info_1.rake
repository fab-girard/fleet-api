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
namespace :mapotempo_fleet do

  desc 'Create meta info 1'
  task :_201802211720_create_meta_info_1, [] => :environment do |_task, _args|

    MIGRATION_NAME = '201802211720_create_meta_info_1'.freeze
    SERVER_VERSION = 1
    MINIMAL_CLIENT_VERSION = 1

    if SchemaMigration.find_by(MIGRATION_NAME)
       p 'migration aborted, reason : already executed'
       next
    end
    mi = MetaInfo.last

    if mi
      mi.update(server_version: SERVER_VERSION, minimal_client_version: MINIMAL_CLIENT_VERSION)
    else
      MetaInfo.create(server_version: SERVER_VERSION, minimal_client_version: MINIMAL_CLIENT_VERSION)
    end

    SchemaMigration.create(migration: MIGRATION_NAME, date: DateTime.now.to_s)
  end
end