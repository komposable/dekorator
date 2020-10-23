# frozen_string_literal: true

task stats: "dekorator:statsetup"

namespace :dekorator do
  task statsetup: :environment do
    require "rails/code_statistics"

    ::STATS_DIRECTORIES << ["Decorators", "app/decorators"]
  end
end
