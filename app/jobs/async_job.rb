# frozen_string_literal: true

class AsyncJob < ApplicationJob
  queue_as :default

  def perform(klass:, method:, args: nil)
    klass.constantize.public_send(method, args) if args

    klass.constantize.public_send(method)
  end
end
