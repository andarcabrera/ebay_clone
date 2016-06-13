require "tags/presenters/tag_presenter"

class TagsController < ApplicationController
  def show
    tag = Tag.find(params[:id])
    @presenter = TagPresenter.new(tag)
  end
end
