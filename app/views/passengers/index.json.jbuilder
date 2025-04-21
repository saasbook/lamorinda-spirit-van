# frozen_string_literal: true

json.array! @passengers, partial: "passengers/passenger", as: :passenger
