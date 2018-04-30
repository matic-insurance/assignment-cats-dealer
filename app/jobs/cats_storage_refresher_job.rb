class CatsStorageRefresherJob < ApplicationJob
  queue_as :default

  def perform
    new_cats = fetch_new_records

    Cat.transaction do
      delete_old_records
      Cat.import new_cats
    end

    new_cats.count
  end

  private

  def delete_old_records
    Cat.delete_all
  end

  def fetch_new_records
    CatsServices::FetchService.all
  end
end
