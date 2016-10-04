class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :upvote]
  impressionist actions: [:show], unique: [:session_hash]

  def search
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    # @articles = Article.paginate(:page => params[:page], :per_page => 5).order("created_at DESC")
    if params[:search].present?
      @articles = Article.search params[:search], page: params[:page], per_page: 20
    else
      @articles = Article.all.paginate(:page => params[:page], :per_page => 5).order("created_at DESC")
    end
  end

  def upvote
    @article = Article.find(params[:id])
    session[:voting_id] ||= request.remote_ip
    upvote = Session.find_or_create_by(ip: session[:voting_id])
    @article.upvote_by upvote
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  # def downvote
  #   @article = Article.find(params[:id])
  #   session[:voting_id] ||= request.remote_ip
  #   downvote = Session.find(ip: session[:voting_id])
  #   @article.downvote_from downvote

  #   redirect_to :back
  # end
  # GET /articles
  # GET /articles.json
  def index
    reset_session
    @articles = if params[:tag]
      Article.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5).order("created_at DESC")
    else
      Article.paginate(:page => params[:page], :per_page => 5).order("created_at DESC")
    end
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @article = Article.find(params[:id])
    impressionist(@article)
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.js
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body, :all_tags)
    end
end
