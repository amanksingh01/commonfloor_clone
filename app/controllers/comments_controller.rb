class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user,            except: [:create, :destroy]
  before_action :get_property,          only:   [:create, :unapproved]
  before_action :get_comment,           only:    :destroy
  before_action :get_comment_for_admin, only:   [:destroy, :approve]
  before_action :correct_user,          only:    :destroy

  def create
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
    @comments = @property.comments.where(approved: false)
                                  .paginate(page: params[:page], per_page: 12)
  end

  def approve
    @comment.approve(current_user)
    flash[:success] = "Comment approved!"
    redirect_to unapproved_property_comments_path(@comment.property)
  end

  private

    # Before filters

    # Retrieves the property from the database.
    def get_property
      @property = Property.find(params[:property_id])
    end

    # Retrieves the comment from the database.
    def get_comment
      @comment = current_user.comments.find_by(id: params[:id])
    end

    # Retrieves the comment for admin users.
    def get_comment_for_admin
      if @comment.nil? && current_user.admin?
        @comment = Comment.find(params[:id])
      end
    end

    # Checks whether the user has permission to modify comments.
    def correct_user
      redirect_to root_url if @comment.nil?
    end
end