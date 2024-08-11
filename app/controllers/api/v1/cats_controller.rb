# frozen_string_literal: true

module Api
  module V1
    class CatsController < ApplicationController
      def best_deal
        service = build_cat_service
        best_deal = service.find_best_deal

        if best_deal
          render json: best_deal.to_h, status: :ok
        else
          render json: { error: 'No cats available' }, status: :not_found
        end
      end

      def index
        service = build_cat_service
        all_cats = service.fetch_all_cats

        if all_cats.any?
          render json: all_cats.map(&:to_h), status: :ok
        else
          render json: { error: 'No cats available' }, status: :not_found
        end
      end

      private

      def build_cat_service
        fetchers = [
          Fetchers::HappyCatsFetcher.new,
          Fetchers::CatsUnlimitedFetcher.new,
        ]

        CatService.new(fetchers)
      end
    end
  end
end
