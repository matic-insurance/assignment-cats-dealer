class SearchController < ApplicationController
  include SearchHelper

  def new
    @search_form = SearchForm.new
  end

  def create
    @search_form = SearchForm.new(search_params)

    if @search_form.valid?
      result = SearchService.new(search_params: search_params).perform
      redirect_to search_redirection_path(result)
    else
      render :new
    end
  end

  def result
    search_result = SearchService.new(search_id: params[:search_id]).result

    if search_result.items.any?
      @result = SearchResultRepresenter.new(search_result)
    else
      redirect_to search_empty_result_path(params[:search_id])
    end
  end

  def empty_result; end

  private

  def search_params
    params.require(:search).permit(:cats_type, :user_location)
  end
end
