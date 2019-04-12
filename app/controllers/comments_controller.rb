class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user,     except: [:create, :destroy]
  before_action :get_comment,    only:    :destroy
  before_action :correct_user,   only:    :destroy

  def create
    @property = Property.find(params[:property_id])
    @comment  = current_user.comments.build(property: @property,
                                            comment: params[:comment][:comment])
    if @comment.save
      flash[:success] = "Comment created! It will be visible to all users " +
                        "once we verify and approve the details."
      redirect_to @property
    else
      @comments = []
      render 'properties/show'
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "Comment deleted!"
    redirect_to @comment.property
  end

  def properties_with_unapproved_comments
    @properties = Property.joins(:comments)
                          .where(comments: { approved: false })
                          .distinct
                          .paginate(page: params[:page], per_page: 12)
    @title = "Properties with unapproved comments"
    @properties_grid_col = "col-md-6 col-lg-3"
  end

  def unapproved
    @property = Property.find(params[:property_id])
    @comments = @property.comments.where(approved: false)
                                  .paginate(page: params[:page], per_page: 12)
  end

  private

    def get_comment
      @comment = current_user.comments.find_by(id: params[:id])
      if @comment.nil? && current_user.admin?
        @comment = Comment.find(params[:id])
      end
    end

    def correct_user
      redirect_to root_url if @comment.nil?
    end
end