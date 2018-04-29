class ArticlesController < ApplicationController
  attr_reader :article
  before_action :set_article
  before_action :init_presenter

  def index; end
  def new; end
  def show;     authorize article end
  def edit;     authorize article end

  def create
    respond_to do |format|
      if @presenter.article.save
        format.html { redirect_to articles_path, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @presenter.article }
      else
        format.html { render :new }
        format.json { render json: @presenter.article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize article
    respond_to do |format|
      if @presenter.article.update(article_params)
        format.html { redirect_to @presenter.article, notice: 'Article was successfully updated.' }
        format.js { render js: 'alertify.success("Updated!")' }
      else
        format.html { render :edit }
        format.js { render js: 'alertify.error("Update failed!")' }
      end
    end
  end

  def destroy
    authorize article
    @presenter.article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

  def init_presenter
    @presenter = ArticlePresenter.new(current_user, @article, params)
  end

  def set_article
    @article = Article.find_by(id: params[:id]) || Article.new(article_params)
  end

  def article_params
    { user: current_user }.merge(params[:article]&.permit(:user_id, :title) || {})
  end
end
