class ArticlesController < ApplicationController
  before_action :init_presenter

  def index; end
  def show; end
  def new; end
  def edit; end

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
    respond_to do |format|
      if @presenter.article.update(article_params)
        format.html { redirect_to @presenter.article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @presenter.article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @presenter.article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

  def init_presenter
    set_article
    @presenter = ArticlePresenter.new(current_user, @article)
  end

  def set_article
    @article = Article.find_by(id: params[:id]) || Article.new(article_params)
  end

  def article_params
    { user: current_user }.merge(params[:article]&.permit(:user_id, :title) || {})
  end
end
