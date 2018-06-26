require 'rails/generators'
require 'rails/generators/migration'
require 'active_record'
require 'rails/generators/active_record'
require 'generators/job_packs/migration'
require 'generators/job_packs/migration_helper'

module JobPacks
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      include JobPacks::Generators::MigrationHelper
      extend JobPacks::Generators::Migration

      source_root File.expand_path('templates', __dir__)

      def copy_migration
        migration_template 'install.rb', 'db/migrate/install_job_packs.rb'
      end
    end
  end
end
